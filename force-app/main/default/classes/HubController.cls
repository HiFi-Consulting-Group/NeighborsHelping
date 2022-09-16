
public with sharing class HubController {
    
    public static Form createProjectRequest(ID runningUserContactId){
        Form frm = new Form();
        frm.createProjectRequest(runningUserContactId);
        return frm;
    } 

    public static Form getFormInstanceInfo(ID formInstanceId){
        Form frm = new Form(formInstanceId);
        return frm;
    } 

    public static ID updateTextPickOrLookup(String instanceId, String fieldId, String dataId, String value) {
        Form_Data__c data = new Form_Data__c(ID=dataId, Form_Instance__c=instanceId,Form_Field__c=fieldId,Text_Data__c=value);
        upsert data; 
        return data.ID; 
    }
    
    public static ID updateTextArea(String instanceId, String fieldId, String dataId, String value) {
        Form_Data__c data = new Form_Data__c(ID=dataId, Form_Instance__c=instanceId,Form_Field__c=fieldId,Long_Text_Data__c=value);
        upsert data; 
        return data.ID; 
    }

    public static ID updateDate(String instanceId, String fieldId, String dataId, String value) {
        Form_Data__c data = new Form_Data__c(ID=dataId, Form_Instance__c=instanceId,Form_Field__c=fieldId,Date_Data__c=Date.valueOf(value));
        upsert data; 
        return data.ID; 
    }

    public static ID updateNumber(String instanceId, String fieldId, String dataId, String value) {
        Form_Data__c data = new Form_Data__c(ID=dataId, Form_Instance__c=instanceId,Form_Field__c=fieldId,Numeric_Data__c=Decimal.valueOf(value));
        upsert data; 
        return data.ID; 
    }

    public static void memberFormSubmitted(String instanceId) {
        Form frm = new Form(instanceId);
        frm.submit();
    }

}
