/**
* @author -         Abrar Haq (Tquila - now part of Accenture)
* @date -           06/07/2015
* @description -    Data Factory class for All Test classes
* #############Change Log#############
* Modified by     Version     Change Date
**/
@isTest
public class TestDataFactory{

    /*************************************************************************************** 
    * Author:       Abrar Haq (Tquila - now part of Accenture)
    * Date:         06/07/2015
    * Description:   Create record for a custom setting "Application_Setting__c" using a
    * static resource "ApplicationSettingResource"
    * ******************* Change Log *******************
    * Modified by    Version    Change Date
    ****************************************************************************************/ 
    public static List<Application_Setting__c> createApplicationCustomSetting(){
        // Create a sample .csv file "ApplicationSettingResource" and save it in Static Resource
        List<Application_Setting__c> applicationCustomSetting = Test.loadData(Application_Setting__c.sObjectType, 'ApplicationSettingResource');
        return applicationCustomSetting;
    }
    
    /***************************************************************************************************************************
    * Author:       Abrar Haq (Tquila - now part of Accenture)
    * Date:         06/07/2015
    * Description:  Populate Business Account object
    * ******************* Change Log *******************
    * Modified by    Version    Change Date
    **************************************************************************************************************************/
    public static Account createBusinessAccount(String accountName, String type, String industry, String recordTypeName) {
        Account accountRecord = new Account();
            accountRecord.Name      = accountName;
            accountRecord.Type       = type;
            accountRecord.Industry    = industry;
            //... Other fields
            accountRecord.RecordtypeId   = RecordTypeUtility.getRecordTypeId(Account.SobjectType, recordTypeName, DescribeSchemaUtility.getSObjectAPIName('Account'));
        return accountRecord;
    }

    /*************************************************************************************** 
    * Author:       Abrar Haq (Tquila - now part of Accenture)
    * Date:         06/07/2015
    * Description:  Populate Opportunity object
    * ******************* Change Log *******************
    * Modified by    Version    Change Date
    ****************************************************************************************/    
    public static Opportunity createOpportunity(String opptyName, String opptyStage, String recordTypeName, Account account){
        Opportunity opportunityRecord = new Opportunity();
            opportunityRecord.Name = opptyName;
            opportunityRecord.StageName = opptyStage;
            opportunityRecord.CloseDate = System.Today();
            opportunityRecord.AccountId = account.Id;
            //... Other fields
            opportunityRecord.RecordTypeId = RecordTypeUtility.getRecordTypeId(Opportunity.SobjectType, recordTypeName, DescribeSchemaUtility.getSObjectAPIName('Opportunity'));
        return opportunityRecord;
    }

    /*************************************************************************************** 
    * Author:       Abrar Haq (Tquila - now part of Accenture)
    * Date:         06/07/2015
    * Description:  Populate Product object
    * ******************* Change Log *******************
    * Modified by    Version    Change Date
    ****************************************************************************************/   
    public static Product2 createProduct(String prodName, String prodCode, String prodFamily, String recordTypeName, Boolean isActive){
        Product2 productRecord = new Product2();
            productRecord.Name = prodName;
            productRecord.ProductCode = prodCode;
            productRecord.Family = prodFamily;
            productRecord.IsActive = isActive;
            //... Other fields
            productRecord.RecordTypeId = RecordTypeUtility.getRecordTypeId(Product2.SobjectType, recordTypeName, DescribeSchemaUtility.getSObjectAPIName('Product2'));
        return productRecord;
    }
    
    /*************************************************************************************** 
    * Author:       Abrar Haq (Tquila - now part of Accenture)
    * Date:         06/07/2015
    * Description:  Populate PricebookEntry object
    * ******************* Change Log *******************
    * Modified by    Version    Change Date
    ****************************************************************************************/   
    public static PricebookEntry createPricebookEntry(Product2 product){
        //Get standard price book ID
        Id standardPriceBookId = Test.getStandardPricebookId();

        PricebookEntry pricebookEntryRecord = new PricebookEntry();
            pricebookEntryRecord.Pricebook2Id = standardPriceBookId;
            pricebookEntryRecord.Product2Id = product.Id;
            pricebookEntryRecord.UnitPrice = 100;
            pricebookEntryRecord.IsActive = true;
        return pricebookEntryRecord;
    }

    /*************************************************************************************** 
    * Author:       Abrar Haq (Tquila - now part of Accenture)
    * Date:         06/07/2015
    * Description:  Populate OpportunityLineItem object
    * ******************* Change Log *******************
    * Modified by    Version    Change Date
    ****************************************************************************************/   
    public static OpportunityLineItem createOpportunityLineItem(Opportunity oppty, PricebookEntry pricebookEntryRecord){
        OpportunityLineItem opportunityLineItemRecord = new OpportunityLineItem();
            opportunityLineItemRecord.OpportunityId = oppty.Id;
            opportunityLineItemRecord.PriceBookEntryId = pricebookEntryRecord.Id;
            opportunityLineItemRecord.Quantity = 10;
            opportunityLineItemRecord.UnitPrice = 100;
            //... Other fields
        return opportunityLineItemRecord;
    }

    /***************************************************************************************************************************
    * Author:       Abrar Haq (Tquila - now part of Accenture)
    * Date:         06/07/2015
    * Description:  Populate Profile object
    * ******************* Change Log *******************
    * Modified by    Version    Change Date
    **************************************************************************************************************************/
    public static Profile getProfile(String profileName){
        Profile userProfile = [SELECT Id FROM Profile WHERE Name = :profileName LIMIT 1];
        return userProfile;
    }

    /***************************************************************************************************************************
    * Author:       Abrar Haq (Tquila - now part of Accenture)
    * Date:         06/07/2015
    * Description:  Populate User object
    * ******************* Change Log *******************
    * Modified by    Version    Change Date
    **************************************************************************************************************************/
    public static User getUser(String userName, Profile userProfile) {
        User userRecord = new User();
            userRecord.Alias = 'TESTU';
            userRecord.Email = 'testuser.salesforce@salesforce.com';
            userRecord.EmailEncodingKey = 'UTF-8';
            userRecord.LastName = 'Test User';
            userRecord.LanguageLocaleKey = 'en_US';
            userRecord.LocaleSidKey = 'en_US';
            userRecord.TimeZoneSidKey = 'America/Los_Angeles';
            userRecord.UserName = userName;
            userRecord.ProfileId = userProfile.Id;
            userRecord.FederationIdentifier = 'FID-abcde12345';
            //... Other fields
        return userRecord;
    }

}