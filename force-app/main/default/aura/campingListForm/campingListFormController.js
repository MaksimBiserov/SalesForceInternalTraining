({
    clickCreateItem : function(component, event, helper) {
        if(helper.validateItemForm(component)) {
        	var item = component.get("v.newItem");
        	helper.createItem(component, item);
    	}
    }
})