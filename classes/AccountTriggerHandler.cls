public class AccountTriggerHandler {
    public void updateAccountOperation(List<Account> lstAccount){
        for(Account acc : lstAccount) {
            if(acc.Match_Billing_Address__c){
                acc.ShippingPostalCode = acc.BillingPostalCode;
            }
        }
    }
    public void afterUpdateAccountOperation(List<Account> lstAccount, Map<id,Account> oldAccountMap , Boolean isUpdate){
        Set<Id> accountSet = new Set<Id>();
        List<Opportunity> lstOpp = new List<Opportunity>();
        
        if(isUpdate){
            for(Account acc : lstAccount){
                Account olAccount = oldAccountMap.get(acc.Id);
                if(acc.Industry != NULL && acc.Industry !=olAccount.Industry ){
                    accountSet.add(acc.Id);
                }
            }
            for(Account acc : [SELECT Id,Industry FROM Account WHERE Id IN :accountSet]){
                    Opportunity opp = new Opportunity();
                    opp.Name='Test opp';
                    opp.CloseDate =Date.today();
                    opp.StageName = 'Negotation';
                    lstOpp.add(opp);
            }   
            if(!lstOpp.isEmpty()){
                insert lstOpp;
            }
            Map<Id,Opportunity> mapUpdateOpp = new Map<Id,Opportunity>();
            for(Opportunity opp  : [SELECT Id from Opportunity WHERE accountId IN : accountSet]){
                opp.StageName ='Needs Analysis';
                mapUpdateOpp.put(opp.Id, opp);
            }
            if(!mapUpdateOpp.isEmpty()){
                update mapUpdateOpp.values();
            }
        }
    }
}