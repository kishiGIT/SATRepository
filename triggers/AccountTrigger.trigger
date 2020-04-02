trigger AccountTrigger on Account (before insert , before update , after insert, after update) {
    /*for(Account acc : Trigger.New) {
        if(acc.Match_Billing_Address__c){
            acc.ShippingPostalCode = acc.BillingPostalCode;
        }
    }*/
    AccountTriggerHandler ah = new AccountTriggerHandler();
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate) ){
        ah.updateAccountOperation(Trigger.new);
    }
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate) ){
        ah.afterUpdateAccountOperation(Trigger.new,Trigger.oldMap,Trigger.isUpdate);
    }
    
}