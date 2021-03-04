
public class SingletonTriggerHelper
{
    private static boolean flagval = true;

    public static void OnAfterInsert(Account[] newAccts)
    {
        if(flagval)
        {
            System.debug('Single run of SingletonTrigger');
            flagval = false;
        }
    }
}