//combines a form instance with its form structure and data

public inherited sharing class Form {

    public ID formId;
    public ID formInstanceId;
    public ID submitterId;
    public String sumbitterName;
    public String status;
    public String title;
    public String type;
    public Boolean viewerIsStaff; //If the running user is staff, they have access to additional fields
    public List < Form_Field > fields;
    
    public class Form_Field {
        public ID recordId;
        public String name;
        public String type;
        public Boolean required;
        public Boolean userVisible;
        public Boolean staffOnly;
        public Boolean volunteerOnly;
        public FormData data;

        public Form_Field(Form_Field__c fieldSobj) {
            this.recordId = fieldSobj.ID;
            this.name = fieldSobj.Name;
            this.type = fieldSobj.Type__c;
            this.required = fieldSobj.Required__c;
            this.userVisible = fieldSobj.User_Visible__c;
            this.staffOnly = fieldSobj.Staff_Only__c;
            this.volunteerOnly = fieldSobj.Volunteer_Only__c;
        }
    }

    public Form () {
        setViewerType();
    }

    public Form (ID formInstanceId) {
        setViewerType();
        loadFromId(formInstanceId);
    }

    private void setViewerType() {
        if (UserInfo.getUserType()=='Standard') {
            this.viewerIsStaff = true;
        } else {
            this.viewerIsStaff = false;
        }
    }

    private void loadFromId(ID formInstanceId) {
        //Get form Instance
        Form_Instance__c frmInstance = [SELECT ID, Name, Risks__c, Staff_Decision__c, Staff_Reviewer__c, Status__c, Submitter__c, Submitter__r.Name, Type__c, Form__c, Form__r.Active__c, Form__r.Title__c, Form__r.Type__c FROM Form_Instance__c WHERE ID=:formInstanceId];

        //Get form fields
        List < Form_Field__c > fields = [SELECT ID, Name, Form__c, Label__c, Order__c, Required__c, Staff_Only__c, Volunteer_Only__c, Type__c, User_Visible__c FROM Form_Field__c WHERE Form__c=:frmInstance.Form__c];

        //Get form Data
        List < Form_Data__c > dataList = [SELECT ID, Name, Boolean_Data__c, Date_Data__c, Form_Field__c, Form_Instance__c, Long_Text_Data__c, Numeric_Data__c, Text_Data__c, Type__c FROM Form_Data__c WHERE Form_Instance__c=:formInstanceId];

        // put form data in a map indexed by form field
        Map < ID, Form_Data__c > dataByFieldId = new Map < ID, Form_Data__c >();
        for ( Form_Data__c dta: dataList) {
            dataByFieldId.put(dta.Form_Field__c, dta);
        }

        //Stitch together into encapsulation object
        this.formId = frmInstance.Form__c;
        this.formInstanceId = frmInstance.Id;
        this.submitterId = frmInstance.Submitter__c;
        this.sumbitterName = frmInstance.Submitter__r.Name;
        this.status = frmInstance.Status__c;
        this.title = frmInstance.Form__r.Title__c;
        this.type = frmInstance.Form__r.Type__c;
        this.fields = new List < Form_Field >();
        for (Form_Field__c fld: fields) {
            System.debug('fld: '+fld);
            Form_Field field = new Form_Field(fld);
            //Get data for this field, if it exists
            Form_Data__c dataSobj = dataByFieldId.get(fld.Id);
            //If data exists,  fill it in.  Otherwise create an empty structure
            if (dataSobj!=null) {
                field.data = new FormData(dataSobj);
            }
            this.fields.add(field);

        }
        
    }

    public void createProjectRequest (ID submitterContactId) {
        Form__c frm = [SELECT ID FROM Form__c WHERE Type__c='Neighborhood Project' AND Active__c=true LIMIT 1];
        Form_Instance__c requestForm = new Form_Instance__c();
        requestForm.Form__c = frm.Id;
        requestForm.Submitter__c = submitterContactId;
        insert requestForm;
        this.loadFromId(requestForm.Id);
    }

    public void submit() {
        this.status = 'Pending';
        Form_Instance__c frmInst = new Form_Instance__c(ID=this.formInstanceId, Status__c=this.status);
        update frmInst;

    }


}
