@IsTest
private class SingletonTriggerTest {
    @isTest static void testSingletonTrigger() {
    Account acct = new Account(Name = 'Acct001');
    insert acct;
    List<Account> accts = [SELECT Id, Name FROM Account WHERE Name = 'Acct001'];
    System.assertEquals(1, accts.size(), 'Trigger has been fired more than 1 time');
    }
}