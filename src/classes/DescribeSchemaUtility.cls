/**
* @author -         Abrar Haq (Tquila - now part of Accenture)
* @date -           06/07/2015
* @description -    A Utility class for Describe/Schema functions 
* #############Change Log#############
* Modified by     Version     Change Date
**/
public with sharing class DescribeSchemaUtility{
    
    // Field Label >> Field API Name
    public static Map<String, String> mapFieldLabelandAPIName = new Map<String, String>();
    // Field API Name >> Field Label
    public static Map<String, String> mapFieldAPINameandLabel = new Map<String, String>();

    /*************************************************************************************** 
    Developer -    Abrar Haq (Tquila - now part of Accenture)
    Date -         06/07/2015
    Version -      1.0 
    Function -     Get Object API Name (e.g. Lead, Account, OpportunityLineItem etc.)
    #############Change Log#############
    Modified by     Version     Change Date
    ****************************************************************************************/
    public static void getAllSObjects(){
        Map<String, Schema.SObjectType> allSObjects = Schema.getGlobalDescribe(); 
        System.Debug('>> allSObjects <<'+ allSObjects);
    }

    /*************************************************************************************** 
    Developer -    Abrar Haq (Tquila - now part of Accenture)
    Date -         06/07/2015
    Version -      1.0 
    Function -     Get SObject Attributes
    #############Change Log#############
    Modified by     Version     Change Date
    ****************************************************************************************/
    public static void getSObjectAttributes(){
        Schema.DescribeSObjectResult[] descSObjectResult = Schema.describeSObjects(new String[]{'Account','Contact', 'Application_Setting__c'});
        System.Debug('>> descSObjectResult <<'+ descSObjectResult);
        for(Schema.DescribeSObjectResult dr : descSObjectResult){
            System.Debug('>>getKeyPrefix <<'+dr.getKeyPrefix());    
            System.Debug('>>getLabel <<'+dr.getLabel());    
            System.Debug('>>getName <<'+dr.getName());    
            System.Debug('>>isCustom <<'+dr.isCustom());    
            System.Debug('>>isCustomSetting <<'+dr.isCustomSetting());    
        }    
    }

    /*************************************************************************************** 
    Developer -    Abrar Haq (Tquila - now part of Accenture)
    Date -         06/07/2015
    Version -      1.0 
    Function -     Get Object API Name (e.g. Lead, Account, OpportunityLineItem etc.)
    #############Change Log#############
    Modified by     Version     Change Date
    ****************************************************************************************/
    public static String getSObjectAPIName(String pObjectType){
        List<Schema.DescribeSObjectResult> describeSobjectsResult = Schema.describeSObjects(new List<String>{pObjectType});
        String objectAPIName = describeSobjectsResult[0].getName();
        return objectAPIName;
    }

    /*************************************************************************************** 
    Developer -    Abrar Haq (Tquila - now part of Accenture)
    Date -         06/07/2015
    Version -      1.0 
    Function -     Get all fields of a specific object (e.g. Lead, Account etc.)
    #############Change Log#############
    Modified by     Version     Change Date
    ****************************************************************************************/
    public static void getSObjectAllFields(Schema.SObjectType sObjType){
        // Get All related fields of a specific SObject Type (e.g. Lead, Account etc.)
        Map<String, Schema.SObjectField> mapFields = sObjType.getDescribe().fields.getMap();
        // Process All fields and populate a map with Field Label >> Field API Name
        for(String fieldAPIName : mapFields.keySet()){
            mapFieldLabelandAPIName.put( mapFields.get(fieldAPIName).getDescribe().getLabel(), String.ValueOf( mapFields.get(fieldAPIName) ) );
            mapFieldAPINameandLabel.put( String.ValueOf( mapFields.get(fieldAPIName) ), mapFields.get(fieldAPIName).getDescribe().getLabel() );
            System.Debug('>>Field Label<<'+mapFields.get(fieldAPIName).getDescribe().getLabel()+'>>Field API Name<<'+mapFields.get(fieldAPIName));
        }
    }

    /*************************************************************************************** 
    Developer -    Abrar Haq (Tquila - now part of Accenture)
    Date -         06/07/2015
    Version -      1.0 
    Function -     Get Field API Name (e.g. Status etc.)
    #############Change Log#############
    Modified by     Version     Change Date
    ****************************************************************************************/
    public static String getFieldAPIName(Schema.SObjectType sObjType, String pFieldLabel){
        // contains Field API Name
        String fieldAPIName = '';
        // Get all fields of a specific object (e.g. Lead, Account etc.)
        getSObjectAllFields(sObjType);
        // Verify the Field Label is present or not
        if( mapFieldLabelandAPIName.containsKey(pFieldLabel) ){
            fieldAPIName = mapFieldLabelandAPIName.get(pFieldLabel);
        }
        System.Debug('>>Field API Name<<'+ fieldAPIName);
        return fieldAPIName;
    }
        
    /*************************************************************************************** 
    Developer -    Abrar Haq (Tquila - now part of Accenture)
    Date -         06/07/2015
    Version -      1.0 
    Function -     Get Field Label (e.g. Status etc.)
    #############Change Log#############
    Modified by     Version     Change Date
    ****************************************************************************************/
    public static String getFieldLabel(Schema.SObjectType sObjType, String pFieldAPIName){
        // contains Field API Name
        String fieldLabel = '';
        // Get all fields of a specific object (e.g. Lead, Account etc.)
        getSObjectAllFields(sObjType);
        // Verify the Field Label is present or not
        if( mapFieldAPINameandLabel.containsKey(pFieldAPIName) ){
            fieldLabel = mapFieldAPINameandLabel.get(pFieldAPIName);
        }
        System.Debug('>>Field Label<<'+ fieldLabel);
        return fieldLabel;
    }
        
    /*************************************************************************************** 
    Developer -    Abrar Haq (Tquila - now part of Accenture)
    Date -         06/07/2015
    Version -      1.0 
    Function -     Get list of Feild Set members (Field API Name, Field Label, Field Type, Field Required, Field DB Required)
    #############Change Log#############
    Modified by     Version     Change Date
    ****************************************************************************************/
    public static List<Schema.FieldSetMember> getFieldSetMemebers(Schema.SObjectType sObjType, String fieldSetAPIName){        
        Schema.DescribeSObjectResult DescribeSObjectResultObj = sObjType.getDescribe();                
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetAPIName);        
        System.Debug('>>fieldSetObj.getFields()<<'+fieldSetObj.getFields());
        return fieldSetObj.getFields(); 
    }

    /*************************************************************************************** 
    Developer -    Abrar Haq (Tquila - now part of Accenture)
    Date -         06/07/2015
    Version -      1.0 
    Function -     Get Picklist values of a specific Field of an Object
    #############Change Log#############
    Modified by     Version     Change Date
    ****************************************************************************************/
    public static Map<String, String> getFieldPicklistValues(Schema.SObjectType sObjType, String pFieldAPIName){
        // Contains Field Label and Field API Name
        // Picklist Label >> Picklist Value
        Map<String, String> mapPicklistValues = new Map<String, String>();
        
        // Get the specific SObject Type (e.g. Lead, Account etc.)
        //SObjectType objectType = Schema.getGlobalDescribe().get(pObjectType);
        // Get All related fields of a specific SObject Type (e.g. Lead, Account etc.)
        Map<String, Schema.SObjectField> mapFields = sObjType.getDescribe().fields.getMap();
        // Get the Picklist Values for a specific 
        list<Schema.PicklistEntry> lstPicklistValues = mapFields.get(pFieldAPIName).getDescribe().getPickListValues();
        // Add these values to the selectoption list.
        for(Schema.PicklistEntry picklist : lstPicklistValues){ 
            mapPicklistValues.put(picklist.getLabel(), picklist.getValue());
            System.Debug('>>PicklistLabel<<'+picklist.getLabel()+'>>picklist.getValue()<<'+picklist.getValue());
        }
        return mapPicklistValues;
    }

}