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
        this.localField = updateFieldInternals(this.localField, this.instanceId);
        console.log('this.localField');
        console.log(this.localField);

    }

}