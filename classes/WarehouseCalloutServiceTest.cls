@isTest
private class WarehouseCalloutServiceTest {
  // implement your mock callout test here
  
  @isTest
  static void testWarehouseCalloutService(){
   test.StartTest();
   //set callout class
   Test.setMock(HttpCalloutMock.class,new WarehouseCalloutServiceMock());
   // this cause fake response to be sent
   
   WarehouseCalloutService.runWarehouseEquipmentSync();
   
   test.StopTest();
  }
}