({
    recordUpdate : function(component, event, helper) {
        var eventParams = event.getParams();
        if(eventParams.changeType === "LOADED") {
        /*    var recordId=component.get("v.recordId");
            var accName = component.get('v.OpportunityFields.Account.Name');
            var oppName = component.get('v.OpportunityFields.Name');
            var accIndustry = component.get('v.OpportunityFields.Account.Industry');

            var existingProjectCode = component.get('v.OpportunityFields.Project_Code__c');
            var newProjectCode; 
			var newOppName;
           	if(!$A.util.isUndefinedOrNull(accName) && !$A.util.isEmpty(accName)){
                if(accName.length > 6){
                    newProjectCode = accName.slice(0, 6).toUpperCase();
                }else{
                    newProjectCode = accName;
                }
            }
            if(!$A.util.isUndefinedOrNull(accIndustry) && !$A.util.isEmpty(accIndustry)){
                newOppName = accIndustry.slice(0, 4);
            }
            newProjectCode = newProjectCode +'-'+ newOppName + '-'+ '0001' + '-'+ '000';*/
            helper.getChangeRequestCode(component, event, helper);
            //component.set('v.newProjectCode',newProjectCode);

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
        //  component.set("v.showSpinner", false);   
    },
    handleSubmit : function(component, event, helper) {   
        event.preventDefault();
        var eventFields = event.getParam("fields"); 
        console.log('Compelte Result='+JSON.stringify(eventFields));       
        helper.createNewOpportunity(component, event, helper, eventFields);

       // component.find("inputMccForm").submit(eventFields); 
    },
    handleError :function(component, event, helper) {
        var errors = event.getParams();
        console.log("response", JSON.stringify(errors));
    },
})