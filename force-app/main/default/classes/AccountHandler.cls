
global class AccountHandler
{
    @InvocableMethod

    global static void CreateTaskForAccount(List<Id> IDs)
    {
        List<Account> allAccts = [SELECT Id, Name FROM Account WHERE Account.Id IN :IDs];
        List<Task> allTsks = [SELECT Subject, OwnerId, WhatId FROM Task WHERE Account.Id IN :allAccts];
        List<Task> upsertTsks = new List<Task>();
        List<User> users = [SELECT Name FROM User];
        List<Task> acctTsks;

        for (Account acct : allAccts)
        {
            acctTsks = new List<Task>();

            for (Task tsk : allTsks)
            {
                if (acct.Id == tsk.WhatId)
                {
                    acctTsks.add(tsk);
                }
            }

            if (acctTsks.size() > 3)
            {
                Integer rnd = Integer.valueOf(Math.random() * users.size());

                for (Task updateTsks : acctTsks)
                {
                    updateTsks.OwnerId = users.get(rnd).Id;
                    upsertTsks.add(updateTsks);
                }
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