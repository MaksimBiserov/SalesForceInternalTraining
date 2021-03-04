public class SingletonTriggerHandler
{
    public static void OnAfterInsert(List<Account> newAccts)
    {
        SingletonTriggerHelper.OnHelper(newAccts);
    }
}