public class ProjectCalloutService {
    //Complete the implementation for business and callout logic
    @InvocableMethod
    public static void postOpportunityToPMS(List<Id> oppoIds){
      Opportunity opp=[select id,name,Account.Name,CloseDate,Amount from opportunity where id=:oppoIds[0]];
      string serviceToken=ServiceTokens__c.getValues('ProjectServiceToken').Token__c;
      string JsonInput='{\n'+
         '"opportunityId":"'+opp.id+'",\n'+
         '"opportunityName":"'+opp.Name+'",\n'+
         ' "accountName" : "'+opp.Account.Name+'",\n'+
            ' "closeDate" : "'+String.ValueOf(opp.CloseDate).mid(0,10)+'",\n'+   
            ' "amount" : "'+opp.Amount+'"\n}';
           System.enqueueJob(new QueueablePMSCall(serviceToken,JsonInput,opp.id));
    }
    
    public class QueueablePMSCall implements system.Queueable,Database.AllowsCallouts { 
      private String serviceToken;
        private String jsonInput;
        private Id oppId;
      public QueueablePMSCall(string serviceToken,string jsonInput,id oppId){
        this.serviceToken=serviceToken;
        this.jsonInput=jsonInput;
        this.oppId=oppId;
      }
      
      public void execute(Queueablecontext qc){
        postToPMS(serviceToken,jsonInput,oppId);
        }
     
    }
    
    @Future(callout=true)
    private static void postToPMS(string serviceToken,string jsonInput,id oppId){
      HTTPRequest req=new HTTPRequest();
      req.setEndpoint('Callout:ProjectService');
      req.setMethod('POST');
       req.setheader('token',serviceToken);
      req.setHeader('Content-Type', 'application/json;charset=UTF-8');    
      req.setBody(JsonInput);
      Http http=new Http();
      HttpResponse res=http.send(req);
      Opportunity opp = new Opportunity(Id=oppId);
        if(res.getStatusCode() == 201){
            opp.StageName = 'Submitted Project';                
            System.debug('Success: ' + res.getStatus());
        }else{
            opp.StageName = 'Resubmit Project';
            System.debug('Failure: ' + res.getStatusCode() + ' ' + res.getStatus());
        }
        update opp;
    }
}