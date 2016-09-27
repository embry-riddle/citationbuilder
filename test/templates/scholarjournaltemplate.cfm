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
	param name="local.submitclass" default="submitclass";
	param name="local.doisection" default="doisection";
	param name="local.doiwebsiteinput" default="doiwebsiteinput";
	param name="local.doidbinput" default="doidbinput";
	//specific constants
	param name="local.contributorlname0" default="contributorlname0";
	param name="local.articletitle" default="articletitle";
	param name="local.articletitleinput" default="articletitleinput";
	param name="local.journaltitle" default="journaltitle";
	param name="local.journaltitleinput" default="journaltitleinput";
	param name="local.advancedinfo" default="advancedinfo";
	param name="local.yearpublished" default="yearpublished";
	param name="local.yearpublishedinput" default="yearpublishedinput";
	param name="local.pages" default="pages";
	param name="local.startinput" default="startinput";
	param name="local.endinput" default="endinput";
	param name="local.nonconsecutivepagenumsinput" default="nonconsecutivepagenumsinput";
	param name="local.nonconsecutiveinput" default="nonconsecutiveinput";
	param name="local.checkbox" default="checkbox";
	param name="local.urlsection" default="urlsection";
	param name="local.urlwebsiteinput" default="urlwebsiteinput";
	param name="local.webaccessdate" default="webaccessdate";
	param name="local.monthdropdown" default="monthdropdown";
	param name="local.databasetitle" default="databasetitle";
	param name="local.databaseinput" default="databaseinput";
	param name="local.urldbinput" default="urldbinput";
	param name="local.dbaccessdate" default="dbaccessdate";
</cfscript>

<cfoutput>
	<!--- Heading --->
	#local.partials.heading("Cite a scholarly journal article", local.source, local.style)#
	<div id="tabs">
		<ul>
			<li><a href="##print" class="print">in print</a></li>
			<li><a href="##website" class="website">on a website</a></li>
			<li><a href="##db" class="db">in a database</a></li>
		</ul>
		<div>
			<!--- header --->
			#local.partials.headercreate()#

			<!--- Contributor --->
			#local.partials.beginSection(local.contributor, "Contributor(s):", local.no)#
			#local.partials.contributor(local.contributor, local.contributorfname0, local.contributormi0, local.contributorlname0, local.textbox, local.none, local.noValue, local.anonymous)#
			#local.partials.endSection()#

			<!--- Article Title --->
			#local.partials.beginSection(local.articletitle, "Article title:", local.yes)#
			#local.partials.textbox(local.articletitleinput, local.textbox, 45, local.none, local.novalue)#
			#local.partials.endSection()#

			<!--- Journal Title --->
			#local.partials.beginSection(local.journaltitle, "Journal title:", local.yes)#
			#local.partials.textbox(local.journaltitleinput, local.textbox, 45, local.none, local.novalue)#
			#local.partials.endSection()#

			<!--- Advanced Info --->
			#local.partials.beginSection(local.advancedinfo, "Advanced info:", local.no)#
			#local.partials.advancedinfo(local.advancedinfo, local.textbox, local.none, local.noValue)#
			#local.partials.endSection()#

			<!--- Year Published --->
			#local.partials.beginSection(local.yearpublished, "Year published:", local.yes)#
			#local.partials.textbox(local.yearpublishedinput, local.textbox, 4, 4, local.novalue)#
			#local.partials.endSection()#

			<!--- Pages --->
			#local.partials.beginSection(local.pages, "Pages:", local.no)#
			#local.partials.pages(local.pages, local.startInput, local.endInput, local.nonconsecutivePageNumsInput, local.nonconsecutiveInput, local.checkbox, local.textbox, local.none, local.noValue)#
			#local.partials.endSection()#
		</div>
		<div id="revolvecontent">
			<div id="print">
			</div>
			<div id="website">
				<!--- URL --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.urlsection, "URL:", local.yes)#
					#local.partials.urlinput(local.urlwebsiteinput, local.style, local.source, local.no, local.textbox, local.none, local.noValue)#
					#local.partials.endSection()#
				<cfelseif local.style EQ "apa6">
					#local.partials.beginSection(local.urlsection, "URL:", local.yes)#
					#local.partials.urlinput(local.urlwebsiteinput, local.style, local.source, local.yes, local.textbox, local.none, local.noValue)#
					#local.partials.endSection()#
				</cfif>

				<!--- DOI --->
				<cfif local.style EQ "apa6">
					#local.partials.beginSection(local.doisection, "DOI:", local.yes)#
					#local.partials.textbox(local.doiwebsiteinput, local.textbox, 45, local.none, local.novalue)#
					#local.partials.endSection()#
				</cfif>

				<!--- Date accessed --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.webaccessdate, "Date accessed:", local.yes)#
					#local.partials.dateinput(local.webaccessdate, local.textbox, local.noValue, local.monthDropdown)#
					#local.partials.endSection()#
				</cfif>
			</div>
			<div id="db">
				<!--- Database --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.databasetitle, "Database title:", local.yes)#
					#local.partials.textbox(local.databaseinput, local.textbox, 45, local.none, local.novalue)#
					#local.partials.endSection()#
				</cfif>

				<!--- URL --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.urlsection, "URL:", local.yes)#
					#local.partials.urlinput(local.urldbinput, local.style, local.source, local.no, local.textbox, local.none, local.noValue)#
					#local.partials.endSection()#
				<cfelseif local.style EQ "apa6">
					#local.partials.beginSection(local.urlsection, "URL:", local.yes)#
					#local.partials.urlinput(local.urldbinput, local.style, local.source, local.yes, local.textbox, local.none, local.noValue)#
					#local.partials.endSection()#
				</cfif>

				<!--- DOI --->
				<cfif local.style EQ "apa6">
					#local.partials.beginSection(local.doisection, "DOI:", local.yes)#
					#local.partials.textbox(local.doidbinput, local.textbox, 45, local.none, local.novalue)#
					#local.partials.endSection()#
				</cfif>

				<!--- Date accessed --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.dbaccessdate, "Date accessed:", local.yes)#
					#local.partials.dateinput(local.dbaccessdate, local.textbox, local.noValue, local.monthDropdown)#
					#local.partials.endSection()#
				</cfif>
			</div>
		</div>
		<!--- Submit button --->
		#local.partials.beginSection(local.submitButton, "", local.yes)#
		#local.partials.submitButton(local.submitclass)#
		#local.partials.endSection()#

		<!--- footer --->
		#local.partials.footerCreate()#

		<!--- citation holder --->
		#local.partials.citationhold()#
	</div>
</cfoutput>