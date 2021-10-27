import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

import memberFormSubmitted from '@salesforce/apex/FormInstanceController.memberFormSubmitted';



export default class FormInstanceEditor extends NavigationMixin ( LightningElement ) {
    @api recordId;
    @api isStaffView = false;
    isEditable = true;
    submitDisabled = false;

    connectedCallback() {
        console.log(this.isStaffView);
    }

    async handleSubmit() {
        //Update status on the Form Instance and return user to home
        await memberFormSubmitted({instanceId:this.recordId});

        //Success toast
        const event = new ShowToastEvent({
            variant: 'success',
            title: 'Success!',
            message: 'Your request was Submitted!',
        });
        this.dispatchEvent(event);

        //navigate home
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Home'
            },
        });

        
    }

}