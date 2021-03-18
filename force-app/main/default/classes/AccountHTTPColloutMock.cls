@isTest
global class AccountHTTPColloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json;charset=UTF-8');
        response.setBody('{"name" : "Test 0001"}');
        response.setStatusCode(200);
        return response;
    }
}