import { LightningElement, api } from 'lwc';

export default class FormInstanceViewer extends LightningElement {
    @api recordId;
    @api isStaffView = false;
    isEditable = false;

    connectedCallback() {
        console.log('recordId');
        console.log(this.recordId);
    }

}