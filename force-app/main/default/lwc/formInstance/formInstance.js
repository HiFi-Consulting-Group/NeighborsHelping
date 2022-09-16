import { LightningElement, api } from 'lwc';
import getFormInstanceInfo from '@salesforce/apex/FormInstanceController.getFormInstanceInfo';
import { handleError } from 'c/lwcUtilities';


export default class FormInstance extends LightningElement {
    @api instanceId;
    @api isEditable;
    @api isStaffView = false;
    dataLoaded = false;
    formTree;

    connectedCallback() {
        if (this.instanceId) {
            this.loadData();
        }
    }

    async loadData() {
        try {
            this.formTree = JSON.parse(await getFormInstanceInfo({formInstanceId:this.instanceId}));
            console.log('this.formTree-------------',this.formTree);
            this.dataLoaded = true;
        } catch (error) {
            handleError(error);
        }
    }

}