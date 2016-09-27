/**
* This Application.cfc is meant to restrict access to a directory, but allow it on local
*	development environments so RDS can be used to browse a cfc's documentation
* @author	"Jeff Kiah"
* @contact	"kiahj@erau.edu"
*/
import "common.platform.Platform";

component output="false"
{
	this.name = hash(getCurrentTemplatePath() & CGI.SERVER_NAME);
	this.applicationTimeout = createTimeSpan(1, 0, 0, 0);
	
	/**
	* Runs when a request starts
	* @targetPage "Path from the web root to the requested page."
	*/
	public boolean function onRequestStart(required string targetPage) {
		var platform = new Platform();
		
		// restrict access on all servers but local dev servers (to allow debugging locally)
		if (platform.isLocalDev())
		{
			return true;
		}
		writeOutput("Access Restricted.");
		return false;
	}
}