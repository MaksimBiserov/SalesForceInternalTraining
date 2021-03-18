@isTest
private class AccountIntegrationRestWebServiceTest {
    @IsTest static void testAccountCreator() {
        AccountIntegrationRestWebService.NewAccountCreator acct = new AccountIntegrationRestWebService.NewAccountCreator();
        String acctName = 'Test';
        acct.Name = acctName;
        System.assertEquals(acct.Name, acctName);
    }
    @isTest static void testGetAccount() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAccountResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        HttpResponse result = AccountIntegrationRestWebService.getAccount('0010900000BulcBAAR');
        System.assertNotEquals(null, result, 'The callout returned a null response');
        System.assertEquals(200, result.getStatusCode(),
                           'The status code is not 200');
        System.assertEquals('application/json;charset=UTF-8',
                           result.getHeader('Content-Type'),
            			'The content type value is not expected.');
        
        Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(result.getBody());
        System.assertEquals('From Workbench Updated', results.get('Name'));
    }
    //@isTest static void testCreateAccount() {
        //Test.setMock(HttpCalloutMock.class, new AccountHTTPColloutMock());
        //HttpResponse response = AccountIntegrationRestWebService.createAccount();
        //String contentType = response.getHeader('Content-Type');
        //System.assert(contentType == 'application/json;charset=UTF-8');
        //String actualValue = response.getBody();
        //String expectedValue = '{"name" : "Test 0001"}';
        //System.assertEquals(actualValue, expectedValue);
        //System.assertEquals(200, response.getStatusCode());
    //}
    @isTest static void testDeleteAccount() {
        Test.setMock(HttpCalloutMock.class, new AccountHTTPColloutMock());
        HttpResponse response = AccountIntegrationRestWebService.deleteAccount('0010900000BtynDAAR');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json;charset=UTF-8');
        System.assertEquals(200, response.getStatusCode());
    }

    @isTest static void testUpdateAccount() {
        Test.setMock(HttpCalloutMock.class, new AccountHTTPColloutMock());
        HttpResponse response = AccountIntegrationRestWebService.updateAccount('0010900000BulcBAAR', 'Test 0001');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json;charset=UTF-8');
        System.assertEquals(200, response.getStatusCode());
        String actualValue = response.getBody();
        String expectedValue = '{"name" : "testPatchCallout"}';
        System.assertEquals(actualValue, expectedValue);
    }
}