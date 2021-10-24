import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';



export default class FormInstanceEditor extends NavigationMixin ( LightningElement ) {
    @api recordId;
    isEditable = true;
    submitDisabled = false;

    connectedCallback() {
        console.log('recordId');
        console.log(this.recordId);
    }

    handleSubmit() {

    }

}