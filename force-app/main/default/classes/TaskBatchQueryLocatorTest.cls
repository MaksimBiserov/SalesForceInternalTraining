@IsTest
private class TaskBatchQueryLocatorTest {
    @IsTest static void testAsyncBatchJobQueryLocator() {

        insertAccountData(150, false, false);
        Test.startTest();
        Id batchId = Database.executeBatch(new TaskBatchQueryLocator());
        Test.stopTest();
        List<String> acctOwners = new List<String>();
        List<Account> accts = [SELECT Name, Owner.Name FROM Account WHERE Updated_By_Task__c = true];

        for(Account acct : accts) {
            acctOwners.add(acct.Owner.Name);
        }

        Integer countOwners = [SELECT COUNT() FROM Task WHERE Account_Owner__c IN : acctOwners];
        Integer countTasks = [SELECT COUNT() FROM Task WHERE Is_Synced__c = TRUE];
        Integer countAccts = [SELECT COUNT() FROM Account WHERE Updated_By_Task__c = TRUE];
        System.assertEquals(150, countOwners);
        System.assertEquals(150, countTasks);
        System.assertEquals(150, countAccts);  
    }

    public static void insertAccountData(Integer acctCount, Boolean isSynced, Boolean updated) {
        List<Account> accts = new List<Account>();
        List<Task> tasks = new List<Task>();

        for (Integer i = 0; i < acctCount; i++) {
            Account acct = new Account();
            acct.Name = 'Name' + i;
            acct.Updated_By_Task__c = updated;
            accts.add(acct);
        }

        insert accts;

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