public with sharing class AsyncBatchJobQueryLocator implements Database.Batchable<sObject>, Database.Stateful {    
    public Integer recordsProcessed = 0;

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID, BillingCountry, BillingState, BillingCity, BillingStreet, BillingPostalCode, ' +
            '(SELECT MailingStreet, MailingCity, MailingState, MailingCountry, MailingPostalCode, Is_Synced__c ' +
            'FROM Contacts WHERE Is_Synced__c = false) ' +
            'FROM Account'); 
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
    
    public void finish(Database.BatchableContext bc){
        System.debug('Records processed:' + recordsProcessed);
    }    
}

// Invoke:
// AsyncBatchJobQueryLocator ab = new AsyncBatchJobQueryLocator();
// Database.executeBatch(ab);