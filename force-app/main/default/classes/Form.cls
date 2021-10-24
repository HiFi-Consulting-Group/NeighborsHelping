//combines a form instance with its form structure and data

public inherited sharing class Form {

    public ID formId;
    public ID formInstanceId;
    public ID submitterId;
    public String sumbitterName;
    public String status;
    public String title;
    public String type;
    public List < Form_Field > fields;
    
    public class Form_Field {
        public ID recordId;
        public String name;
        public String type;
        public Boolean required;
        public Boolean userVisible;
        public Boolean staffOnly;
        public FormData data;

        public Form_Field(Form_Field__c fieldSobj) {
            this.recordId = fieldSobj.ID;
            this.name = fieldSobj.Name;
            this.type = fieldSobj.Type__c;
            this.required = fieldSobj.Required__c;
            this.userVisible = fieldSobj.User_Visible__c;
            this.staffOnly = fieldSobj.Staff_Only__c;
        }
    }

    public Form () {
    }

    public Form (ID formInstanceId) {
        loadFromId(formInstanceId);
    }

    // public static List < Form > getFormList (List < ID > idList) {
    //     List < Form__c > formSobjList = queryForSobjList(idList);

    //     List < Form > formList = new List < Form >();
    //     for (Form__c frmSobj: formSobjList) {
    //         formList.add(new Form(frmSobj));
    //     }

    //     return formList;
    // }

    // public static List < Form__c > queryForSobjList (List < ID > idList) {
    //     String formFieldNames = String.join( getAllFormSobjFields(), ',' );
    //     String formFieldFieldNames = String.join( getAllFormFieldSobjFields(), ',' );

    //     String query =
	// 		' SELECT ' +
    //             formFieldNames +
    //                 ', (SELECT ' + 
    //                 formFieldFieldNames + 
    //                 ' FROM Form_Fields__r ORDER BY Order__c  )' +
	// 		' FROM ' +
	// 			' Form__c ' +
	// 		' WHERE ' +
    //             ' Id =: formInstanceId';
    //     try {
    //         return (List <Form__c>)Database.query( query );
    //     } catch (exception e) {
    //         System.debug('SOBJ Query Error Thrown: ' + e);
    //         throw new NHN_Exception('Form.queryForSobj', 'Failed to load requested Form', e);
    //     }
    // }



    // private void assignFromSobject (Form__c formSobj) {
    //     this.title = formSobj.Title__c;
    //     this.type = formSobj.Type__c;
    //     this.active = formSobj.Active__c;
    //     if (formSobj.Form_Fields__r.size()>0) {
    //         for (Form_Field__c fieldSobj: formSobj.Form_Fields__r) {
    //             this.fields.add(new Form_Field(fieldSobj));
    //         }
    //     }
    // }

    private void loadFromId(ID formInstanceId) {
        //Get form Instance
        Form_Instance__c frmInstance = [SELECT ID, Name, Risks__c, Staff_Decision__c, Staff_Reviewer__c, Status__c, Submitter__c, Submitter__r.Name, Type__c, Form__c, Form__r.Active__c, Form__r.Title__c, Form__r.Type__c FROM Form_Instance__c WHERE ID=:formInstanceId];

        System.debug('frmInstance.Form__c: '+frmInstance.Form__c);

        //Get form fields
        List < Form_Field__c > fields = [SELECT ID, Name, Form__c, Label__c, Order__c, Required__c, Staff_Only__c, Type__c, User_Visible__c FROM Form_Field__c WHERE Form__c=:frmInstance.Form__c];

        System.debug('fields: '+fields.size());

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

        // //initialize lists
        // this.fields = new List < Form_Field >();

        // //Query for the form and its child fields
        // List < ID > frmIdAsList = new List < ID >{formInstanceId};
        // Form__c frm = queryForSobjList(frmIdAsList)[0];

        // //Assign result to class variables
        // assig
        
    }

    public void createProjectRequest (ID submitterContactId) {
        // try {
            Form__c frm = [SELECT ID FROM Form__c WHERE Type__c='Neighborhood Project' AND Active__c=true LIMIT 1];
            Form_Instance__c requestForm = new Form_Instance__c();
            requestForm.Form__c = frm.Id;
            requestForm.Submitter__c = submitterContactId;
            insert requestForm;
            this.loadFromId(requestForm.Id);
        // } catch (Exception e) {
        //     throw new NHN_Exception('Form.createProjectRequst', 'Failed to create new Project Form', e);
        // }
        
    }

    // public static List < String > getAllFormSobjFields () {
	// 	DescribeSObjectResult describeResult = Form__c.getSObjectType().getDescribe();
	// 	List<String> fieldNames = new List<String>( describeResult.fields.getMap().keySet() );
	// 	return fieldNames;
    // }

    // public static List < String > getAllFormFieldSobjFields () {
	// 	DescribeSObjectResult describeResult = Form_Field__c.getSObjectType().getDescribe();
	// 	List<String> fieldNames = new List<String>( describeResult.fields.getMap().keySet() );
	// 	return fieldNames;
    // }

    // public static List < String > getAllFormInstanceSobjFields () {
	// 	DescribeSObjectResult describeResult = Form_Instance__c.getSObjectType().getDescribe();
	// 	List<String> fieldNames = new List<String>( describeResult.fields.getMap().keySet() );
	// 	return fieldNames;
    // }

}
