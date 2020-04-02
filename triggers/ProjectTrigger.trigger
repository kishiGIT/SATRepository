trigger ProjectTrigger on Project__c (after update) {
    //Call the Billing Service callout logic here
    if(Trigger.isAfter && Trigger.isUpdate){
    for(Project__c prjt:Trigger.New){
          if(prjt.Status__c != null && prjt.Status__c.equals('Billable')){
             BillingCalloutService.callBillingService(prjt.ProjectRef__c, prjt.Billable_Amount__c);
             ServiceCredentials__c srvcCrd = ServiceCredentials__c.getValues('BillingServiceCredential');
             }
       }
    }
}