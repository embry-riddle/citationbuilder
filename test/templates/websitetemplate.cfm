	<cfscript>
	//Include the partials file
	import 'common.lib.citationbuilder.partials';

	local.partials = new partials();
	//Save the variables passed in through the URL

	local.style = structKeyExists(URL, "style") ? URL.style : "mla7";
	local.source = structKeyExists(URL, "source") ? URL.source : "";

	//define the constants for correct the warnings
	//general constants
	param name="local.contributor" default="contributor";
	param name="local.no" default="no";
	param name="local.contributorfname0" default="contributorfname0";
	param name="local.textbox" default="textbox";
	param name="local.none" default="none";
	param name="local.novalue" default="novalue";
	param name="local.contributormi0" default="contributormi0";
	param name="local.Anonymous" default="Anonymous";
	param name="local.yes" default="yes";
	param name="local.submitButton" default="submitButton";
	param name="local.submitClass" default="submitClass";
	//especifics constants
	param name="local.articletitle" default="articletitle";
	param name="local.contributorlname0" default="contributorlname0";
	param name="local.articletitleinput" default="articletitleinput";
	param name="local.websitetitle" default="websitetitle";
	param name="local.websitetitleinput" default="websitetitleinput";
	param name="local.publishersponsor" default="publishersponsor";
	param name="local.publishersponsorinput" default="publishersponsorinput";
	param name="local.urlsection" default="urlsection";
	param name="local.urlwebsiteinput" default="urlwebsiteinput";
	param name="local.electronicpublish" default="electronicpublish";
	param name="local.monthdropdown" default="monthdropdown";
	param name="local.webaccessdate" default="webaccessdate";
</cfscript>

<cfoutput>
	<!--- Heading --->
	#local.partials.heading("Cite a web site", local.source, local.style)#
	<div id="tabs">
		<ul>
			<li><a href="##website" class="website">on the internet</a></li>
		</ul>
		<div>
			<!--- header --->
			#local.partials.headercreate()#

			<!--- Contributor --->
			#local.partials.beginSection(local.contributor, "Contributor(s):", local.no)#
			#local.partials.contributor(local.contributor, local.contributorfname0, local.contributormi0, local.contributorlname0, local.textbox, local.none, local.noValue, local.anonymous)#
			#local.partials.endSection()#
		</div>
		<div id="revolvecontent">
			<div id="website">
				<!--- Article Title --->
				#local.partials.beginSection(local.articletitle, "Article title:", local.yes)#
				#local.partials.textbox(local.articletitleinput, local.textbox, 45, local.none, local.novalue)#
				#local.partials.endSection()#

				<!--- Website Title --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.websitetitle, "Web site title:", local.yes)#
					#local.partials.textbox(local.websitetitleinput, local.textbox, 45, local.none, local.novalue)#
					#local.partials.endSection()#
				<cfelseif local.style EQ "apa6">
					#local.partials.beginSection(local.websitetitle, "Website title:", local.yes)#
					#local.partials.textbox(local.websitetitleinput, local.textbox, 45, local.none, local.novalue)#
					#local.partials.endSection()#
				</cfif>

				<!--- Publisher / sponsor --->
				#local.partials.beginSection(local.publishersponsor, "Site publisher / sponsor:", local.yes)#
				#local.partials.textbox(local.publishersponsorinput, local.textbox, 45, local.none, local.novalue)#
				#local.partials.endSection()#

				<!--- URL --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.urlsection, "URL:", local.yes)#
					#local.partials.urlinput(local.urlwebsiteinput, local.style, local.source, local.no, local.textbox, local.none, local.noValue)#
					#local.partials.endSection()#
				<cfelseif local.style EQ "apa6">
					#local.partials.beginSection(local.urlsection, "URL:", local.yes)#
					#local.partials.urlinput(local.urlwebsiteinput, local.style, local.source, local.no, local.textbox, local.none, local.noValue)#
					#local.partials.endSection()#
				</cfif>

				<!--- Electronically published --->
				#local.partials.beginSection(local.electronicpublish, "Electronically published:", local.yes)#
				#local.partials.dateinput(local.electronicpublish, local.textbox, local.noValue, local.monthDropdown)#
				#local.partials.endSection()#

				<!--- Date accessed --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.webaccessdate, "Date accessed:", local.yes)#
					#local.partials.dateinput(local.webaccessdate, local.textbox, local.noValue, local.monthDropdown)#
					#local.partials.endSection()#
				</cfif>
			</div>
		</div>
		<!--- Submit button --->
		#local.partials.beginSection(local.submitButton, "", local.yes)#
		#local.partials.submitButton(local.submitClass)#
		#local.partials.endSection()#

		<!--- footer --->
		#local.partials.footercreate()#

		<!--- citation holder --->
		#local.partials.citationhold()#
	</div>
</cfoutput>