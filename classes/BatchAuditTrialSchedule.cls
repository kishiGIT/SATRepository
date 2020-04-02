global class BatchAuditTrialSchedule implements schedulable{
    global void execute (SchedulableContext SC){
        string query;
      //  query='SELECT Id, Action, DelegateUser,  CreatedDate, Display, Section FROM SetupAuditTrail Limit 5';
        query='SELECT Id, Action, DelegateUser FROM SetupAuditTrail Limit 5';
                 
                 BatchAuditTrial BatchATrial = new BatchAuditTrial();                    
                 BatchATrial.query= query; 
                 database.executebatch(BatchATrial,200);  
    } 
  
}