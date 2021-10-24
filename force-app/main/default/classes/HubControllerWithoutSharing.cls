
//This class is used to give visibility to records that cannot be shared with hub users via permissions.  Because it runs without sharing, methods here should be highly selective and targeted

public without sharing class HubControllerWithoutSharing {
    
    public static Form createProjectRequest(ID runningUserContactId){
        Form frm = new Form();
        frm.createProjectRequest(runningUserContactId);
        return frm;
    } 

    public static Form getFormInstanceInfo(ID formInstanceId){
        Form frm = new Form(formInstanceId);
        return frm;
    } 

}
