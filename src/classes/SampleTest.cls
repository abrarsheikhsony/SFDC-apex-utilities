/**
* @author -         Abrar Haq (Tquila - now part of Accenture)
* @date -           06/07/2015
* @description -    Sample Test class
* #############Change Log#############
* Modified by     Version     Change Date
**/
@isTest
private class SampleTest{
    // For Account
    static String businessAccountRecordType = 'Business Account';
    static String accountName = 'Salesforce Limited';
    static String accountType = 'Resellers';
    static String accountIndustry = 'Technology';    
    // For Opportunity
    static String opptyRecordType = 'Opportunity RecordType';
    static String opptyName = 'Salesforce Opportunity Special';    
    static String opptyStage = 'Prospecting';
    // For Product
    static String prodRecordType = 'Product RecordType';
    static String prodName = 'Salesforce Sales Cloud';    
    static String prodCode = 'SFDC-1001';    
    static String prodFamily = 'Sales';
    static Boolean isProductActive = true;     
    // USER NAME
    static String userName = 'testuser.salesforce@salesforce.com';
    // USER PROFILE
    static String userProfileSystemAdmin = 'System Administrator';

    /*    
    Considerations for @testSetup:
    -If a test class contains a test setup method, the test setup method executes first, before any test method in the class.
    -Records that are created in a test setup method are available to all test methods in the test class and are rolled back at the end of test class execution.
    -If a test method changes those records, such as record field updates or record deletions, those changes are rolled back after each test method finishes execution. The next executing test method gets access to the original unmodified state of those records.
    -It takes no arguments, and return no value.
        @testSetup static void methodName(){
        }
    -@testSetup method only works with the default data isolation mode "@isTest(SeeAllData=true)" for a test class.
    It does not work with "@isTest(​SeeAllData=​true)". Because data isolation for tests is available for API versions 24.0 and later, test setup methods are also available for those versions only.
    Otherwise you will get an error:
    Test class containing a test setup method cannot be annotated with @isTest(​SeeAllData=​true)
    -Multiple @testSetup methods are allowed in a test class, but the order in which they’re executed by the testing framework isn’t guaranteed.
    -If a fatal error occurs during the execution of a @testSetup method, such as an exception that’s caused by a DML operation or an assertion failure, the entire test class fails, and no further tests in the class are executed.
    -If a @testSetup method calls a non-test method of another class, no code coverage is calculated for the non-test method.
    */
    @testSetup static void setupCommonData(){
        // Create custom setting "Application_Setting__c" records using a static resource "ApplicationSettingResource"
        List<Application_Setting__c> applicationCustomSetting = TestDataFactory.createApplicationCustomSetting();

        // Create Account
        Account accountRecord = TestDataFactory.createBusinessAccount(accountName, accountType, accountIndustry, 'businessAccountRecordType');
        insert accountRecord;
        // Create Opportunity
        Opportunity opptyRecord = TestDataFactory.createOpportunity(opptyName, opptyStage, 'opptyRecordType', accountRecord);
        insert opptyRecord;
        // Create Product
        Product2 prodRecord = TestDataFactory.createProduct(prodName, prodCode, prodFamily, 'prodRecordType', isProductActive);
        insert prodRecord;
        // Create PricebookEntry
        PricebookEntry pricebookEntryRecord = TestDataFactory.createPricebookEntry(prodRecord);
        insert pricebookEntryRecord;
        // Create OpportunityLineItem
        List<OpportunityLineItem> lstOpportunityLineItems = new List<OpportunityLineItem>();
        for(Integer index=0; index<=10; index++){
            OpportunityLineItem opportunityLineItemRecord = TestDataFactory.createOpportunityLineItem(opptyRecord, pricebookEntryRecord);
            lstOpportunityLineItems.add(opportunityLineItemRecord);
        }
        insert lstOpportunityLineItems;
    }

    @isTest static void testSampleTestCase(){
        // Get Profile and User for 'System Administrator'
        Profile systemAdminProfile = TestDataFactory.getProfile(userProfileSystemAdmin);
        // Get User record
        User systemAdminUser = TestDataFactory.getUser(userName, systemAdminProfile);

        // Test functionality with user 'System Administrator'
        System.runAs(systemAdminUser){
            // Logic here....
            Test.startTest();

            Test.stopTest();            
            
            // System.assert();
            // System.assertEquals();
            // System.assertNotEquals();
        }
    }
        
}