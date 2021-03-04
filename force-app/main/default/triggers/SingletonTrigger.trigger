
trigger SingletonTrigger on Account (after insert)
{
    if(Trigger.isInsert && Trigger.isAfter)
    {
        SingletonTriggerHandler.OnAfterInsert(Trigger.new);
    }
}