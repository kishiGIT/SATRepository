global class  LeadProcessor implements Database.Batchable<sobject>{

 public Database.querylocator start(database.Batchablecontext Bc)
 {
    return Database.getquerylocator('select id,LeadSource from lead');
 }
 public void execute(Database.BatchableContext Bc,list<lead> scope)
 {
  list<lead> leadList=new list<lead>();
  for(lead le:scope){
   lead l=new lead();
   l.LeadSource='Dreamforce';
   l.id=le.id;
   leadList.add(l);
   }
   update leadList;
 }
  public void finish(Database.Batchablecontext Bc){
  }
}