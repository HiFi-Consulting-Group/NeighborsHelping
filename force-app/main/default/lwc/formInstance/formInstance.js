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
        console.log('instanceId');
        console.log(this.instanceId);
        if (this.instanceId) {
            console.log('instanceId');
            console.log(this.instanceId);
            this.loadData();
        }
    }

    async loadData() {
        console.log('isStaffView');
        console.log(this.isStaffView);
        try {
            this.formTree = JSON.parse(await getFormInstanceInfo({formInstanceId:this.instanceId}));
            console.log('this.formTree-------------');
            console.log(this.formTree);
            this.dataLoaded = true;
        } catch (error) {
            handleError(error);
        }
    }

}