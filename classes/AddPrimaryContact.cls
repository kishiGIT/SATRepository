public class AddPrimaryContact implements Queueable {
    public list<Account> accList=new list<account>();
    public AddPrimaryContact(contact con,string state){
    accList=[select id from account where BillingState like :state];
    }
    public void execute(QueueableContext context) {
       list<contact> conList=new list<contact>();
        if(accList.size()>0){
        for(account ac:accList){
          contact con=new contact();
          con.AccountId=ac.id;
          con.lastname='tst';
          conList.add(con);
        }
        insert conList;
        }
    
    }
    }