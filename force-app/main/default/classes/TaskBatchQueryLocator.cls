public with sharing class TaskBatchQueryLocator implements Database.Batchable<sObject>, Database.Stateful {
    public Integer recordsProcessed = 0;
    
    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator(
            'SELECT Id, Updated_By_Task__c, Owner.Name, '+
            '(SELECT Id, Account_Owner__c ' + 
            'FROM Tasks WHERE Is_Synced__c = FALSE) ' +
            'FROM Account');
    }
    
    public void execute(Database.BatchableContext bc, List<Account> scope) {
        List<Task> tsks = new List<Task>();
        List<Account> updateAccts = new List<Account>();

        for(Account acct : scope) {
            for(Task tsk: acct.Tasks) {
                tsk.Account_Owner__c = acct.Owner.Name;
                tsk.Is_Synced__c = true;
                tsks.add(tsk);
                recordsProcessed++;
            }

            acct.Updated_By_Task__c = true;
            updateAccts.add(acct);
        }

        update updateAccts;
        update tsks;
    }
     
    public void finish(Database.BatchableContext context) {
        System.debug('Records processed:' + recordsProcessed);
    }
}

// Invoke:
// TaskBatchQueryLocator tb = new TaskBatchQueryLocator();
// Database.executeBatch(tb);