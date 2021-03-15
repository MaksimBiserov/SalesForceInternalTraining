public class AccountTriggerHandler {
    public static void OnAfterInsert(List<Id> newAccts)
    {
        AccountTriggerHelper.CreateTaskForAccount(newAccts);
    }

    public static void OnAfterUpdate(Map<Id, Account> oldMap, Map<Id, Account> newMap)
    {
        AccountTriggerHelper.updateContacts(oldMap, newMap);
    }
}