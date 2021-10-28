import { LightningElement, api } from 'lwc';

import { updateFieldInternals } from 'c/formUtilities';
import updateTextPickOrLookup from '@salesforce/apex/FormInstanceController.updateTextPickOrLookup';
import updateTextArea from '@salesforce/apex/FormInstanceController.updateTextArea';
import updateDate from '@salesforce/apex/FormInstanceController.updateDate';

import { handleError } from 'c/lwcUtilities';


export default class FormFieldEditor extends LightningElement {
    @api field;
    @api instanceId;
    localField;
    fieldId;
    dataId;

    connectedCallback() {
        if (this.field) {
            this.handleData();
        }
    }

    handleData() {
        //deep clone field so that we can update internals on the fly
        this.localField = JSON.parse(JSON.stringify(this.field));
        this.localField = updateFieldInternals(this.localField, this.instanceId);

        //class variables to access form id and data id
        this.fieldId = this.localField.recordId;
        if (this.localField.data) {
            this.dataId = this.localField.data.dataId;
        }
    }

    async handleTextInputchange(event) {
        try {
            console.log('handleTextInputchange');
            let dataText = event.target.value;
            this.dataId = await updateTextPickOrLookup({instanceId:this.instanceId, fieldId:this.fieldId, dataId:this.dataId, value:dataText});
            this.localField.data.dataId = this.dataId;
        } catch (error) {
            handleError(error);
        }
    }

    async handleTextAreachange(event) {
        try {
            let dataText = event.target.value;
            this.dataId = await updateTextArea({instanceId:this.instanceId, fieldId:this.fieldId, dataId:this.dataId, value:dataText});
            this.localField.data.dataId = this.dataId;
        } catch (error) {
            handleError(error);
        }
    }

    async handleDateInputchange(event) {
        try {
            let dateValue = event.target.value;
            this.dataId = await updateDate({instanceId:this.instanceId, fieldId:this.fieldId, dataId:this.dataId, value:dateValue});
            //if this is the first time the data has been set, we need to grab the id in case the data is changed again
            this.localField.data.dataId = this.dataId;
        } catch (error) {
            handleError(error);
        }
        
    }


    
}