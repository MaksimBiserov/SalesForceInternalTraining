public class AsyncFuture {
    @future
    public static void UpdateContacts() {
        List<Account> accounts = [SELECT ID, BillingAddress, 
                                 (SELECT ID, Is_Synced__c, Processed_By_Future__c FROM Contacts)
                                 FROM Account LIMIT 150];

        List<Contact> contacts = new List<Contact>();

        for (Account acct : accounts) {            
            if(acct.BillingAddress != null) {
                for (Contact cont : acct.contacts) {
                    cont.Is_Synced__c = false;
                    cont.Processed_By_Future__c = true;
                    contacts.add(cont);           
                }
            }             
        }

        update contacts;
    }
}

// Invoke:
// AsyncFuture.UpdateContacts();