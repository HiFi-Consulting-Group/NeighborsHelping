import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import createProjectRequest from '@salesforce/apex/FormInstanceController.createProjectRequest';

export default class FormsList extends NavigationMixin ( LightningElement )  {

    async handleProjRequest() {
        console.log('handleProjRequest');
        let frmInstance = JSON.parse(await createProjectRequest());

        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'formEditor__c'
            },
            state: {recordId : frmInstance.formInstanceId},
        });
    }
} 