﻿/**
File name: Application.cfc
Component name: Application level component
Description: This file handles the Lifecycle events of the entire flow of the application
* ---
*/
component displayname = "Application level component" hint = "Does all the application level settings" {
	// Application properties
	this.name = hash( getCurrentTemplatePath() );
	this.sessionManagement = true;
	this.applicationTimeout = createTimeSpan(0,1,0,0);
	this.sessionTimeout = createTimeSpan(0,0,30,0);
	this.setClientCookies = true;
	this.datasource = "cfartgallery";
	this.mappings[ '/coldbox' ] = 'D:\MyCodings\Coding1\ColdBoxApp\coldbox\';



	// COLDBOX STATIC PROPERTY, DO NOT CHANGE UNLESS THIS IS NOT THE ROOT OF YOUR COLDBOX APP
	COLDBOX_APP_ROOT_PATH = getDirectoryFromPath( getCurrentTemplatePath() );
	// The web server mapping to this application. Used for remote purposes or static purposes
	COLDBOX_APP_MAPPING   = "";
	// COLDBOX PROPERTIES
	COLDBOX_CONFIG_FILE 	 = "";
	// COLDBOX APPLICATION KEY OVERRIDE
	COLDBOX_APP_KEY 		 = "";

	// application start
	public boolean function onApplicationStart(){
		application.cbBootstrap = new coldbox.system.Bootstrap( COLDBOX_CONFIG_FILE, COLDBOX_APP_ROOT_PATH, COLDBOX_APP_KEY, COLDBOX_APP_MAPPING );
		application.cbBootstrap.loadColdbox();
		return true;
	}

	// application end
	public void function onApplicationEnd( struct appScope ){
		arguments.appScope.cbBootstrap.onApplicationEnd( arguments.appScope );
	}

	// request start
	public boolean function onRequestStart( string targetPage ){
		// Process ColdBox Request
		application.cbBootstrap.onRequestStart( arguments.targetPage );
		//writeDump(CGI); abort;
		if(CGI.HTTP_URL EQ "/coldboxapp/index.cfm/Common/home" OR CGI.HTTP_URL EQ "/coldboxapp/index.cfm/Common/about") {
			if(structKeyExists(session, "user")) {
				location("/coldboxapp/index.cfm/Common/home");
			}
			else {
				location("/coldboxapp/index.cfm");
			}
		}
		return true;
	}

	public void function onSessionStart(){
		application.cbBootStrap.onSessionStart();
	}

	public void function onSessionEnd(struct sessionScope, struct appScope){
		arguments.appScope.cbBootStrap.onSessionEnd( argumentCollection=arguments );
	}

	public boolean function onMissingTemplate(template){
		return application.cbBootstrap.onMissingTemplate(argumentCollection=arguments);
	}

	function onError(any Exception, string EventName) {
		//writelog("#this.name#","Application","","error",true);
		writelog("Message: #Arguments.Exception.message#","Application","#This.Name#","error",true);
		WRITEDUMP(ARGUMENTS); abort;
	}

}