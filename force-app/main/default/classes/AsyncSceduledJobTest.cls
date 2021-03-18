@IsTest
private class AsyncSceduledJobTest {
    public static String CRON_EXP = '0 30 * * * ?';
    @IsTest static void testAsyncSceduledJob() {
        List<Account> accts = [SELECT Id, Name FROM Account WHERE Updated_By_Task__c = true];
        Map<Id, Account> acctMap = new Map<Id, Account>(accts);
        List<Id> acctsId = new List<Id>(acctMap.keySet());
        Test.startTest();
        String jobId = System.schedule('ScheduleApexTest', CRON_EXP, new SceduledJobTaskContact());
        Test.stopTest();
        List<Task> tsks = [SELECT Id, Is_Synced__c FROM Task WHERE WhatId IN : acctsId AND Is_Synced__c = true];
        System.assertEquals(acctsId.size(), tsks.size());
    }
}