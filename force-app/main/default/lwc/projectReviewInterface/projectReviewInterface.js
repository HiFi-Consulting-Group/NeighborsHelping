import { LightningElement, api } from 'lwc';
import { getRecordNotifyChange } from 'lightning/uiRecordApi'; 

export default class ProjectReviewInterface extends LightningElement {
    @api recordId;

    connectedCallback() {

    }

    loadData() {


    }

    //// Notify LDS that you've changed the record outside its mechanisms.
    // getRecordNotifyChange([{recordId: this.recordId}]);


}