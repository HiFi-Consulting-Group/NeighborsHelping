import { LightningElement, api } from 'lwc';
import { getRecordNotifyChange } from 'lightning/uiRecordApi'; 
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import getFormInstanceStatus from '@salesforce/apex/FormInstanceController.getFormInstanceStatus';
import staffDecisionMade from '@salesforce/apex/FormInstanceController.staffDecisionMade';
export default class ProjectReviewInterface extends LightningElement {
    @api recordId;
    showControls = false;

    connectedCallback() {
        if (this.recordId) {
            this.loadData();
        }
    }

    async loadData() {
        let status = await getFormInstanceStatus({instanceId: this.recordId});
        if (status=='Pending') {
            this.showControls = true;
        }
    }

    async handleDecision(event) {
        let decision = event.target.name;
        await staffDecisionMade({instanceId:this.recordId, decision:decision});
        this.showControls = false;

        //Success toast
        const toastEvent = new ShowToastEvent({
            variant: 'success',
            title: 'Success!',
            message: 'Your '+ decision+ ' was Submitted!',
        });
        this.dispatchEvent(toastEvent);
    }

    //// Notify LDS that you've changed the record outside its mechanisms.
    // getRecordNotifyChange([{recordId: this.recordId}]);


}