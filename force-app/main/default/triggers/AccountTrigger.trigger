trigger AccountTrigger on Account (before insert, before update, before delete, after insert,
    after update, after delete, after undelete) {
        
    if (Trigger.isInsert && Trigger.isAfter) {
        AccountTriggerHandler.OnAfterInsert(Trigger.new);                                  
    }

    if (Trigger.isUpdate && Trigger.isAfter) {
        AccountTriggerHandler.OnAfterUpdate(Trigger.oldMap, Trigger.newMap);
    }
}