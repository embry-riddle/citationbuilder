<cfscript>
	//Include the partials file
	import 'common.lib.citationbuilder.partials';

	local.partials = new partials();
	//Save the variables passed in through the URL

	local.style = structKeyExists(URL, "style") ? URL.style : "mla7";
	local.source = structKeyExists(URL, "source") ? URL.source : "";

	//define the constants for correct the warnings
	//general and specifics constants
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
	param name="local.newspapertitle" default="newspapertitle";
	param name="local.newspapertitleinput" default="newspapertitleinput";
	param name="local.articletitle" default="articletitle";
	param name="local.articletitleinput" default="articletitleinput";
	param name="local.websitetitle" default="websitetitle";
	param name="local.websitetitleinput" default="websitetitleinput";
	param name="local.urlsection" default="urlsection";
	param name="local.urlwebsiteinput" default="urlwebsiteinput";
	param name="local.electronicpublish" default="electronicpublish";
	param name="local.monthdropdown" default="monthdropdown";
	param name="local.webaccessdate" default="webaccessdate";
	param name="local.dbnewspapercity" default="dbnewspapercity";
	param name="local.dbnewspaperCityInput" default="dbnewspaperCityInput";
	param name="local.dbdatepublisheddate" default="dbdatepublisheddate";
	param name="local.dbedition" default="dbedition";
	param name="local.dbeditioninput" default="dbeditioninput";
	param name="local.dbpages" default="dbpages";
	param name="local.startinput" default="startinput";
	param name="local.endinput" default="endinput";
	param name="local.nonconsecutivepagenumsinput" default="nonconsecutivepagenumsinput";
	param name="local.nonconsecutiveinput" default="nonconsecutiveinput";
	param name="local.checkbox" default="checkbox";
	param name="local.databasetitle" default="databasetitle";
	param name="local.databaseinput" default="databaseinput";
	param name="local.dbaccessdate" default="dbaccessdate";
	param name="local.urldbinput" default="urldbinput";
	param name="local.contributorlname0" default="contributorlname0";
	param name="local.newspapercity" default="newspapercity";
	param name="local.newspaperCityInput" default="newspaperCityInput";
	param name="local.datepublisheddate" default="datepublisheddate";
	param name="local.datepublished" default="datepublished";
	param name="local.edition" default="edition";
	param name="local.editioninput" default="editioninput";
	param name="local.section" default="section";
	param name="local.sectioninput" default="sectioninput";
	param name="local.pages" default="pages";

</cfscript>

<cfoutput>
	<!--- Heading --->
	#local.partials.heading("Cite a newspaper article", local.source, local.style)#
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

			<!--- Newspaper Title --->
			#local.partials.beginSection(local.newspapertitle, "Newspaper title:", local.yes)#
			#local.partials.textbox(local.newspapertitleinput, local.textbox, 45, local.none, local.noValue)#
			#local.partials.endSection()#

			<!--- Article Title --->
			#local.partials.beginSection(local.articletitle, "Article title:", local.yes)#
			#local.partials.textbox(local.articletitleinput, local.textbox, 45, local.none, local.noValue)#
			#local.partials.endSection()#
		</div>
		<div id="revolvecontent">
			<div id="print">
				<cfif local.style EQ "mla7">
					<!--- Newspaper city --->
					#local.partials.beginSection(local.newspapercity, "Newspaper city:", local.no)#
					#local.partials.newspaperCityInput(local.newspaperCityInput, local.textbox, local.none, local.noValue)#
					#local.partials.endSection()#
				</cfif>

				<!--- Date published --->
				#local.partials.beginSection(local.datepublisheddate, "Date published:", local.yes)#
				#local.partials.dateInput(local.datePublished, local.textbox, local.noValue, local.monthDropdown)#
				#local.partials.endSection()#

				<cfif local.style EQ "mla7">
					<!--- Edition --->
					#local.partials.beginSection(local.edition, "Edition:", local.yes)#
					#local.partials.textbox(local.editioninput, local.textbox, 18, local.none, local.noValue)#
					#local.partials.endSection()#

					<!--- Section --->
					#local.partials.beginSection(local.section, "Section:", local.yes)#
					#local.partials.textbox(local.sectioninput, local.textbox, 18, local.none, local.noValue)#
					#local.partials.endSection()#
				</cfif>

				<!--- Pages --->
				#local.partials.beginSection(local.pages, "Pages:", local.no)#
				#local.partials.pages(local.pages, local.startInput, local.endInput, local.nonconsecutivePageNumsInput, local.nonconsecutiveInput, local.checkbox, local.textbox, local.none, local.noValue)#
				#local.partials.endSection()#
			</div>
			<div id="website">
				<!--- Web site Title --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.websitetitle, "Web site title:", local.yes)#
					#local.partials.textbox(local.websitetitleinput, local.textbox, 45, local.none, local.noValue)#
					#local.partials.endSection()#
				</cfif>

				<!--- URL --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.urlsection, "URL:", local.yes)#
					#local.partials.urlInput(local.urlwebsiteinput, local.style, local.source, local.no, local.textbox, local.none, local.noValue)#
					#local.partials.endSection()#
				<cfelseif local.style EQ "apa6">
					#local.partials.beginSection(local.urlsection, "Home page URL:", local.yes)#
					#local.partials.urlInput(local.urlwebsiteinput, local.style, local.source, local.no, local.textbox, local.none, local.noValue)#
					#local.partials.endSection()#
				</cfif>

				<!--- Electronically published --->
				#local.partials.beginSection(local.electronicpublish, "Electronically published:", local.yes)#
				#local.partials.dateInput(local.electronicpublish, local.textbox, local.noValue, local.monthDropdown)#
				#local.partials.endSection()#

				<!--- Date accessed --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.webaccessdate, "Date accessed:", local.yes)#
					#local.partials.dateInput(local.webaccessdate, local.textbox, local.noValue, local.monthDropdown)#
					#local.partials.endSection()#
				</cfif>
			</div>
			<div id="db">
				<cfif local.style EQ "mla7">
					<!--- Newspaper city --->
					#local.partials.beginSection(local.dbnewspapercity, "Newspaper city:", local.no)#
					#local.partials.newspaperCityInput(local.dbnewspaperCityInput, local.textbox, local.none, local.noValue)#
					#local.partials.endSection()#
				</cfif>

				<!--- Date published --->
				#local.partials.beginSection(local.dbdatepublisheddate, "Date published:", local.yes)#
				#local.partials.dateInput(local.dbdatepublisheddate, local.textbox, 12, local.none, local.noValue)#
				#local.partials.endSection()#

				<!--- Edition --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.dbedition, "Edition:", local.yes)#
					#local.partials.textbox(local.dbeditioninput, local.textbox, 18, local.none, local.noValue)#
					#local.partials.endSection()#
				</cfif>

				<!--- Pages --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.dbpages, "Pages:", local.no)#
					#local.partials.pages(local.dbpages, local.startInput, local.endInput, local.nonconsecutivePageNumsInput, local.nonconsecutiveInput, local.checkbox, local.textbox, local.none, local.noValue)#
					#local.partials.endSection()#
				</cfif>

				<!--- Database --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.databasetitle, "Database title:", local.yes)#
					#local.partials.textbox(local.databaseinput, local.textbox, 45, local.none, local.noValue)#
					#local.partials.endSection()#
				</cfif>

				<!--- Date accessed --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.dbaccessdate, "Date accessed:", local.yes)#
					#local.partials.dateInput(local.dbaccessdate, local.textbox, 12, local.none, local.noValue)#
					#local.partials.endSection()#
				</cfif>

				<!--- URL --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.urlsection, "URL:", local.yes)#
					#local.partials.urlInput(local.urldbinput, local.style, local.source, local.no, local.textbox, local.none, local.noValue)#
					#local.partials.endSection()#
				<cfelseif local.style EQ "apa6">
					#local.partials.beginSection(local.urlsection, "Database URL:", local.yes)#
					#local.partials.urlInput(local.urldbinput, local.style, local.source, local.no, local.textbox, local.none, local.noValue)#
					#local.partials.endSection()#
				</cfif>
			</div>
		</div>

		<!--- Submit button --->
		#local.partials.beginSection(local.submitButton, "", local.yes)#
		#local.partials.submitButton(local.submitclass)#
		#local.partials.endSection()#

		<!--- footer --->
		#local.partials.footercreate()#

		<!--- citation holder --->
		#local.partials.citationhold()#
	</div>
</cfoutput>