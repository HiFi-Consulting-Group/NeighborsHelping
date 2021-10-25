import { LightningElement, api } from 'lwc';
import getFormInstanceInfo from '@salesforce/apex/FormInstanceController.getFormInstanceInfo';
import { handleError } from 'c/lwcUtilities';


export default class FormInstance extends LightningElement {
    @api instanceId;
    @api isEditable;
    isEmployeeView;
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
        try {
            this.formTree = JSON.parse(await getFormInstanceInfo({formInstanceId:this.instanceId}));
            // this.isEmployeeView = this.formTree.viewerIsStaff;
            console.log(this.formTree);
            this.dataLoaded = true;
        } catch (error) {
            handleError(error);
        }
    }

}