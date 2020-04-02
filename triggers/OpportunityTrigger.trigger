trigger OpportunityTrigger on Opportunity (after insert, after update, before insert, before update) {
    List<Task> taskList = new List<Task>(); //Creating a list for the tasks that are created once an opportunity is created.
    List<Opportunity> Opps = Trigger.new; //Creating a list of opportunities that are created newly using the trigger or based on the trigger event.
    
    if(Trigger.isInsert == true || Trigger.isUpdate == true) {
        for(Opportunity Opp : Opps) {
            if(Opp.StageName == 'Closed Won'){
                Task newTask = new Task(whatID = Opp.ID, Subject='Follow Up Test Task'); //A task is created with Opportunity ID and with the subject.
                taskList.add(newTask);
            }
        }
        insert taskList;
    }
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        Map<Id,Id> mapAccountIds = new Map<Id,Id>();
        Map<Id,Account> mapOppAccount = new Map<Id,Account>();
        
        for(Opportunity Opp : Trigger.new) {
            mapAccountIds.put(Opp.Id,opp.AccountId);
        }
        for(Account acc : [SELECT Id,Name,Industry FROM Account WHERE Id IN : mapAccountIds.values()]){
            mapOppAccount.put(acc.Id,acc);
        }
        
        for(Opportunity Opp : Trigger.new) {
            Account acc = mapOppAccount.get(Opp.accountId);
            /*if(Opp.Project_Code__c != NULL && String.isNotBlank(Opp.Industry__c)){
                List<String> lstOldProjCode = (opp.Project_Code__c).split('-');
                //String oldOppCode = lstOldProjCode.get(1);
                String newOppCode = (Opp.Industry__c).substring(0,4);
                String  newProjCode = lstOldProjCode.get(0)+ '-'+newOppCode+'-'+lstOldProjCode.get(2)+'-'+lstOldProjCode.get(3);
                Opp.Project_Code__c = newProjCode;
                system.debug('Opp.Project_Code__c******'+Opp.Project_Code__c);
            }
else{*/
            if(Opp.Project_Code__c == NULL){
                String accName = (acc.Name);
                system.debug('**************accName ******'+accName);
                String accIndustry= opp.Industry__c.toUpperCase();
                
                if(accName.length()<6){
                    accName= acc.Name;
                }else{
                    accName = (acc.Name).substring(0,6);
                }
                if(accIndustry.length()<4){
                    accIndustry = accIndustry;
                }else{
                    accIndustry= (accIndustry).substring(0,4);
                }
                Opp.Project_Code__c =  accName.toUpperCase() +'-'+accIndustry+'-' + '0001'+'-'+'000';
            }
                
            //}
        }
    }
    
}