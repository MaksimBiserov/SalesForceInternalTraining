@IsTest
private class QueueableUpdateContactsTest {
    @IsTest static void testQueueableUpdateContacts() {
        List<Id> acctsId = insertAccountData(150, false, true);
        Test.startTest();
        System.enqueueJob(new QueueableUpdateContacts(acctsId));
        Test.stopTest();
        List<Contact> conts = [SELECT Id 
                              FROM Contact 
                              WHERE Is_Synced__c = FALSE AND Processed_By_Queue__c = TRUE];
        System.assertEquals(150, conts.size());
    }

    public static List<Id> insertAccountData(Integer acctCount, Boolean isSynced, Boolean ProcessedByQueue) {
        List<Account> accts = new List<Account>();
        List<Id> acctsId = new List<Id>();
        List<Contact> conts = new List<Contact>();
        for (Integer i = 0; i < acctCount; i++) {
            Account acct = new Account();
            acct.Name = 'Name' + i;
            accts.add(acct);
        }
        insert accts;
        for (Account acct : accts) {
            Contact cont = new Contact();
            cont.LastName = 'Contact by' + acct.Name;
            cont.Processed_By_Queue__c = ProcessedByQueue;
            cont.AccountId = acct.Id;
            cont.Is_Synced__c = isSynced;
            conts.add(cont);
            acctsId.add(acct.Id);
        }

        insert conts;
        return acctsId;
    }
}