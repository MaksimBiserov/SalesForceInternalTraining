public with sharing class AsyncBatchJobIterable implements Database.Batchable<SObject>, Database.Stateful {
    public Integer recordsProcessed = 0;

    public Iterable<sObject> start(Database.BatchableContext bc) {
        return [SELECT ID, BillingCountry, BillingState, BillingCity, BillingStreet, BillingPostalCode,
               (SELECT MailingStreet, MailingCity, MailingState, MailingCountry, MailingPostalCode, Is_Synced__c
                FROM Contacts WHERE Is_Synced__c = false)
                FROM Account];
    }
    
    public void execute(Database.BatchableContext bc, List<Account> scope){        
        List<Contact> conts = new List<Contact>();

        for (Account acct : scope) {
            for (Contact cont : acct.contacts) {
                cont.MailingCountry = acct.BillingCountry;
                cont.MailingState = acct.BillingState;
                cont.MailingCity = acct.BillingCity;
                cont.MailingStreet = acct.BillingStreet;
                cont.MailingPostalCode = acct.BillingPostalCode;                
                cont.Is_Synced__c = true;
                acct.Updated_By_Contact__c = true;                
                conts.add(cont);
                recordsProcessed++;
            }
        }

        update conts;
        update scope;
    }    
    
    public void finish(Database.BatchableContext bc) {
        System.debug('Records processed:' + recordsProcessed);
    }    
}

// Invoke:
// AsyncBatchJobIterable ab = new AsyncBatchJobIterable();
// Database.executeBatch(ab);