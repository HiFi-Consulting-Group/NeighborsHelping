import { LightningElement, api } from 'lwc';

import { updateFieldInternals } from 'c/formUtilities';
export default class FormFieldViewer extends LightningElement {
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
        
        // If deep clone isn't needed, you can use object.assign:
        // Object.assign(this.localField , this.field);

        // Call to shared utility function to fill in data types for markup logic
        this.localField = updateFieldInternals(this.localField, this.instanceId);

    }

}