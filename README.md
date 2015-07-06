# SalesforceUtility
All Salesforce Utilities (Apex &amp; Visualforce)


    /*
    https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_class_Schema_RecordTypeInfo.htm
    
    String RECORD_TYPE_BUSINESS_ACCOUNT = 'Business Account';
    // Call the method for All record types of SObject
    RecordTypeUtility.getSObjectAllAvailableRecordTypes(Account.SobjectType);
    // Get the Record Type Name and ID
    String recordTypeId = RecordTypeUtility.getRecordTypeId(Account.SobjectType, RECORD_TYPE_BUSINESS_ACCOUNT, DescribeSchemaUtility.getSObjectAPIName('Account'));
    String recordTypeName = RecordTypeUtility.getRecordTypeName(Account.SobjectType, recordTypeId, DescribeSchemaUtility.getSObjectAPIName('Account'));
    // Verify / Assert Record Type Name and ID
    RecordType recordTypeRecord = [SELECT Id, Name FROM RecordType WHERE SObjectType = 'Account' AND Name = :RECORD_TYPE_BUSINESS_ACCOUNT LIMIT 1];
    System.assertEquals(RECORD_TYPE_BUSINESS_ACCOUNT, recordTypeRecord.Name);
    System.assertEquals(recordTypeId, recordTypeRecord.Id);
    */
