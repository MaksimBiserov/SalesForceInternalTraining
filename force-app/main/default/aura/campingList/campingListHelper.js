({
    createItem : function(component, newCampItem) {
        var action = component.get("c.saveItem");

        action.setParams({
            "item" : newCampItem
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                var campItems = (component.get("v.items"));
                campItems.push(response.getReturnValue());
                component.set("v.items",campItems);
                component.set("v.newItem", {'sobjectType': 'Camping_Item__c',
                                            'Price__c': 0,
                                            'Packed__c': false,
                                            'Quantity__c': 0, 'Name':''})
            }
        });
        $A.enqueueAction(action);
    },
    
    validateCampingForm: function(component) {
     	var validQuantity = true;
        var validPrice = true;
        var nameField = component.find("campname");
        var campname = nameField.get("v.value");
        var quantityField = component.find("quantity");
        var quantity = quantityField.get("v.value");
        var priceField = component.find("price");
        var price = priceField.get("v.value");
        if ($A.util.isEmpty(campname) || $A.util.isEmpty(quantity) || $A.util.isEmpty(price)){
            validQuantity = false;
            validPrice = false;
            nameField.set("v.errors", [{message:"Camping name, quantity or price can't be blank."}]);
        }
        else {
            nameField.set("v.errors", null);
        }
		
		return(validQuantity && validPrice);        
	}
})