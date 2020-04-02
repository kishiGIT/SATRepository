global class BatchAuditTrial implements Database.Batchable<SObject> {
       public String query;
       String csvString  = '\n';
              
    global Database.QueryLocator start(Database.BatchableContext BC) { 
         return Database.getQueryLocator(query);
    }

      //String.valueOf( mySObject.get('Name') )

      global void execute(Database.BatchableContext BC, List<SObject> scope) {
       for(SObject t : scope){ 
        SetupAuditTrail auditTrail = (SetupAuditTrail)t;
          if (auditTrail != null){
               csvString +=  '"' + auditTrail.ID + '"'  + ',';
               csvString +=  '"' + auditTrail.Action + '"'  + ',';
               csvString +=  '"' + String.valueof(t.get('DelegateUser')) + '"'  + ',';
            //   csvString +=  '"' + String.valueof(t.get('Createdby.Name')) + '"'  + ',';
            //   csvString +=  '"' + String.valueof(t.get('CreatedDate')) + '"'  + ',';
            //   csvString +=  '"' + String.valueof(t.get('Display')) + '"'  + ',';               
            //   csvString +=  '"' + String.valueof(t.get('Section')) + '"'  + ',';
               csvString += '\n';
               System.Debug('&&&&&******' + csvString);
          }
       }
        Document d = new Document();
        d.AuthorId = UserInfo.getUserId();
        d.name = 'S_P_Vendors__c.csv';
        d.body = Blob.valueOf(csvString);
        d.folderId = UserInfo.getUserId();
        insert d;
        System.Debug('DInserted*************' + D);
    
    }

      global void finish(Database.BatchableContext info) {
        //sent mail to Admin user the batch is completed 
    }
}