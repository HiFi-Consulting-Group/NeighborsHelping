
// update item internals
function updateFieldInternals(field, instanceId) {
    //if the item has a form phrase, and child components, it's regular
    if (field.userVisible) {
        switch(field.type) {
            case "Boolean":
                //Set field type for markup
                field.isBoolean=true;
                //if there is no data for this field yet, create the structure
                if (!field.data) {
                    field.data = {"dataId":null,"formField":field.recordId,"formInstance":instanceId};
                    field.data.bool = false;
                }
                break;
            case "Currency":
                field.isCurrency=true;
                if (!field.data) {
                    field.data = {"dataId":null,"formField":field.recordId,"formInstance":instanceId};
                    field.data.num = null;
                }
                break;
            case "Email":
                field.isEmail=true;
                if (!field.data) {
                    field.data = {"dataId":null,"formField":field.recordId,"formInstance":instanceId};
                    field.data.text = null;
                }
                break;
            case "Number":
                field.isNumber=true;
                if (!field.data) {
                    field.data = {"dataId":null,"formField":field.recordId,"formInstance":instanceId};
                    field.data.num = null;
                }
                break;
            case "Radio":
                field.isRadio=true;
                if (!field.data) {
                    field.data = {"dataId":null,"formField":field.recordId,"formInstance":instanceId};
                    field.data.text = null;
                }
                break;
            case "Text":
                field.isText=true;
                if (!field.data) {
                    field.data = {"dataId":null,"formField":field.recordId,"formInstance":instanceId};
                    field.data.text = null;
                }
                break;
            case "Text Area":
                field.isTextArea=true;
                if (!field.data) {
                    field.data = {"dataId":null,"formField":field.recordId,"formInstance":instanceId};
                    field.data.textArea = null;
                }
                break;
            case "Picklist":
                field.isPicklist=true;
                if (!field.data) {
                    field.data = {"dataId":null,"formField":field.recordId,"formInstance":instanceId};
                    field.data.text = null;
                }
                break;
            case "Date":
                field.isDate=true;
                if (!field.data) {
                    field.data = {"dataId":null,"formField":field.recordId,"formInstance":instanceId};
                    field.data.dte = null;
                }
                break;
          }
    }

    return field;

}



export {
    updateFieldInternals
};