import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import createProjectRequest from '@salesforce/apex/FormInstanceController.createProjectRequest';

export default class FormsList extends NavigationMixin ( LightningElement )  {

    async handleProjRequest() {
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'formEditor__c'
            },
            state: {recordId : 'a115f000000FnB8AAK'},
        });
    }
}