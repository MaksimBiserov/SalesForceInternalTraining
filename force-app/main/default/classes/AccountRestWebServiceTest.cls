@IsTest
private class AccountRestWebServiceTest {
    @isTest static void testGetAccount() {
        Account testAcct = new Account(Name = 'Test 01');
        insert testAcct;
        RestRequest request = new RestRequest();
        request.requestUri = 'https://freelance167-dev-ed.my.salesforce.com/services/apexrest/Account/' + testAcct.Id;
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account acct = AccountRestWebService.getAccount();
        System.assert(acct != null);
        System.assertEquals('Test 01', acct.Name);
    }

    @isTest static void testCreateAccount() {
        ID acctId = AccountRestWebService.createAccount('Test 02');
        System.assert(acctId != null);
        Account acct = [SELECT Id, Name FROM Account WHERE Id =: acctId];
        System.assert(acct != null);
        System.assertEquals(acct.Name, 'Test 02');
    }

    @isTest static void testDeleteAccount() {
        Account testAcct = new Account(Name = 'Test 01');
        insert testAcct;
        RestRequest request = new RestRequest();
        request.requestUri = 'https://freelance167-dev-ed.my.salesforce.com/services/apexrest/Account/' + testAcct.Id;
        request.httpMethod = 'GET';
        RestContext.request = request;
        AccountRestWebService.deleteAccount();
        List<Account> accts = [SELECT Id FROM Account WHERE Id =: testAcct.Id];
        System.assert(accts.size() == 0);
    }

    @isTest static void testUpsertAccount() {
        ID acctId = AccountRestWebService.upsertAccount('Test 03', '');
        Account acct = [SELECT Id, Name FROM Account WHERE Id =: acctId];
        System.assertEquals('Test 03',acct.Name);
        ID upsertAcctId = AccountRestWebService.upsertAccount('Test 04', acctId);
        System.assertEquals(acctId, upsertAcctId);
        Account upsertAcct = [SELECT Id, Name FROM Account WHERE Id =: upsertAcctId];
        System.assertEquals('Test 04', upsertAcct.Name);
    }

    @isTest static void testUpdateAccount() {
        Account testAcct = new Account(Name = 'Test 01');
        insert testAcct;
        RestRequest request = new RestRequest();
        request.requestUri = 'https://freelance167-dev-ed.my.salesforce.com/services/apexrest/Account/' + testAcct.Id;
        request.httpMethod = 'PATCH';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"Rating": "Hot"}');
        RestContext.request = request;
        ID acctId = AccountRestWebService.updateAccount();
        System.assert(acctId != null);
        Account thisAccount = [SELECT Id, Rating FROM Account WHERE Id =: acctId];
        System.assert(thisAccount != null);
        System.assertEquals(thisAccount.Rating, 'Hot');
    }
}