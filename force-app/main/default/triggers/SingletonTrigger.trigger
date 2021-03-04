
trigger SingletonTrigger on Account (after insert)
{
    if(Trigger.isInsert && Trigger.isAfter)
    {
        SingletonTriggerHelper.OnAfterInsert(Trigger.new);
    }
}