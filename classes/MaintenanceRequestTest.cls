@isTest
private class MaintenanceRequestTest{
    @testSetup
    static void setup(){
        //Equipment SETUP
        List<Product2> lstOfEqpmnts = new List<Product2>();
        
        Product2 eqip = new Product2(Name = 'Test Equipment', 
                                     Maintenance_Cycle__c = 10,
                                     Cost__c = 100,
                                     Current_Inventory__c = 10,
                                     Lifespan_Months__c = 10,
                                     Replacement_Part__c = true,
                                     Warehouse_SKU__c = 'abc');
        lstOfEqpmnts.add(eqip);
        INSERT lstOfEqpmnts;
    }
    
    @isTest
    static void testMaintenanceRequest(){
        List<Case> lstOfInsertMRs = new List<Case>();
        
        List<Case> lstOfUpdtMRs = new List<Case>();
        
        Id equipId = [SELECT Id FROM Product2 LIMIT 1].get(0).Id;
        
        for(Integer i = 1; i <= 300; i++){
            Case mrInsert = new Case(Type = 'Routine Maintenance', Status = 'New', Origin = 'Phone');
            mrInsert.Equipment__c = equipId;
            
            lstOfInsertMRs.add(mrInsert);
        }
        
        Test.startTest();
            INSERT lstOfInsertMRs;
            
            System.assertEquals(300, lstOfInsertMRs.size());
            
            for(Case mrUpdt : lstOfInsertMRs){
                mrUpdt.Status = 'Closed';
                lstOfUpdtMRs.add(mrUpdt);
            }
            
            UPDATE lstOfUpdtMRs;
            
            System.assertEquals(300, lstOfUpdtMRs.size());
        Test.stopTest();
    }
}