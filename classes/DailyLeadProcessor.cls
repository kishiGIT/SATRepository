public class DailyLeadProcessor implements schedulable{
 
 public void execute(SchedulableContext sc){
  List<Lead> leadList=new List<lead>();
  for(Lead l:[select id from lead limit 200]){
   lead le=new lead();
   le.id=l.id;
   le.LeadSource='Dreamforce';   
   leadList.add(le);
  }
  update leadList;
  
 }
}