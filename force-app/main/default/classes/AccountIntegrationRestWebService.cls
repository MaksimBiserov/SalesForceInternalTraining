public with sharing class AccountIntegrationRestWebService {
    public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;
    
    public class NewAccountCreator {
        public String name {get; set;}
    }
 
    public static void getAccount(Id acctId) {
        request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:SalesforceAccount/services/apexrest/Account/' + acctId);
        response = http.send(request);
        System.debug(response.getBody());
    }
 
    public static void createAccount(NewAccountCreator newAccount) {
        request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('callout:SalesforceAccount/services/apexrest/Account/');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(JSON.serialize(newAccount));
        response = http.send(request); 
        System.debug(response.getBody());
    }
    public static void deleteAccount(Id acctId) {
        request = new HttpRequest();
        request.setMethod('DELETE');
        request.setEndpoint('callout:SalesforceAccount/services/apexrest/Account/' + acctId);
        response = http.send(request); 
        System.debug(response.getBody());
        System.debug(acctId + ' deleted');
    }
    
    public static void upsertAccount(Id acctId, String acctName) {
        request = new HttpRequest();
        request.setMethod('PUT');
        request.setEndpoint('callout:SalesforceAccount/services/apexrest/Account/');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"id": "' + acctId + '", "name": "' + acctName + '"}');
        response = http.send(request);
        System.debug(response.getBody());
    }
    
    public static void updateAccount(Id acctId, String acctName) {
        request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('callout:SalesforceAccount/services/apexrest/Account/' + acctId + '?_HttpMethod=PATCH');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name" : "' + acctName + '"}');
        response = http.send(request);
        System.debug(response.getBody());
        System.debug('Renamed to ' + acctName);
    }
}