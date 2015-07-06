# SalesforceUtility
<h3>All Salesforce Utilities (Apex &amp; Visualforce)</h3>

<ul>
  <li>TestDataFactory</li>
  <li>SampleTest</li>
  <li>RecordTypeUtility</li>
  <li>DescribeSchemaUtility</li>
</ul>

<h5>TestDataFactory</h5><p>Data Factory class for All @Test classes</p>

<h5>SampleTest</h5><p>A sample @Test class to call Data Factory class using setupCommonData (@testSetup) method</p>

<h5>RecordTypeUtility</h5><p>Data Factory class for All @Test classes</p>

/********* Test RecordTypeUtility *********/

String RECORD_TYPE_BUSINESS_ACCOUNT = 'Business Account';

// Call the method for All record types of SObject
RecordTypeUtility.getSObjectAllAvailableRecordTypes(Account.SobjectType);

// Get the Record Type ID
String recordTypeId = RecordTypeUtility.getRecordTypeId(Account.SobjectType, RECORD_TYPE_BUSINESS_ACCOUNT, DescribeSchemaUtility.getSObjectAPIName('Account'));

// Get the Record Type Name
String recordTypeName = RecordTypeUtility.getRecordTypeName(Account.SobjectType, recordTypeId, DescribeSchemaUtility.getSObjectAPIName('Account'));

// Verify / Assert Record Type Name and ID
RecordType recordTypeRecord = [SELECT Id, Name FROM RecordType WHERE SObjectType = 'Account' AND Name = :RECORD_TYPE_BUSINESS_ACCOUNT LIMIT 1];
System.assertEquals(RECORD_TYPE_BUSINESS_ACCOUNT, recordTypeRecord.Name);
System.assertEquals(recordTypeId, recordTypeRecord.Id);

<a href="https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_class_Schema_RecordTypeInfo.htm" target="_blank" alt="RecordTypeInfo Class">Read more about "RecordTypeInfo Class"</a>

<br/>

<h5>DescribeSchemaUtility</h5><p>Describe Schema call to get:</p> 
<ul>
  <li>All your Salesforce org objects</li>
  <li>Specific SObject API Name</li>
  <li>Mutiple SObject Atributes (Label, API Name, Custom/Standard, CustomSetting/CustomObject)</li>
  <li>Field Label & API Name</li>
  <li>Picklist Values for a Picklist Field</li>
  <li>All Fields in the Field Set (Dynamically generate SOQL query using a Feild Set)</li>
  <li>All Fields in the Field Set</li>
</ul>

<h6>getAllSObjects()</h6><p>Get All Objects API Name (e.g. Lead, Account, OpportunityLineItem etc.)</p>
<a href="https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_schema.htm" target="_blank" alt="Schema Class">Read more about "Schema Class"</a>

<h6>getSObjectAttributes()</h6><p>Get Multiple SObject Attributes (getKeyPrefix, getLabel, getName, isCustom, isCustomSetting)</p>
<a href="https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_schema.htm" target="_blank" alt="Schema Class">Read more about "Schema Class"</a>

<h6>getSObjectAPIName()</h6><p>Get specific Object API Name (e.g. Lead, Account, OpportunityLineItem etc.)</p>
<a href="https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_schema.htm" target="_blank" alt="Schema Class">Read more about "Schema Class"</a>

<b>Note:</b> <br/>
Error: If you pass wrong SObject API Name you will get an error:
System.InvalidParameterValueException: Invalid sobject provided. The Schema.describeSObject() methods does not support the Merchandise sobject as a parameter. The sobject provided does not exist.

<h6>getSObjectAllFields()</h6><p>Get all fields of a specific object (e.g. Lead, Account etc.)</p>

<h6>getFieldAPIName()</h6><p>Get Field API Name (e.g. AccountNumber etc.)</p>

<h6>getFieldLabel()</h6><p>Get Field Label (e.g. Account Number etc.)</p>

<h6>getFieldPicklistValues()</h6><p>Get Picklist values of a specific Field of an Object</p>

<h6>getFieldSetMemebers()</h6><p>Get list of Feild Set members (Field API Name, Field Label, Field Type, Field Required, Field DB Required)</p>

/********* Test getFieldSetMemebers method *********/ <br/>
List<Schema.FieldSetMember> fieldSetMemberList = DescribeSchemaUtility.getFieldSetMemebers(Account.SobjectType, 'Account_FieldSet');
// Build a Query for Account records
String soql = 'SELECT ';
for(Schema.FieldSetMember f : fieldSetMemberList) {
    soql += f.getFieldPath() + ', ';
}
soql += 'Id FROM Account Order By Name';
System.Debug('>>soql<<'+soql);

List<Account> lstAccounts = Database.query(soql); 
System.Debug('>>lstAccounts<<'+lstAccounts);
