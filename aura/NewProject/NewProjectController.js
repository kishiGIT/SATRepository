({
    recordUpdate : function(component, event, helper) {
        var eventParams = event.getParams();
        if(eventParams.changeType === "LOADED") {
            var recordId=component.get("v.recordId");
            var accName = component.get('v.OpportunityFields.Account.Name');
          //  var oppName = component.get('v.OpportunityFields.Name');
            var oppIndustry = component.get('v.OpportunityFields.Industry__c');
            var existingProjectCode = component.get('v.OpportunityFields.Project_Code__c');
            var newProjectCode; 
			var newOppName;
           	if(!$A.util.isUndefinedOrNull(accName) && !$A.util.isEmpty(accName)){
                if(accName.length > 6){
                    newProjectCode = accName.slice(0, 6).toUpperCase();
                }else{
                    newProjectCode = accName.toUpperCase();
                }

            }
            var industryName;
            if(!$A.util.isUndefinedOrNull(oppIndustry) && !$A.util.isEmpty(oppIndustry)){
                industryName = oppIndustry.slice(0, 4).toUpperCase();
            }
            newProjectCode = newProjectCode +'-'+ industryName;
            component.set('v.newProjectCode',newProjectCode);
            helper.getProjectCode(component, event, helper,oppIndustry);
          // component.set('v.newProjectCode',newProjectCode);

        }else{
            console.log('error');
        }
    },
    
    handleSuccess : function(component, event, helper) {
        var payload = event.getParams().response;
        console.log('Id of rec'+payload.id);
        
    },
    handleLoad : function(component, event, helper) {
        //alert('form Loaded');
         component.set("v.loadSpinner", false);   
    },
    handleSubmit : function(component, event, helper) {   
        event.preventDefault();
        var eventFields = event.getParam("fields"); 
        var industryName;

       // var newProjCode = component.get('v.newProjectCode').toString();
        //eventFields['Project_Code__c'] = newProjCode;
        //eventFields['StageName'] = component.get('v.OpportunityFields.StageName');
        //eventFields['CloseDate'] = component.get('v.OpportunityFields.CloseDate');
        console.log('Compelte Result='+JSON.stringify(eventFields));   
        var oppIndustry = eventFields['Industry__c'];
        helper.createNewOpportunity(component, event, helper, eventFields);

       // component.find("inputMccForm").submit(eventFields); 
    },
    handleError :function(component, event, helper) {
        var errors = event.getParams();
        console.log("response", JSON.stringify(errors));
    },
    industryChange : function(component, event, helper) {
        var oppIndustry = component.find("industry").get("v.value");
        var accName = component.get('v.OpportunityFields.Account.Name');
        if(!$A.util.isUndefinedOrNull(accName) && !$A.util.isEmpty(accName)){
            if(accName.length > 6){
                accName = accName.slice(0, 6).toUpperCase();
            }else{
                accName = accName.toUpperCase();
            }
        }
        var industryName;
        if(!$A.util.isUndefinedOrNull(oppIndustry) && !$A.util.isEmpty(oppIndustry)){
            industryName = oppIndustry.slice(0, 4).toUpperCase();
        }
        var newProjectCode = accName +'-'+ industryName;
        component.set('v.newProjectCode',newProjectCode);
        helper.getProjectCode(component, event, helper,oppIndustry);
    },
})