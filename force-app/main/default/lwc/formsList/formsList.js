import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getEndorsements from '@salesforce/apex/FormInstanceController.getEndorsements';

const columns = [
    {type: 'button-icon', initialWidth: 80, 
    typeAttributes: {  
        iconName: {fieldName: 'iconName'},
        label: {fieldName: 'iconHelp'},  
        name: {fieldName: 'iconHelp'},  
        variant: 'bare',
        alternativeText: {fieldName: 'iconHelp'},       
        disabled: false
    }},
    { label: 'Name', fieldName: 'Name'},
    { label: 'Form Title', fieldName: 'Title__c'},
    { label: 'Type', fieldName: 'Type__c'},    
];

export default class FormsList extends NavigationMixin ( LightningElement ) {

    // forms;
    // columns = columns;

    // async connectedCallback() {
    //     let records = await getEndorsements();
    //     let endorsements = JSON.parse(records);

    //     console.log('endorsements');
    //     console.log(endorsements);
        
    //     if (endorsements) {
    //         for (let end of endorsements) {
    //             end.iconName = 'action:edit'
    //             end.iconHelp = 'Edit';
    //             end.advisor = end.Advisor__r.Name;
    //         }

    //     }

    //     this.endorsements = endorsements;

    // }

    // handleRowAction(event) {
    //     const row = event.detail.row;
    //     console.log('row.Id');
    //     console.log(row.Id);

    //     this[NavigationMixin.Navigate]({
    //         type: 'standard__recordPage',
    //         attributes: {
    //             recordId: 'a2W5d00000DPmXQEA1',  //hardcoded for now
    //             objectApiName: 'Form_Instance__c',
    //             actionName: 'view'
    //         }
    //     });
    

    // }


}