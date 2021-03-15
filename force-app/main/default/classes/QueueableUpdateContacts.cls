// In AccountTriggerHandler call Queueble Job, which perform similar logic

public with sharing class QueueableUpdateContacts implements Queueable {
    public List<Id> IDs;
    
    public QueueableUpdateContacts(List<Id> IDs) {
        for(Account acct : IDs) {
            this.IDs.add(acct.Id);
        }
    }
    
    public void execute(QueueableContext context) {
        List<Contact> conts = [SELECT Id FROM Contact WHERE AccountId IN :IDs];

        for (Contact cont : conts) {
            cont.Is_Synced__c = false;
            cont.Processed_By_Queue__c = true;
        }

        update conts;
    }
}