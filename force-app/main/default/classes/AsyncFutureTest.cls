@IsTest
private class AsyncFutureTest {
    @IsTest static void testAsyncFuture() {
        insertAccountData(150, true, false);
        Test.startTest();
        AsyncFuture.UpdateContacts();
        Test.stopTest();
        List<Contact> conts = [SELECT Id
                              FROM Contact
                              WHERE Is_Synced__c = FALSE AND Processed_By_Future__c = TRUE];
        System.assert(conts.size() == 150);
    }

    public static void insertAccountData(Integer acctCount, Boolean isSynced, Boolean updated) {
        List<Account> accts = new List<Account>();
        List<Contact> conts = new List<Contact>();

        for (Integer i = 0; i < acctCount; i++) {
            Account acct = new Account();
            acct.Name = 'Name' + i;
            acct.BillingCountry = 'BillingCountry';
            acct.BillingState = 'BillingState';
            acct.BillingCity = 'Billing city';
            acct.BillingStreet = 'BillingStreet';
            acct.BillingPostalCode = 'BillingPostalCode';
            acct.Updated_By_Contact__c = updated;
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
    }
}