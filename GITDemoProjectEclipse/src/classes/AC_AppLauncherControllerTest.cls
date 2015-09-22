/**
* Name : AC_AppLauncherControllerTest
* Author : Accenture IDC
* Description : This is the class to test the class holds the Logic for the getting the Url passed based on Parameters.                
* Date : 02/5/14 
*/
@isTest
private class AC_AppLauncherControllerTest{ 
private Static String label = 'FedEx';
private Static String type = 'External';
private Static String url = 'www.Fedex.com';
private Static Boolean catalog = false; 
private Static Boolean myApp = true;
private Static String paramName = 'Test';
private Static String psTh = 'Test';
private Static String kase = 'True';
private Static String profileName = 'System Administrator';
private Static string userName = 'applicationcatalog@testtargetsalesforce.com';
private Static String paramType1 = 'PassThrough';
private Static String paramType2 = 'Static';
private Static String exceptionType = 'QueryException'; 
private Static Final String APPLICATIONNAME = 'APPLICATION CATALOG';
private Static Final String CLASSNAME = 'AC_AppLauncherControllerTest'; 
private Static Final string METHODNAME = 'createParameterizedUrl_Tests4';

    /**
           @Method Name  : createParameterizedUrl_Tests1
           @description  : This Method test the scenario without parameter block
           @param        : NA
           @return       : void
       */          
    private static testmethod void createParameterizedUrl_Tests1(){ 
        AC_CatalogUtilityTest.userRelatedCustomSettings();  
        User usr = AC_CatalogUtilityTest.createUser_data(profileName,userName)  ; 
         usr.Security_Group__c = 'DEVELOPER' ;
        Application__c app = AC_CatalogUtilityTest.createApplication_data(label, type, url, catalog, myApp);
        DataBase.insert(App);
        app = [select id, Name, App_Label__c, App_Type__c,URL__c from Application__c where id =:app.id Limit 1];
       system.runAs(usr){
            Test.startTest();
            PageReference pref = new PageReference('/apex/AC_AppLauncher');
            pref.getParameters().put('AppId' ,app.Name);
            Test.setCurrentPage(pref);
            AC_AppLauncherController controllerTest  =  new  AC_AppLauncherController();
            controllerTest.createParameterizedUrl();
          
            Test.stopTest();
            System.assertNotEquals(null,app.Name);
            System.assertNotEquals(null,controllerTest.link);
            
        }   
    }

    /**
           @Method Name  : createParameterizedUrl_Tests2
           @description  : This Method test the scenario for both PassThrough and static parameter block
           @param        : NA
           @return       : void
       */ 
    private static testmethod void createParameterizedUrl_Tests2(){ 
        AC_CatalogUtilityTest.userRelatedCustomSettings();  
        User usr = AC_CatalogUtilityTest.createUser_data(profileName,userName)  ; 
         usr.Security_Group__c = 'DEVELOPER' ;
        Application__c app = AC_CatalogUtilityTest.createApplication_data(label, type, url, catalog, myApp);
        DataBase.insert(App);
        app = [select id, Name, App_Label__c, App_Type__c,URL__c from Application__c where id =:app.id Limit 1];
        List<AppParameter__c> listAppParams = new List<AppParameter__c>();
        AppParameter__c aPrm1 = AC_CatalogUtilityTest.createAppParameter_data(app.id, paramType1, paramName);
        listAppParams.add(aPrm1);
        
        AppParameter__c aPrm2 = AC_CatalogUtilityTest.createAppParameter_data(app.id, paramType2, paramName);
        listAppParams.add(aPrm2);
        
        DataBase.insert(listAppParams);
        
        Test.startTest();
        PageReference pref = new PageReference('/apex/AC_AppLauncher');
        pref.getParameters().put('AppId' ,app.Name);
        pref.getParameters().put('Test',PsTh);
        pref.getParameters().put('Case',Kase);
        Test.setCurrentPage(pref);
        AC_AppLauncherController controllerTest  =  new  AC_AppLauncherController();
        controllerTest.createParameterizedUrl();
        system.runAs(usr){
            Test.stopTest();
            System.assertNotEquals(null,app.Name);
           System.assertNotEquals(null,controllerTest.link);
            
        }   
    }


      /**
           @Method Name  : createParameterizedUrl_Tests3
           @description  : This Method test the scenario for both static block
           @param        : NA
           @return       : NA
       */        
    private static testmethod void createParameterizedUrl_Tests3(){ 
        AC_CatalogUtilityTest.userRelatedCustomSettings();  
        User usr = AC_CatalogUtilityTest.createUser_data(profileName,userName)  ;
        usr.Security_Group__c = 'DEVELOPER' ; 
        Application__c app = AC_CatalogUtilityTest.createApplication_data(label, type, url, catalog, myApp);
        DataBase.insert(App);
        app = [select id, Name, App_Label__c, App_Type__c,URL__c from Application__c where id =:app.id Limit 1];
        AppParameter__c aPrm2 = AC_CatalogUtilityTest.createAppParameter_data(app.id, paramType2, paramName);
        DataBase.insert(aPrm2);
        Test.startTest();
        PageReference pref = new PageReference('/apex/AC_AppLauncher');
        pref.getParameters().put('AppId' ,app.Name);
        pref.getParameters().put('Test',PsTh);
        pref.getParameters().put('Case',Kase);
        Test.setCurrentPage(pref);
        AC_AppLauncherController controllerTest  =  new  AC_AppLauncherController();
         controllerTest.createParameterizedUrl();
        system.runAs(usr){
            Test.stopTest();
            System.assertNotEquals(null,app.Name);
            System.assertNotEquals(null,controllerTest.link);
            
        }   
}

   /**
       @Method Name  : createParameterizedUrl_Tests4
       @description  : This Method test the scenario for both Query Exception block
       @param        : NA
       @return       : NA
   */    
    private static testmethod void createParameterizedUrl_Tests4(){ 
        AC_CatalogUtilityTest.userRelatedCustomSettings();  
        User usr = AC_CatalogUtilityTest.createUser_data(profileName,userName)  ;
         usr.Security_Group__c = 'DEVELOPER' ; 
          Application__c app = AC_CatalogUtilityTest.createApplication_data(label, type, url, catalog, myApp);
        DataBase.insert(App);
        app = [select id, Name, App_Label__c, App_Type__c,URL__c from Application__c where id =:app.id Limit 1];
        Test.startTest();
        PageReference pref = new PageReference('/apex/AC_AppLauncher');
         pref.getParameters().put('AppId' ,'APP-01');
        Test.setCurrentPage(pref);
        AC_AppLauncherController controllerTest  =  new  AC_AppLauncherController();
        try{
                controllerTest.createParameterizedUrl();
        }
        catch(Exception gExcp){
            System.assertEquals(exceptionType,gExcp.getTypeName());
            //Calling the method in Exception Logging Framework to create an Exception log record for handled general Exception
                UTIL_LoggingService.logHandledException(gExcp, userinfo.getOrganizationId(), APPLICATIONNAME,
                                                        CLASSNAME, METHODNAME, null, LoggingLevel.ERROR);
        }
        system.runAs(usr){
        Test.stopTest();
        
        }   
    }
    
      /**
           @Method Name  : createParameterizedUrl_Tests5
           @description  : This Method test the scenario for Shipping App calling App Launcher
           @param        : NA
           @return       : NA
       */        
    private static testmethod void createParameterizedUrl_Tests5(){ 
        AC_CatalogUtilityTest.userRelatedCustomSettings();  
        User usr = AC_CatalogUtilityTest.createUser_data(profileName,userName)  ;
        usr.Security_Group__c = 'DEVELOPER' ; 
        Application__c app = AC_CatalogUtilityTest.createApplication_data(label, type, url, catalog, myApp);
        DataBase.insert(App);
        app = [select id, Name, App_Label__c, App_Type__c,URL__c from Application__c where id =:app.id Limit 1];
        AppParameter__c aPrm2 = AC_CatalogUtilityTest.createAppParameter_data(app.id, paramType2, paramName);
        DataBase.insert(aPrm2);
        system.runAs(usr){
        Test.startTest();
        
        PageReference pref = new PageReference('/apex/AC_AppLauncher');
        pref.getParameters().put('AppId' ,app.Name);
        pref.getParameters().put('url' ,'Test_URL');        
        Test.setCurrentPage(pref);
        AC_AppLauncherController controllerTest  =  new  AC_AppLauncherController();
        controllerTest.createParameterizedUrl();
       
        Test.stopTest();
        
       System.assertNotEquals(null,app.Name);
       System.assertNotEquals(null,controllerTest.link);         
       System.assertEquals('https://Test_URL',controllerTest.link);
       System.assertEquals('External',controllerTest.app.app_type__c);
     }    
          
  }
  
    /**
           @Method Name  : createParameterizedUrl_Tests6
           @description  : This Method test the scenario for Shipping App calling App Launcher
           @param        : NA
           @return       : NA
       */        
    private static testmethod void createParameterizedUrl_Tests6(){ 
        AC_CatalogUtilityTest.userRelatedCustomSettings();  
        User usr = AC_CatalogUtilityTest.createUser_data(profileName,userName)  ;
        usr.Security_Group__c = 'DEVELOPER' ; 
        Application__c app = AC_CatalogUtilityTest.createApplication_data(label, type, url, catalog, myApp);
        DataBase.insert(App);
        app = [select id, Name, App_Label__c, App_Type__c,URL__c from Application__c where id =:app.id Limit 1];
        AppParameter__c aPrm2 = AC_CatalogUtilityTest.createAppParameter_data(app.id, paramType2, paramName);
        DataBase.insert(aPrm2);
        system.runAs(usr){
        Test.startTest();
        
        PageReference pref = new PageReference('/apex/AC_AppLauncher');
        pref.getParameters().put('AppId' ,app.Name);
        pref.getParameters().put('url' ,'Test_URL');        
        pref.getParameters().put('tracknums','12345'); 
        
        Test.setCurrentPage(pref);
        AC_AppLauncherController controllerTest  =  new  AC_AppLauncherController();
        controllerTest.createParameterizedUrl();
       
       Test.stopTest();
        
       System.assertNotEquals(null,app.Name);
       System.assertNotEquals(null,controllerTest.link);         
       System.assertEquals('https://Test_URL&trackNums=12345',controllerTest.link);
       System.assertEquals('External',controllerTest.app.app_type__c);
     }    
          
  }
    
    /**
           @Method Name  : createParameterizedUrl_Tests7
           @description  : This Method test the scenario when the Appid is not passed in the URL
           @param        : NA
           @return       : NA
       */        
    private static testmethod void createParameterizedUrl_Tests7(){ 
        AC_CatalogUtilityTest.userRelatedCustomSettings();  
        User usr = AC_CatalogUtilityTest.createUser_data(profileName,userName)  ;
        usr.Security_Group__c = 'DEVELOPER' ; 
        Application__c app = AC_CatalogUtilityTest.createApplication_data(label, type, url, catalog, myApp);
        DataBase.insert(App);
        app = [select id, Name, App_Label__c, App_Type__c,URL__c from Application__c where id =:app.id Limit 1];
        AppParameter__c aPrm2 = AC_CatalogUtilityTest.createAppParameter_data(app.id, paramType2, paramName);
        DataBase.insert(aPrm2);
        system.runAs(usr){
        Test.startTest();
        
        PageReference pref = new PageReference('/apex/AC_AppLauncher');             
        Test.setCurrentPage(pref);
        AC_AppLauncherController controllerTest  =  new  AC_AppLauncherController();
        controllerTest.createParameterizedUrl();
       
        Test.stopTest();
        ApexPages.Message[] pageMessages = ApexPages.getMessages();
         //asserting against the error message
         System.assertNotEquals(0, pageMessages.size());
         System.assertEquals(pageMessages[0].getSummary(), System.Label.GenericErrorMessage);
     }    
          
  }
}