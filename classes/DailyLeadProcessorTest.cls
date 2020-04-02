@isTest
public class DailyLeadProcessorTest{
public static String CRON_EXP = '0 0 0 15 3 ? 2022';
@isTest
 public static void test1(){
 integer i;
 list<lead> leadlist=new list<lead>();
   for(i=0;i<201;i++){
       lead l=new lead();
       l.Firstname='lead'+i;
       l.Lastname='le';
       l.Company='cmp'+l;
       leadlist.add(l);
  }
  insert leadlist;
  test.starttest();
    String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP, 
            new DailyLeadProcessor());         
  test.stoptest();
 }
}