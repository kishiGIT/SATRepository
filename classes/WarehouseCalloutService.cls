public with sharing class WarehouseCalloutService {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    // complete this method to make the callout (using @future) to the
    // REST endpoint and update equipment on hand.
    @Future(callout=true)
    public static void runWarehouseEquipmentSync (){
       List<Product2> lstOfEqup = new List<Product2>();
       Http http=new Http();
       HttpRequest request=new HttpRequest();
       request.setEndpoint(WAREHOUSE_URL);
       request.setMethod('GET');
       HttpResponse response=http.send(request);
       
       if(response.getStatusCode()==200){
         List<Json2Apex> lstOfEquipments =(List<Json2Apex>) JSON.deserialize(response.getBody(), List<Json2Apex>.class);
       for(Json2Apex inst : lstOfEquipments){
                Product2 prod = new Product2();
                prod.Cost__c = inst.cost;
                prod.Lifespan_Months__c = inst.lifespan;
                prod.Maintenance_Cycle__c = inst.maintenanceperiod;
                prod.Name = inst.name;
                prod.Current_Inventory__c = inst.quantity;
                prod.Replacement_Part__c = inst.replacement;
                prod.Warehouse_SKU__c = inst.sku;
                
                lstOfEqup.add(prod);
            }
        }
        
        if(lstOfEqup != null && lstOfEqup.size() > 0){
            UPSERT lstOfEqup Warehouse_SKU__c;
        }
    }
    
    //Wrapper class for Responce details.
    private class Json2Apex{
        private String id;
        private Integer cost;
        private Integer lifespan;
        private Integer maintenanceperiod;
        private String name;
        private Integer quantity; 
        private boolean replacement;
        private String sku;          
    }

}