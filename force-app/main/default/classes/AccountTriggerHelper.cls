public with sharing class AccountTriggerHelper {
    
    @future
    public static void CreateTaskForAccount(List<Id> IDs)
    {
        List<Account> accts = [SELECT Id, Name FROM Account WHERE Account.Id IN : IDs];
        List<Task> tsks = new List<Task>();

        for (Account acct : accts)
        {
            Task insertTask = new Task();
            insertTask.Subject = 'Negotiations with ' + acct.Name;
            insertTask.WhatId = acct.Id;
            insertTask.Is_Synced__c = false;
            tsks.add(insertTask);
        }

        insert tsks;
    }

    public static void updateContacts(Map<Id, Account> oldMap, Map<Id, Account> newMap) {
        List<Id> IDs = new List<Id>();
        for (Account newAcct : newMap.values()) {
            Account oldAcct = oldMap.get(newAcct.Id);

            if (newAcct.BillingCountry != oldAcct.BillingCountry ||
                newAcct.BillingState != oldAcct.BillingState ||
                newAcct.BillingCity != oldAcct.BillingCity ||
                newAcct.BillingStreet != oldAcct.BillingStreet ||
                newAcct.BillingPostalCode != oldAcct.BillingPostalCode) {
                    IDs.add(newAcct.Id);
                }        
        }
        
        futureUpdate(IDs);
        QueueableUpdateContacts queConts = new QueueableUpdateContacts(IDs);
        System.enqueueJob(queConts);
    }

    @future
    public static void futureUpdate(List<Id> IDs) {
        List<Contact> contacts = [SELECT Id FROM Contact WHERE AccountId IN :IDs];
        
        for (Contact cont : contacts ) {
            cont.Is_Synced__c = false;
            cont.Processed_By_Future__c = true;
        }

        update contacts;
    }
}