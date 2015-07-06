/**
* @author -         Abrar Haq (Tquila - now part of Accenture)
* @date -           06/07/2015
* @description -    A utility class to get Record Type Id and Record Type Name
* #############Change Log#############
* Modified by     Version     Change Date
**/
public class RecordTypeUtility {
    
    private static Map<String, Map<String,Schema.RecordTypeInfo>>   mapRecordTypeByName = new Map<String, Map<String,Schema.RecordTypeInfo>>();
    private static Map<String, Map<Id, Schema.RecordTypeInfo>>      mapRecordTypeById   = new Map<String, Map<Id, Schema.RecordTypeInfo>>();

    /*************************************************************************************** 
    Developer -    Abrar Haq (Tquila - now part of Accenture)
    Date -         06/07/2015
    Version -      1.0
    Function -     Get All the Record Types of a specific SObject Type
    #############Change Log#############
    Modified by     Version     Change Date
    ****************************************************************************************/
    public static void getSObjectAllAvailableRecordTypes(Schema.SObjectType sObjType){
        Schema.DescribeSObjectResult sObjSchemaResult = sObjType.getDescribe();
        List<Schema.RecordTypeInfo> lstRecordTypeInfos = sObjSchemaResult.getRecordTypeInfos();
        for(Schema.RecordTypeInfo rtInfo : lstRecordTypeInfos){
            System.Debug('>>Record Type Info<<'+ rtInfo);
            System.Debug('>> getName <<'+ rtInfo.getName());
            System.Debug('>> getRecordTypeId <<'+ rtInfo.getRecordTypeId());
            System.Debug('>> isAvailable <<'+ rtInfo.isAvailable());
            System.Debug('>> isDefaultRecordTypeMapping <<'+ rtInfo.isDefaultRecordTypeMapping());
        }
        System.Debug('>> sObjSchemaResult.getRecordTypeInfosByName <<'+ sObjSchemaResult.getRecordTypeInfosByName());
        System.Debug('>> sObjSchemaResult.getRecordTypeInfosById <<'+ sObjSchemaResult.getRecordTypeInfosById());
    }
    
    /*************************************************************************************** 
    Developer -    Abrar Haq (Tquila - now part of Accenture)
    Date -         06/07/2015
    Version -      1.0 
    Function -     Load/Populate Maps with Record Type Id or Record Type Name for specific object
    #############Change Log#############
    Modified by     Version     Change Date
    ****************************************************************************************/    
    private static void initialize(Schema.SObjectType sObjType, String sObjectAsString) {
        if (!mapRecordTypeByName.containsKey(sObjectAsString) || !mapRecordTypeById.containsKey(sObjectAsString)) {
            Schema.DescribeSObjectResult d = sObjType.getDescribe();
            mapRecordTypeByName.put(sObjectAsString, d.getRecordTypeInfosByName());
            mapRecordTypeById.put(sObjectAsString, d.getRecordTypeInfosById());
        }
    }

    /*************************************************************************************** 
    Developer -    Abrar Haq (Tquila - now part of Accenture)
    Date -         06/07/2015
    Version -      1.0 
    Function -     Get Record Type Id
    #############Change Log#############
    Modified by     Version     Change Date
    ****************************************************************************************/    
    public static ID getRecordTypeId(Schema.SObjectType sObjType, String sRecordTypeName, String sObjectAsString){
        initialize(sObjType, SObjectAsString);
        if (mapRecordTypeByName.get(sObjectAsString).containsKey(sRecordTypeName)) {
            Schema.RecordTypeInfo rtInfo = mapRecordTypeByName.get(sObjectAsString).get(sRecordTypeName);
            return rtInfo.getRecordTypeId();
        }
        return null;
    }
    
    /*************************************************************************************** 
    Developer -    Abrar Haq (Tquila - now part of Accenture)
    Date -         06/07/2015
    Version -      1.0 
    Function -     Get Record Type Name
    #############Change Log#############
    Modified by     Version     Change Date
    ****************************************************************************************/    
    public static String getRecordTypeName(Schema.SObjectType sObjType, Id recordTypeId, String sObjectAsString) {
        initialize(sObjType, sObjectAsString);
        if (mapRecordTypeById.get(sObjectAsString).containsKey(recordTypeId)) {
            Schema.RecordTypeInfo rtInfo =  mapRecordTypeById.get(sObjectAsString).get(recordTypeId);
            return rtInfo.getName();
        }
        
        return null;
    }

}