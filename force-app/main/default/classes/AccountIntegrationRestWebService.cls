public with sharing class AccountIntegrationRestWebService {
    public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;
 
    public static HttpResponse getAccount(Id acctId) {
        request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:SalesforceAccount/services/apexrest/Account/' + acctId);
        response = http.send(request);
        System.debug(response.getBody());
        return response;
    }
 
    public static HttpResponse createAccount(String acctName) {
        request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('callout:SalesforceAccount/services/apexrest/Account/');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name" : "' + acctName + '"}');
        response = http.send(request); 
        System.debug(response.getBody());
        return response;
    }
    
    public static HttpResponse deleteAccount(Id acctId) {
        request = new HttpRequest();
        request.setMethod('DELETE');
        request.setEndpoint('callout:SalesforceAccount/services/apexrest/Account/' + acctId);
        response = http.send(request); 
        System.debug(response.getBody());
        System.debug(acctId + ' deleted');
        return response;
    }
    
    public static HttpResponse upsertAccount(String acctName, String acctId) {
        request = new HttpRequest();
        request.setMethod('PUT');
        request.setEndpoint('callout:SalesforceAccount/services/apexrest/Account/' + acctId);
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"id": "' + acctId + '", "name": "' + acctName + '"}');
        response = http.send(request);
        System.debug(response.getBody());
        return response;
    }
    
    public static HttpResponse updateAccount(Id acctId, String acctName) {
        request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('callout:SalesforceAccount/services/apexrest/Account/' + acctId + '?_HttpMethod=PATCH');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name" : "' + acctName + '"}');
        response = http.send(request);
        System.debug(response.getBody());
        System.debug('Renamed to ' + acctName);
        return response;
    }
}