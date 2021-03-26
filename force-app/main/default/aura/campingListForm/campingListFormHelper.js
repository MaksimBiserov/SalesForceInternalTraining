({
    createItem: function(component, newCampItem) {
       var action = component.getEvent("addItem");
       action.setParams({ "item": newCampItem });
       action.fire();
       component.set("v.newItem", {'sobjectType': 'Camping_Item__c',
                                   'Name': '',
                                   'Quantity__c': 0,
                                   'Price__c': 0,
                                   'Packed__c': false});
   },
   
   validateItemForm: function(component) {
       var validItem = true;
       var itemname = component.get("v.newItem.Name");
       if ($A.util.isEmpty(itemname)){
           validItem = false;
           component.set("v.errors", [{message:"Item name can't be blank."}]);
       }
       else {
       component.set("v.errors", null);
   }
   var quantity = component.get("v.newItem.Quantity__c");
       if ($A.util.isEmpty(quantity)) {
           validItem = false;
           component.set("v.errors", [{message:"Quantity can't be blank."}]);
       }
       else {
            component.set("v.errors", null);
       }
   var price = component.get("v.newItem.Price__c");
       if ($A.util.isEmpty(price)){
           validItem = false;
           component.set("v.errors", [{message:"Price can't be blank."}]);
       }
       else {
            component.set("v.errors", null);
       }
   return (validItem);
   }
})