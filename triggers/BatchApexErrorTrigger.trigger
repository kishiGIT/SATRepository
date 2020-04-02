trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {
    BatchLeadConvertErrors__c[] InsertErrorList = new BatchLeadConvertErrors__c[]{};
    
    //Loop over the error events
    for(BatchApexErrorEvent event: Trigger.new){
        BatchLeadConvertErrors__c tmpLog = new BatchLeadConvertErrors__c();
        tmpLog.AsyncApexJobID__c = Event.AsyncApexJobID;
        tmpLog.Records__c = Event.JobScope;
        tmpLog.stackTrace__C = Event.stackTrace;
        insertErrorlist.add(tmplog);    
    
    
    }
    
    
    //Loop over the error events
    insert InsertErrorList;

    

}