public with sharing class FormInstanceController {
    
    @AuraEnabled
    public static string getFormInstanceInfo(String formInstanceId){
        Form frm = HubControllerWithoutSharing.getFormInstanceInfo(formInstanceId);
        return JSON.serialize(frm);
    }

    // @AuraEnabled
    // public static string loadFormList(String formInstanceId){
    //     //stubbed id list
    //     List < ID > idList = new List < ID >{'a0z5f000000QmPpAAK'};
    //     List < Form > formList = Form.getFormList(idList);
    //     return JSON.serialize(formList);
    // }

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

}
