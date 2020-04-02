public class AccountProcessor{
 @future(callout=true)
 public static void countContacts(list<id> accIDs){
 list<account> acList=new list<account>();
  list<account> AccList=[select id,name,(select id,accountid from contacts) from account where id=:accIDs];
  for(account acc:AccList) {
   list<contact> conList=acc.contacts;
  acc.Number_Of_Contacts__c=conList.size();
   acList.add(acc);
  }
  update acList;
 
}
}