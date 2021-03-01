
global class AccountHandler
{
    @InvocableMethod(label='Create new Task'
                     description='When new Account is created, create new Task object')

    global static void CreateTaskForAccount(List<Id> IDs)
    {
        List<Account> allAccts = [SELECT Id, Name FROM Account WHERE Account.Id IN :IDs];
        List<Task> allTsks = [SELECT Subject, WhatId FROM Task WHERE Account.Id IN :allAccts];
        List<Task> upsertTsks = new List<Task>();

        for (Account acct : allAccts)
        {
            List<Task> acctTsks = new List<Task>();

            for (Task task : allTsks)
            {
                if (acct.Id == task.WhatId)
                {
                    acctTsks.add(task);
                }
            }

            if (acctTsks.size() > 3)
            {
                // TODO
            }

            else
            {
                Task tsk = new Task();
                String subject = 'Negotiations with ' + acct.Name;
                tsk.Subject = subject;
                tsk.WhatId = acct.Id;
                upsertTsks.add(tsk);
            }
        }

        upsert upsertTsks;
    }
}