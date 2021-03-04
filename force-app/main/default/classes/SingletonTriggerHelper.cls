
public class SingletonTriggerHelper
{
    private static Boolean firstStart = true;

    public static void OnHelper(List<Account> newAccts)
    {
        if(firstStart)
        {
            System.debug('Single run of SingletonTrigger');
            firstStart = false;
        }
    }
}