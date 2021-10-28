public with sharing class FormData {

    public String name;
    public ID dataId;
    public String formField; //id for form Field
    public String formInstance; // id for parent instance
    public String type; 
    //following are the possible data-holding fields. Only one is used based on the type
    public String text;
    public String textArea;
    public Boolean bool;
    public Decimal num;
    public Date dte;
    
    public FormData() {

    }

    public FormData(Form_Data__c dataSobj) {
        this.dataId = dataSobj.ID;
        this.name = dataSobj.Name;
        this.formField = dataSobj.Form_Field__c;
        this.formInstance = dataSobj.Form_Instance__c;
        this.type = dataSobj.Type__c;
        if (this.type=='Boolean') {
            this.bool = dataSobj.Boolean_Data__c;
        } else if (this.type=='Currency' || this.type=='Number') {
            this.num = dataSobj.Numeric_Data__c;
        } else if (this.type == 'Email' || this.type == 'Text' || this.type == 'Lookup' || this.type=='Radio') {
            this.text = dataSobj.Text_Data__c;
        } else if (this.type == 'Text Area') {
            this.textArea = dataSobj.Long_Text_Data__c;
        } else if (this.type=='Date') {
            this.dte = dataSobj.Date_Data__c;
        }
    }
}
