@isTest
private class AccountTriggerHelperTest {
    @testSetup
    static void init() {
        Test.startTest();
        insertAccountData(150, false, false);
        Test.stopTest();
    }

    @isTest static void testDoCreate() {
        
        List<Task> tasks = [SELECT WhatId, Subject, Is_Synced__c FROM Task WHERE Is_Synced__c = false];
        Boolean flag = false;
        for (Task tsk : tasks) {
            if (tsk.Is_Synced__c) {flag = true;}
        }
        System.assertEquals(false, flag);
        System.assertEquals(300, tasks.size());      
    }
    
    @isTest static void testUpdateCountry() {
        List<Account> accts = [SELECT Id, BillingCountry FROM Account LIMIT 150];
        Test.startTest();
        for (Integer i = 0; i < 150; i++) {
            accts[i].BillingCountry = 'Updated country';
        }
        update accts;
        Test.stopTest();
        List<Contact> contByFuture = [SELECT Name FROM Contact WHERE Processed_By_Future__c = TRUE AND Is_Synced__c = FALSE];
        List<Contact> contByQueue = [SELECT Name FROM Contact WHERE Processed_By_Queue__c = TRUE AND Is_Synced__c = FALSE];
        System.assertEquals(150, contByFuture.size());
        System.assertEquals(150, contByQueue.size());            
    }

    @isTest static void testUpdateState() {
        List<Account> accts = [SELECT Id, BillingCountry FROM Account LIMIT 150];
        Test.startTest();
        for (Integer i = 0; i < 150; i++) {
            accts[i].BillingState = 'Updated state';
        }
        update accts;
        Test.stopTest();
        List<Contact> contByFuture = [SELECT Name FROM Contact WHERE Processed_By_Future__c = TRUE AND Is_Synced__c = FALSE];
        List<Contact> contByQueue = [SELECT Name FROM Contact WHERE Processed_By_Queue__c = TRUE AND Is_Synced__c = FALSE];
        System.assertEquals(150, contByFuture.size());
        System.assertEquals(150, contByQueue.size());            
    }

    @isTest static void testUpdateCity() {
        List<Account> accts = [SELECT Id, BillingCountry FROM Account LIMIT 150];
        Test.startTest();
        for (Integer i = 0; i < 150; i++) {
            accts[i].BillingCity = 'Updated city';
        }
        update accts;
        Test.stopTest();
        List<Contact> contByFuture = [SELECT Name FROM Contact WHERE Processed_By_Future__c = TRUE AND Is_Synced__c = FALSE];
        List<Contact> contByQueue = [SELECT Name FROM Contact WHERE Processed_By_Queue__c = TRUE AND Is_Synced__c = FALSE];
        System.assertEquals(150, contByFuture.size());
        System.assertEquals(150, contByQueue.size());            
    }

    @isTest static void testUpdateStreet() {
        List<Account> accts = [SELECT Id, BillingCountry FROM Account LIMIT 150];
        Test.startTest();
        for (Integer i = 0; i < 150; i++) {
            accts[i].BillingStreet = 'Updated street';
        }
        update accts;
        Test.stopTest();
        List<Contact> contByFuture = [SELECT Name FROM Contact WHERE Processed_By_Future__c = TRUE AND Is_Synced__c = FALSE];
        List<Contact> contByQueue = [SELECT Name FROM Contact WHERE Processed_By_Queue__c = TRUE AND Is_Synced__c = FALSE];
        System.assertEquals(150, contByFuture.size());
        System.assertEquals(150, contByQueue.size());            
    }

    @isTest static void testUpdatePostalCode() {
        List<Account> accts = [SELECT Id, BillingCountry FROM Account LIMIT 150];
        Test.startTest();
        for (Integer i = 0; i < 150; i++) {
            accts[i].BillingPostalCode = 'Updated PostalCode';
        }
        update accts;
        Test.stopTest();
        List<Contact> contByFuture = [SELECT Name FROM Contact WHERE Processed_By_Future__c = TRUE AND Is_Synced__c = FALSE];
        List<Contact> contByQueue = [SELECT Name FROM Contact WHERE Processed_By_Queue__c = TRUE AND Is_Synced__c = FALSE];
        System.assertEquals(150, contByFuture.size());
        System.assertEquals(150, contByQueue.size());            
    }

    public static void insertAccountData(Integer acctCount, Boolean isSynced, Boolean updated) {
        List<Account> accts = new List<Account>();
        List<Contact> conts = new List<Contact>();
        List<Task> tasks = new List<Task>();

        for (Integer i = 0; i < acctCount; i++) {
            Account acct = new Account();
            acct.Name = 'Name' + i;
            acct.Updated_By_Task__c = updated;
            acct.BillingCountry = 'BillingCountry';
            acct.BillingState = 'BillingState';
            acct.BillingCity = 'BillingCity';
            acct.BillingStreet = 'BillingStreet';
            acct.BillingPostalCode = 'BillingPostalCode';
            accts.add(acct);
        }

        insert accts;

        for (Account acct : accts) {
            Contact cont = new Contact();
            cont.LastName = 'Contact by' + acct.Name;
            cont.Processed_By_Future__c = false;
            cont.AccountId = acct.Id;
            cont.Is_Synced__c = isSynced;
            conts.add(cont);
        }

        insert conts;

        for (Account acct : accts) {
            Task tsk = new Task();
            tsk.Whatid = acct.Id;
            tsk.Account_Owner__c = acct.Owner.Name;
            tsk.Is_Synced__c = isSynced;
            tasks.add(tsk);
        }

        insert tasks;
    }
}