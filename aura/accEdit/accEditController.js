({
 handleSaveRecord: function(component, event, helper) {
        component.find("accountRecord").saveRecord($A.getCallback(function(saveResult) {            
   if (saveResult.state === "ERROR") {
                var errMsg = "";
                for (var i = 0; i < saveResult.error.length; i++) {
                    errMsg += saveResult.error[i].message + "\n";
                }
                cmp.set("v.recordSaveError", errMsg);

            } else {
                cmp.set("v.recordSaveError", "");

            }
        }));
    }
})