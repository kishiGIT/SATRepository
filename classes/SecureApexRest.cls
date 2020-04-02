@RestResource(urlMapping='/secureApexRest')
global with sharing class SecureApexRest {
    @HttpGet
    global static Contact doGet(){
        Id recordId = RestContext.request.params.get('id');
        Contact result;
        if (recordId == null){
            throw new FunctionalException('Id parameter is required');
        }
        try{
            List<Contact> results = [SELECT id, Name, Secret_Key__c FROM Contact WHERE Id = :recordId With Security_Enforced];
        }Catch(QueryException e){
            System.Debug(e.getmessage());
        }
            
      
        return result;
    }
    public class FunctionalException extends Exception{}
    
}