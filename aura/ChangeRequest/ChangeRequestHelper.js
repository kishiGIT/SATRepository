({
    getChangeRequestCode: function(component, event, helper, eventFields) {
        var existingProjCode = component.get('v.OpportunityFields.Project_Code__c');
        var projCode= existingProjCode.split('-')[1]+'-'+existingProjCode.split('-')[2];
        var action = component.get('c.generateChangeRequestCode');
        action.setParams({
            "accId": component.get('v.OpportunityFields.AccountId'),
            "projCode" : projCode
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            //component.set("v.loadSpinner", false);
            if (state === 'SUCCESS' && component.isValid()) {
                var resp = response.getReturnValue();
                var oldProjCode = existingProjCode.lastIndexOf('-');
                existingProjCode = existingProjCode.substring(0, oldProjCode);
                var newChangeReqCode = resp;
                if(newChangeReqCode < 10){
                    newChangeReqCode = '00'+newChangeReqCode.toString();
                }else if(newChangeReqCode >= 10 && newChangeReqCode < 100){
                    newChangeReqCode = '0' +  newChangeReqCode().toString();
                }else{
                    newChangeReqCode = newChangeReqCode;
                }
                var newChangeReqNum = existingProjCode +'-' +newChangeReqCode;
                component.set('v.newProjectCode',newChangeReqNum);
            }
        });
        $A.enqueueAction(action);
    },
    createNewOpportunity: function(component, event, helper, eventFields) {
        var action = component.get('c.createOpp');
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