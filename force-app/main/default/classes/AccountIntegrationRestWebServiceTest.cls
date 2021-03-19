@isTest
private class AccountIntegrationRestWebServiceTest {
    
    @isTest static void testGetAccount() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAccountResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mock);
        Test.stopTest();
        HttpResponse response = AccountIntegrationRestWebService.getAccount('0010900000BulcBAAR');
        System.assertEquals(200, response.getStatusCode(), 'Status is not correct.');
        System.assertEquals('application/json;charset=UTF-8',
                            response.getHeader('Content-Type'),
                            'Content-Type is not correct.');
        
        Map<String, Object> responses = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        System.assertEquals('Test 0001', responses.get('Name'));
    }
    
    @isTest static void testCreateAccount() {
        Test.setMock(HttpCalloutMock.class, new AccountHTTPColloutMock());
        HttpResponse response = AccountIntegrationRestWebService.createAccount('Test 0001');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json;charset=UTF-8');
        String actualValue = response.getBody();
        String expectedValue = '{"name" : "Test 0001"}';
        System.assertEquals(actualValue, expectedValue, 'Name is not correct.');
        System.assertEquals(200, response.getStatusCode(), 'Status is not correct.');
    }
    
    @isTest static void testDeleteAccount() {
        Test.setMock(HttpCalloutMock.class, new AccountHTTPColloutMock());
        HttpResponse response = AccountIntegrationRestWebService.deleteAccount('0010900000BtynDAAR');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json;charset=UTF-8');
        System.assertEquals(200, response.getStatusCode(), 'Status is not correct.');
    }
    
    @isTest static void testUpsertAccount() {
        Test.setMock(HttpCalloutMock.class, new AccountHTTPColloutMock());
        HttpResponse response1 = AccountIntegrationRestWebService.upsertAccount('Test 0001', '');
        HttpResponse response2 = AccountIntegrationRestWebService.upsertAccount('Test 0001', '0010900000BulcBAAR');
        String contentType = response1.getHeader('Content-Type');
        System.assert(contentType == 'application/json;charset=UTF-8');
        System.assertEquals(200, response1.getStatusCode(), 'Status is not correct.');
        String value = response1.getBody();
        String newValue = '{"name" : "Test 0001"}';
        System.assertEquals(value, newValue, 'Name is not correct.');
        contentType = response2.getHeader('Content-Type');
        System.assert(contentType == 'application/json;charset=UTF-8');
        System.assertEquals(200, response2.getStatusCode(), 'Status is not correct.');
        value = response2.getBody();
        newValue = '{"name" : "Test 0001"}';
        System.assertEquals(value, newValue, 'Name is not correct.');
    }

    @isTest static void testUpdateAccount() {
        Test.setMock(HttpCalloutMock.class, new AccountHTTPColloutMock());
        HttpResponse response = AccountIntegrationRestWebService.updateAccount('0010900000BulcBAAR', 'Test 0001');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json;charset=UTF-8');
        System.assertEquals(200, response.getStatusCode(), 'Status is not correct.');
        String value = response.getBody();
        String newValue = '{"name" : "Test 0001"}';
        System.assertEquals(value, newValue, 'Name is not correct.');
    }
}