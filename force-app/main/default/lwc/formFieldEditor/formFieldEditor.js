import { LightningElement, api } from 'lwc';

export default class FormFieldEditor extends LightningElement {
    @api field;
    @api instanceId;
    localField;


    connectedCallback() {
        if (this.field) {
            this.handleData();
        }
    }

    handleData() {
        //deep clone field so that we can update internals on the fly
        this.localField = JSON.parse(JSON.stringify(this.field));
        console.log('this.localField');
        console.log(this.localField);

        if (this.localField.userVisible) {
            switch(this.localField.type) {
                case "Boolean":
                    //Set field type for markup
                    this.localField.isBoolean=true;
                    //if there is no data for this field yet, create the structure
                    if (!this.localField.data) {
                        this.localField.data = this.getFieldDataStructure(this.localField.recordId);
                        this.localField.data.bool = false;
                    }
                    break;
                case "Currency":
                    this.localField.isCurrency=true;
                    if (!this.localField.data) {
                        this.localField.data = this.getFieldDataStructure(this.localField.recordId);
                        this.localField.data.num = null;
                    }
                    break;
                case "Email":
                    this.localField.isEmail=true;
                    if (!this.localField.data) {
                        this.localField.data = this.getFieldDataStructure(this.localField.recordId);
                        this.localField.data.text = null;
                    }
                    break;
                case "Number":
                    this.localField.isNumber=true;
                    if (!this.localField.data) {
                        this.localField.data = this.getFieldDataStructure(this.localField.recordId);
                        this.localField.data.num = null;
                    }
                    break;
                case "Radio":
                    this.localField.isRadio=true;
                    if (!this.localField.data) {
                        this.localField.data = this.getFieldDataStructure(this.localField.recordId);
                        this.localField.data.text = null;
                    }
                    break;
                case "Text":
                    this.localField.isText=true;
                    if (!this.localField.data) {
                        this.localField.data = this.getFieldDataStructure(this.localField.recordId);
                        this.localField.data.text = null;
                    }
                    break;
                case "Text Area":
                    this.localField.isTextArea=true;
                    if (!this.localField.data) {
                        this.localField.data = this.getFieldDataStructure(this.localField.recordId);
                        this.localField.data.textArea = null;
                    }
                    break;
                case "Picklist":
                    this.localField.isPicklist=true;
                    if (!this.localField.data) {
                        this.localField.data = this.getFieldDataStructure(this.localField.recordId);
                        this.localField.data.text = null;
                    }
                    break;
                case "Date":
                    this.localField.isDate=true;
                    if (!this.localField.data) {
                        this.localField.data = this.getFieldDataStructure(this.localField.recordId);
                        this.localField.data.dte = null;
                    }
                    break;
              }
        }
    }

    getFieldDataStructure(fieldId) {
        return {"dataId":null,"formField":fieldId,"formInstance":this.instanceId};
    }
}