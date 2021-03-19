@IsTest
private class AccountHandlerTest {
    @IsTest static void testCreateTask() {
        String acctName = 'Test 01';
        String subject = 'Negotiations with ' + acctName;
        Account acct = new Account(Name = acctName);
        insert acct;
        Task tsk = [SELECT Id, Subject
                   FROM Task
                   WHERE WhatId IN
                   (SELECT Id FROM Account WHERE Account.Name = :acctName)];
        System.assertEquals(subject, tsk.Subject, 'Subject is not correct');
    }

    @IsTest static void testUpdateTasks() {
        insert new Account(Name = 'TestAccount');

        List<Task> tasks = new List<Task>();
        for (Account newAcct : [SELECT Id FROM Account]) {
            tasks.add(new Task(Subject='TaskExample', WhatId=newAcct.id, OwnerId='00509000002m7NxAAI'));
            tasks.add(new Task(Subject='TaskExample', WhatId=newAcct.id, OwnerId='00509000002m7NxAAI'));
            tasks.add(new Task(Subject='TaskExample', WhatId=newAcct.id, OwnerId='00509000004qb24AAA'));
            tasks.add(new Task(Subject='TaskExample', WhatId=newAcct.id, OwnerId='00509000004qb24AAA'));
            tasks.add(new Task(Subject='TaskExample', WhatId=newAcct.id, OwnerId='00509000004qb24AAA'));
        }

      insert tasks;
      Account newAcct = [SELECT Name FROM Account LIMIT 1];
      newAcct.Name = 'NewTestAccount';
      update newAcct;
      Set<Id> users = new Set<Id>();
      for (Task tsk : [SELECT OwnerId FROM Task WHERE Subject='TaskExample']) {
        users.add(tsk.OwnerId);
      }
      System.assertEquals(1, users.size(), 'Tasks were not assigned to 1 user');
    }
}