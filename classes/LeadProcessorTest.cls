@istest
public class LeadProcessorTest{
@istest
public static void updateLeads(){
list<lead> leadLists =new list<lead>();
 for(integer i=0;i<100;i++)
 {
  lead le=new lead(lastname='test'+i,company='cmp'+i,status='Closed - Converted');
  leadLists.add(le);
 }
 insert leadLists;
 test.starttest();
  LeadProcessor l=new LeadProcessor ();
  database.executeBatch(l);
 test.stoptest();
  
}
 
}