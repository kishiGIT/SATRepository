@isTest
public class AddPrimaryContactTest{

  @testSetup
  static void testSetup(){
  List<Account> accounts = new List<Account>();
 
  for(integer i=0;i<100;i++){
    accounts.add(new account(name='parent'+1,BillingState='CA'));
  }
  insert accounts;
  List<Account> accList = new List<Account>();
 
  for(integer i=0;i<100;i++){
    accList .add(new account(name='parent a'+1,BillingState='NY'));
  }
  insert accList ;
  
  }
 public static testMethod void testQueueable() {
   List<Account> accounts = [select id,name from account where name like 'parent%'];
   contact con=new contact(lastname='sda');
   insert con;
   AddPrimaryContact ap=new AddPrimaryContact(con,'NY');
   Test.startTest();
    system.enqueuejob(ap);
   Test.stopTest();
  }
}