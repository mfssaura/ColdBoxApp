/**
* I am a new handler
*/
component name="Common" hint="" extends="coldbox.system.EventHandler"{
	//property name = "Login" inject;
	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only 	= "";
	this.prehandler_except 	= "";
	this.posthandler_only 	= "";
	this.posthandler_except = "";
	this.aroundHandler_only = "";
	this.aroundHandler_except = "";
	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};

	/**
	IMPLICIT FUNCTIONS: Uncomment to use
	function preHandler( event, rc, prc, action, eventArguments ){
	}
	function postHandler( event, rc, prc, action, eventArguments ){
	}
	function aroundHandler( event, rc, prc, targetAction, eventArguments ){
		// executed targeted action
		arguments.targetAction( event );
	}
	function onMissingAction( event, rc, prc, missingAction, eventArguments ){
	}
	function onError( event, rc, prc, faultAction, exception, eventArguments ){
	}
	function onInvalidHTTPMethod( event, rc, prc, faultAction, eventArguments ){
	}
	*/

	/**
	* Login
	*/
	public void function Login( event, rc, prc ) {
		event.setView( "Common/Login" ).noLayout();
	}

	/**
	* loginaction
	*/
	public void function LoginAction( event, rc, prc ){
		// writedump(form);
		// writedump(Login);
		// abort;
		if(isDefined("form.submit")) {
			//local.myModel = injector.getInstance("model.Common.LoginPageAction");
			//abort;
			local.myModel = getModel("Common.LoginPageAction");
			local.validationStatus = myModel.ValidateLoginForm(form.emailId, form.password);
			//writedump(validationStatus);
			//abort;
			if(local.validationStatus EQ true) {
				local.userFormData = myModel.CheckFormData(form.emailId, form.password);
				if(local.userFormData EQ true) {
					//abort;
					//location("../../index.cfm/Common/Home");
					event.setView("Common/Home").noLayout();
				} else {
					//writeOutput("Opps! Email or Password is incorrect, Please provide the correct details");
					event.setView("Common/Register").noLayout();
					//location("../../index.cfm/Common/Register","false","301");
				}
			}
		} else {
			event.setView("Common/Register").noLayout();
			//location("../../index.cfm/Common/Register","false","301");
		}
	}

	/**
	* Register
	*/
	public void function Register( event, rc, prc ){
		event.setView( "Common/Register" ).noLayout();
	}

	public void function RegisterAction(event, rc, prc) {
		//writeDump(form); abort;
		if(isDefined("form.saveChanges")) {
			//local.formData = injector.getInstance("Common.RegistrationPageAction");
			//abort;
			local.formData = getModel("Common.RegistrationPageAction");
			local.isValid = formData.validateRegistrationForm();
			if(local.isValid EQ "true") {
				local.formDataInserted = formData.insertDataRegistrationForm(argumentCollection="form");
				if(local.formDataInserted EQ true) {
					location("../Common/Login");
				} else {
					location("../Common/Register");
				}
			} else {
				location("../Common/Register");
			}
		} else {
			location("../Common/Register","false","301");
		}
	}

	/**
	* ForgotPassword
	*/
	public void function ForgotPassword( event, rc, prc ){
		event.setView( "Common/ForgotPassword" ).noLayout();
	}

	/**
	* Home
	*/
	public void function Home( event, rc, prc ){
		event.setView( "Common/Home" ).noLayout();
	}

	/**
	* About
	*/
	public void function About( event, rc, prc ){
		event.setView( "Common/About" ).noLayout();
	}

	/**
	* Logout
	*/
	public void function Logout( event, rc, prc ){
		event.setView( "Common/LogOut" ).noLayout();
	}
}

