@istest
public class AccountProcessorTest{
@istest
static void testcount(){
  list<id> accid=new list<id>(); 
  Account acc=new account(Name='test1',fax='12342');
  insert acc;
  Account acc1=new account(Name='test11',fax='1234112');
  insert acc1;
  accid.add(acc.id);
  accid.add(acc1.id);
  contact con=new contact(firstname='test1',lastname='test2',accountid=acc1.id);
  insert con;
  contact con1=new contact(firstname='test21',lastname='test22',accountid=acc.id);
  insert con1;
  test.starttest();
  AccountProcessor.countContacts(accid);
  test.stoptest();
  

}
}