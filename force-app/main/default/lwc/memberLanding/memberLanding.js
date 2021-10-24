import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import createProjectRequest from '@salesforce/apex/FormInstanceController.createProjectRequest';

export default class FormsList extends NavigationMixin ( LightningElement )  {

    async handleProjRequest() {
        console.log('handleProjRequest');
        // let frmInstance = JSON.parse(await createProjectRequest());
        // console.dir('wut is happening');
        // console.log('frmInstance');
        // console.log(frmInstance);

        console.log('navigate now to named comm page');
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'formEditor__c'
            },
            state: {recordId : 'a115f000000FnB8AAK'},
        });
    }
}