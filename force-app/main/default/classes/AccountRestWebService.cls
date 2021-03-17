@RestResource(urlMapping='/Account/*')
global with sharing class AccountRestWebService {
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;        
        String acctId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        Account result =  [SELECT ID, Name FROM Account WHERE Id = :acctId];
        return result;
    }
    
    @HttpPost
    global static ID createAccount(String name) {
        Account acct = new Account(Name = name);
        insert acct;
        return acct.Id;
    }
    
    @HttpDelete
    global static void deleteAccount() {
        RestRequest request = RestContext.request;
        String acctId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        Account acct = [SELECT Id FROM Account WHERE Id = :acctId];
        delete acct;
    }
    
    @HttpPut
    global static ID upsertAccount(String acctId, String acctName) {
        Account acct = new Account(Id = acctId, Name = acctName);
        upsert acct;
        return acct.Id;
    }
    
    @HttpPatch
    global static ID updateAccount() {
        RestRequest request = RestContext.request;
        String acctId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        Account acct = [SELECT Id FROM Account WHERE Id = :acctId];
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.toString());

        for(String fieldName : params.keySet()) {
            acct.put(fieldName, params.get(fieldName));
        }
        
        update acct;
        return acct.Id;
    }
}