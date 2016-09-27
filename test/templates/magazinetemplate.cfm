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
	param name="local.noValue" default="noValue";
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
	param name="local.magazinetitle" default="magazinetitle";
	param name="local.magazinetitleinput" default="magazinetitleinput";
	param name="local.datepublisheddate" default="datepublisheddate";
	param name="local.datepublished" default="datepublished";
	param name="local.monthdropdown" default="monthdropdown";
	param name="local.websitetitle" default="websitetitle";
	param name="local.websitetitleinput" default="websitetitleinput";
	param name="local.webaccessdate" default="webaccessdate";
	param name="local.magazinetitle" default="magazinetitle";
	param name="local.urlsection" default="urlsection";
	param name="local.urlwebsiteinput" default="urlwebsiteinput";
	param name="local.pages" default="pages";
	param name="local.startinput" default="startinput";
	param name="local.endinput" default="endinput";
	param name="local.nonconsecutivepagenumsinput" default="nonconsecutivepagenumsinput";
	param name="local.nonconsecutiveinput" default="nonconsecutiveinput";
	param name="local.checkbox" default="checkbox";
	param name="local.advancedInfo" default="advancedInfo";
	param name="local.printadvancedInfo" default="printadvancedInfo";
	param name="local.dbpages" default="dbpages";
	param name="local.databasetitle" default="databasetitle";
	param name="local.databaseinput" default="databaseinput";
	param name="local.dbaccessdate" default="dbaccessdate";
	param name="local.urldbinput" default="urldbinput";
	param name="local.dbadvancedInfo" default="dbadvancedInfo";
	param name="local.webpages" default="webpages";
	param name="local.websiteadvancedInfo" default="websiteadvancedInfo";
</cfscript>

<cfoutput>
	<!--- Heading --->
	#local.partials.heading("Cite a magazine article", local.source, local.style)#
	<div id="tabs">
		<ul>
			<li><a href="##print" class="print">in print</a></li>
			<li><a href="##website" class="website">on a website</a></li>
			<li><a href="##db" class="db">in a database</a></li>
		</ul>
		<div>
			<!--- header --->
			#local.partials.headerCreate()#

			<!--- Contributor --->
			#local.partials.beginSection(local.contributor, "Contributor(s):", local.no)#
			#local.partials.contributor(local.contributor, local.contributorfname0, local.contributormi0, local.contributorlname0, local.textbox, local.none, local.noValue, local.anonymous)#
			#local.partials.endSection()#

			<!--- Article Title --->
			#local.partials.beginSection(local.articletitle, "Article title:", local.yes)#
			#local.partials.textbox(local.articletitleinput, local.textbox, 45, local.none, local.noValue)#
			#local.partials.endSection()#

			<!--- Magazine Title --->
			#local.partials.beginSection(local.magazinetitle, "Magazine title:", local.yes)#
			#local.partials.textbox(local.magazinetitleinput, local.textbox, 45, local.none, local.noValue)#
			#local.partials.endSection()#

			<!--- Date published --->
			#local.partials.beginSection(local.datepublisheddate, "Date published:", local.yes)#
			#local.partials.dateInput(local.datepublished, local.textbox, local.noValue, local.monthDropdown)#
			#local.partials.endSection()#
		</div>
		<div id="revolvecontent">
			<div id="print">
				<!--- Pages --->
				#local.partials.beginSection(local.pages, "Pages:", local.no)#
				#local.partials.pages(local.pages, local.startInput, local.endInput, local.nonconsecutivePageNumsInput, local.nonconsecutiveInput, local.checkbox, local.textbox, local.none, local.noValue)#
				#local.partials.endSection()#

				<!--- Advanced Info --->
				<cfif local.style EQ "apa6">
					#local.partials.beginSection(local.advancedInfo, "Advanced info:", local.no)#
					#local.partials.advancedInfo(local.printadvancedInfo, local.textbox, local.none, local.noValue)#
					#local.partials.endSection()#
				</cfif>
			</div>
			<div id="website">
				<!--- Pages --->
				<cfif local.style EQ "apa6">
					#local.partials.beginSection(local.pages, "Pages:", local.no)#
					#local.partials.pages(local.webpages, local.startInput, local.endInput, local.nonconsecutivePageNumsInput, local.nonconsecutiveInput, local.checkbox, local.textbox, local.none, local.noValue)#
					#local.partials.endSection()#
				</cfif>

				<!--- Web site Title --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.websitetitle, "Site publisher / sponsor:", local.yes)#
					#local.partials.textbox(local.websitetitleinput, local.textbox, 45, local.none, local.noValue)#
					#local.partials.endSection()#
				</cfif>

				<!--- Advanced Info --->
				<cfif local.style EQ "apa6">
					#local.partials.beginSection(local.advancedInfo, "Advanced info:", local.no)#
					#local.partials.advancedInfo(local.websiteadvancedInfo)#
					#local.partials.endSection()#
				</cfif>

				<!--- Date accessed --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.webaccessdate, "Date accessed:", local.yes)#
					#local.partials.dateInput(local.webaccessdate, local.textbox, local.noValue, local.monthDropdown)#
					#local.partials.endSection()#
				</cfif>

				<!--- URL --->
				<cfif local.style EQ "apa6">
					#local.partials.beginSection(local.urlsection, "Home page URL:", local.yes)#
					#local.partials.urlInput(local.urlwebsiteinput, local.style, local.source, local.no, local.textbox, local.none, local.noValue)#
					#local.partials.endSection()#
				<cfelse>
					#local.partials.beginSection(local.urlsection, "URL:", local.yes)#
					#local.partials.urlInput(local.urlwebsiteinput, local.style, local.source, local.no, local.textbox, local.none, local.noValue)#
					#local.partials.endSection()#
				</cfif>
			</div>
			<div id="db">
				<!--- Pages --->
				#local.partials.beginSection(local.pages, "Pages:", local.no)#
				#local.partials.pages(local.dbpages, local.startInput, local.endInput, local.nonconsecutivePageNumsInput, local.nonconsecutiveInput, local.checkbox, local.textbox, local.none, local.noValue)#
				#local.partials.endSection()#

				<!--- Database title --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.databasetitle, "Database title:", local.yes)#
					#local.partials.textbox(local.databaseinput, local.textbox, 45, local.none, local.noValue)#
					#local.partials.endSection()#
				</cfif>

				<!--- Advanced Info --->
				<cfif local.style EQ "apa6">
					#local.partials.beginSection(local.advancedInfo, "Advanced info:", local.no)#
					#local.partials.advancedInfo(local.dbadvancedInfo)#
					#local.partials.endSection()#
				</cfif>

				<!--- Date accessed --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.dbaccessdate, "Date accessed:", local.yes)#
					#local.partials.dateInput(local.dbaccessdate, local.textbox, local.noValue, local.monthDropdown)#
					#local.partials.endSection()#
				</cfif>

				<!--- URL --->
				#local.partials.beginSection(local.urlsection, "Database URL:", local.yes)#
				#local.partials.urlInput(local.urldbinput, local.style, local.source, local.no, local.textbox, local.none, local.noValue)#
				#local.partials.endSection()#
			</div>
		</div>
		<!--- Submit button --->
		#local.partials.beginSection(local.submitButton, "", local.yes)#
		#local.partials.submitButton(local.submitclass)#
		#local.partials.endSection()#

		<!--- footer --->
		#local.partials.footerCreate()#

		<!--- citation holder --->
		#local.partials.citationHold()#
	</div>
</cfoutput>