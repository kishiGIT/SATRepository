public class WarehouseSyncSchedule implements schedulable{
  // implement scheduled code here
  public void execute(schedulablecontext sc){
  WarehouseCalloutService.runWarehouseEquipmentSync() ;
  }
}