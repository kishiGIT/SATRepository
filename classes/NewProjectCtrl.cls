public class NewProjectCtrl {
 @AuraEnabled
    public static String createOpp(Opportunity newRec) {
        try{
            insert newRec;
            return newRec.Id;
        }catch(Exception ex){
            return 'Error'+ex.getMessage();
        }
    }
    @AuraEnabled
    public static Integer generateChangeRequestCode(String accId,String projCode) {
        //List<Opportunity> lstOpp ;
        List<Integer> lstChangeNumber = new List<Integer>();
        for(Opportunity opp: [SELECT Id,AccountId, Project_Code__c FROM Opportunity WHERE AccountId = :accId]){
            if(String.isNotBlank(opp.Project_Code__c)){
				//String industryType = lstOldProjCode.get(1);
                if(opp.Project_Code__c.contains(projCode)){
                    String changeCode =(opp.Project_Code__c).right(3);
                    Integer changeCodeNum  = Integer.valueOf(changeCode);
                    lstChangeNumber.add(changeCodeNum); 
               }
            }
        }
        lstChangeNumber.sort();
        system.debug('lstChangeNumber****'+lstChangeNumber);
        system.debug('Hieghest lstChangeNumber ****'+lstChangeNumber.get(lstChangeNumber.size()-1));
        Integer changeRequestNum = (lstChangeNumber.get(lstChangeNumber.size()-1))+1;
        return changeRequestNum;
    }
    @AuraEnabled
    public static Integer generateProjectCode(String accId, String accIndustry) {
        //List<Opportunity> lstOpp ;
        Integer newProjectCode = 0000;
        List<Integer> lstProjNumber = new List<Integer>();
        for(Opportunity opp : [SELECT Id,AccountId, Project_Code__c FROM Opportunity WHERE AccountId = :accId AND Industry__c =:accIndustry]){
            if(String.isNotBlank(opp.Project_Code__c)){
                List<String> lstOldProjCode = (opp.Project_Code__c).split('-');
                Integer oldProjCode  = Integer.valueOf(lstOldProjCode.get(lstOldProjCode.size()-2));
                system.debug('oldProjCode'+oldProjCode);
                lstProjNumber.add(oldProjCode);
            }
            //Integer changeCode = Integer.parseInt((opp.Project_Code__c).right(3));
        }
        if(!lstProjNumber.isEmpty()){
            lstProjNumber.sort();
            newProjectCode = lstProjNumber.get(lstProjNumber.size()-1);
            system.debug('list sort num'+newProjectCode);
        }
        newProjectCode = newProjectCode + 1;
        system.debug('after adding one newProjectCode'+newProjectCode);
        return newProjectCode;
    }
    
  /*  @AuraEnabled
    public static map<String,List<String>> getFieldsSets(){
        System.debug('getFieldSets####>');
        Map<String, Schema.FieldSet> FsMap = Schema.SObjectType.Opportunity.fieldSets.getMap();
        List<Schema.FieldSet> lstField= new List<Schema.FieldSet>();
        Schema.SObjectType sObj = Schema.getGlobalDescribe().get('Opportunity');
        Map<String,List<String>> mapFieldSet = new Map<String,List<String>>();
         System.debug('FsMap.keyset()####>' + FsMap.keyset());
        for(String fieldSetName : FsMap.keyset()) {
            List<String> lstFieldApi =new List<String>();
            for(Schema.FieldSetMember fieldMember : sObj.getDescribe().fieldSets.getMap().get(fieldSetName).getFields()){
                lstFieldApi.add(fieldMember.getFieldPath());
            }
            mapFieldSet.put(fieldSetName, lstFieldApi);
        }
        return mapFieldSet;
    } */
}