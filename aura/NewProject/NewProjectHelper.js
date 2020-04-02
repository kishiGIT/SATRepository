({  
    getProjectCode: function(component, event, helper, accIndustry) {
        //var existingProjectCode = component.get('v.OpportunityFields.Project_Code__c');
        //var existingReqCode = existingProjectCode.slice(-3);//last 3 digit for exsisting code.
        var action = component.get('c.generateProjectCode');
        action.setParams({
            "accId": component.get('v.OpportunityFields.AccountId'),
            "accIndustry":accIndustry
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            //component.set("v.loadSpinner", false);
            if (state === 'SUCCESS' && component.isValid()) {
                var resp = response.getReturnValue();
                console.log('resp*****'+resp);
                var existingProjCode = component.get('v.newProjectCode');
                var newProjCode = resp;
                console.log('newProjCode'+newProjCode);
                if(newProjCode < 10){
                    newProjCode = '000'+newProjCode.toString();
                }else if(newProjCode >= 10 && newProjCode < 100){
                    newProjCode = '00' +  newProjCode.toString();
                }else if(newProjCode >= 100 && newProjCode <1000){
                    newProjCode = '0'+newProjCode;
                }else{
                    newProjCode= newProjCode;
                }
                var newProNum = existingProjCode +'-' +newProjCode + '-'+ '000';
                console.log('newProNum'+newProNum);
                component.set('v.newProjectCode',newProNum);
            }
        });
        $A.enqueueAction(action);
    },    
    
    createNewOpportunity: function(component, event, helper, eventFields) {
        var action = component.get('c.createOpp');//calling apex class
        action.setParams({
            "newRec": eventFields
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            //component.set("v.loadSpinner", false);
            if (state === 'SUCCESS' && component.isValid()) {
                var resp = response.getReturnValue();
                if (resp.startsWith('Error')) {
                    var errorMSg = resp.split('Error')[1];
                    component.set("v.errorMsg", errorMSg);
                } else {
                    var OppId = resp;
                    helper.redirectToSobject(component, event, helper, OppId);
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    redirectToSobject: function(component, event, helper, recId) {
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": recId,
            "slideDevName": "related"
        });
        navEvt.fire();
    }
})