public with sharing class FormInstanceController {
    
    @AuraEnabled
    public static string getFormInstanceInfo(String formInstanceId){
        Form frm = HubControllerWithoutSharing.getFormInstanceInfo(formInstanceId);
        System.debug('frm: '+frm);
        return JSON.serialize(frm);
    }

    @AuraEnabled
    public static String createProjectRequest(){
        ID runningUserContactId = getCommUserContactId();
        Form frm = HubControllerWithoutSharing.createProjectRequest(runningUserContactId);
        System.debug('frm: '+frm);
        return JSON.serialize(frm);
    }

    public static ID getCommUserContactId() {
        ID userId = UserInfo.getUserId();
        User u = [SELECT Id, ContactId FROM User WHERE Id=:userId];
        return u.ContactId;
    }

    @AuraEnabled
    public static ID updateTextPickOrLookup(String instanceId, String fieldId, String dataId, String value){

        try {
            return HubControllerWithoutSharing.updateTextPickOrLookup(instanceId, fieldId, dataId, value);  
        } catch (Exception e) {
            throw new NHN_Exception('FormInstanceController.updateTextPickOrLookup', 'Could not update field value, please refresh and try again.', e);
        }
    }

    @AuraEnabled
    public static ID updateTextArea(String instanceId, String fieldId, String dataId, String value){

        try {
            return HubControllerWithoutSharing.updateTextArea(instanceId, fieldId, dataId, value);  
        } catch (Exception e) {
            throw new NHN_Exception('FormInstanceController.updateTextArea', 'Could not update field value, please refresh and try again.', e);
        }
    }

    @AuraEnabled
    public static ID updateDate(String instanceId, String fieldId, String dataId, String value){

        try {
            System.debug('value: '+value);
            return HubControllerWithoutSharing.updateDate(instanceId, fieldId, dataId, value);  
        } catch (Exception e) {
            System.debug(':throw nhn exception ');
            throw new NHN_Exception('FormInstanceController.updateDate', 'Could not update field value, please refresh and try again.', e);
        }
    }

    @AuraEnabled
    public static ID updateNumber(String instanceId, String fieldId, String dataId, String value){

        try {
            return HubControllerWithoutSharing.updateNumber(instanceId, fieldId, dataId, value);  
        } catch (Exception e) {
            throw new NHN_Exception('FormInstanceController.updateNumber', 'Could not update field value, please refresh and try again.', e);
        }
    }

    @AuraEnabled
    public static void memberFormSubmitted(String instanceId){

        try {
            HubControllerWithoutSharing.memberFormSubmitted(instanceId);  
        } catch (Exception e) {
            throw new NHN_Exception('FormInstanceController.updateNumber', 'Could not submit form, please refresh and try again.', e);
        }
    }

    @AuraEnabled
    public static string getFormInstanceStatus(String instanceId){

        try {
            Form frm = HubControllerWithoutSharing.getFormInstanceInfo(instanceId);  
            return frm.status;
        } catch (Exception e) {
            throw new NHN_Exception('FormInstanceController.updateNumber', 'Could not get status, please refresh and try again.', e);
        }
    }

    @AuraEnabled
    public static void staffDecisionMade(String instanceId, String decision){

        try {
            Form frm = new Form(instanceId); 
            if (decision=='Approved') {
                frm.approve();
            }  else if (decision=='Declined') {
                frm.decline();
            } else {
                throw new NHN_Exception('FormInstanceController.updateNumber', 'Unknown status entered.');
            }
        } catch (Exception e) {
            throw new NHN_Exception('FormInstanceController.updateNumber', 'Could not get status, please refresh and try again.', e);
        }
    }

}
