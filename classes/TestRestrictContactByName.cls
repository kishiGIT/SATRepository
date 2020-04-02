@isTest
private class TestRestrictContactByName{
    @isTest static void testInvalidContact(){
        
        Test.startTest();
        try{
        Contact con = new Contact(LastName = 'INVALIDNAME');
        INSERT con;
        }Catch(Exception ex){
            Boolean expectedExceptionThrown =  ex.getMessage().contains('INVALIDNAME') ? true : false;
            System.assertEquals(expectedExceptionThrown, true);
        }
        Test.stopTest();
    }
}