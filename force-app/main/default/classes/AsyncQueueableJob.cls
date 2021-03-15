public with sharing class AsyncQueueableJob implements Queueable {
    public List<Account> getAccountsWithContacts() {
        List<Account> accounts = [SELECT ID, 
                                 (SELECT ID, Is_Synced__c, Processed_By_Queue__c FROM Contacts)
                                 FROM Account
                                 WHERE (BillingCountry != NULL)
                                 AND (BillingState != NULL)
                                 AND (BillingCity != NULL)
                                 AND (BillingStreet != NULL)
                                 AND (BillingPostalCode != NULL)];
        return accounts;
    }
    
    public void execute(QueueableContext context) {
        List<Account> accts = getAccountsWithContacts();        
        List<Contact> conts = new List<Contact>();       
        for (Account acct : accts) {            
            for (Contact cont : acct.Contacts) {
                cont.Is_Synced__c = false;
                cont.Processed_By_Queue__c = true;
                conts.add(cont);                           
            }
        }

        update conts;
    }
}

// Invoke:
// AsyncQueueableJob aqj = new AsyncQueueableJob();
// ID jobID = System.enqueueJob(aqj);