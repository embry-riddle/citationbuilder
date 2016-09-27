<cfscript>
	//Include the functions file
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
	param name="local.anonymous" default="Anonymous";
	param name="local.yes" default="yes";
	param name="local.submitbutton" default="submitbutton";
	param name="local.submitclass" default="submitclass";
	param name="local.doisection" default="doisection";
	param name="local.doiwebsiteinput" default="doiwebsiteinput";
	param name="local.doidbinput" default="doidbinput";
	//specific constants
	param name="local.contributorlname0" default="contributorlname0";
	param name="local.chapteressaytitle" default="chapteressaytitle";
	param name="local.chapteressayinput" default="chapteressayinput";
	param name="local.booktitle" default="booktitle";
	param name="local.booktitleinput" default="booktitleinput";
	param name="local.publicationinfo" default="publicationinfo";
	param name="local.pubinfotable" default="pubinfotable";
	param name="local.publisherinput" default="publisherinput";
	param name="local.publisherlocationinput" default="publisherlocationinput";
	param name="local.publicationyearinput" default="publicationyearinput";
	param name="local.pages" default="pages";
	param name="local.startinput" default="startinput";
	param name="local.endinput" default="endinput";
	param name="local.nonconsecutivepagenumsinput" default="nonconsecutivepagenumsinput";
	param name="local.nonconsecutiveinput" default="nonconsecutiveinput";
	param name="local.checkbox" default="checkbox";
	param name="local.websitetitle" default="websitetitle";
	param name="local.websitetitleinput" default="websitetitleinput";
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
#local.partials.heading("Cite a chapter or essay from a book", local.source, local.style)#
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

		<!--- Chapter/essay Title --->
		#local.partials.beginSection(local.chapteressaytitle, "Chapter/essay title:", local.yes)#
		#local.partials.textbox(local.chapteressayinput, local.textbox, 45, local.none, local.noValue)#
		#local.partials.endSection()#

		<!--- Book Title --->
		#local.partials.beginSection(local.booktitle, "Book title:", local.yes)#
		#local.partials.textbox(local.booktitleinput, local.textbox, 45, local.none, local.noValue)#
		#local.partials.endSection()#

		<!--- Publication Info --->
		#local.partials.beginSection(local.publicationinfo, "Publication info:", local.no)#
		#local.partials.publicationinfo(local.pubinfotable, local.publisherInput, local.publisherLocationInput, local.publicationYearInput, local.textbox, local.none, local.noValue)#
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
			<cfif local.style EQ "mla7">
				<!--- Web site Title --->
				#local.partials.beginSection(local.websitetitle, "Website title:", local.yes)#
				#local.partials.textbox(local.websitetitleinput, local.textbox, 45, local.none, local.noValue)#
				#local.partials.endSection()#
			</cfif>

			<!--- URL --->
			<cfif local.style EQ "mla7">
				#local.partials.beginSection(local.urlsection, "URL:", local.yes)#
				#local.partials.urlInput(local.urlwebsiteinput, local.style, local.source, local.no, local.textbox, local.none, local.noValue)#
				#local.partials.endSection()#
			<cfelseif local.style EQ "apa6">
				#local.partials.beginSection(local.urlsection, "URL:", local.yes)#
				#local.partials.urlInput(local.urlwebsiteinput, local.style, local.source, local.yes, local.textbox, local.none, local.noValue)#
				#local.partials.endSection()#
			</cfif>

			<!--- DOI --->
			<cfif local.style EQ "apa6">
				#local.partials.beginSection(local.doisection, "DOI:", local.yes)#
				#local.partials.textbox(local.doiwebsiteinput, local.textbox, 45, local.none, local.noValue)#
				#local.partials.endSection()#
			</cfif>

			<cfif local.style EQ "mla7">
				<!--- Date accessed --->
				#local.partials.beginSection(local.webaccessdate, "Date accessed:", local.yes)#
				#local.partials.dateInput(local.webaccessdate, local.textbox, local.noValue, local.monthDropdown)#
				#local.partials.endSection()#
			</cfif>

		</div>
		<div id="db">
			<!--- Database --->
			#local.partials.beginSection(local.databasetitle, "Database title:", local.yes)#
			#local.partials.textbox(local.databaseinput, local.textbox, 45, local.none, local.noValue)#
			#local.partials.endSection()#

			<!--- URL --->
			<cfif local.style EQ "mla7">
				#local.partials.beginSection(local.urlsection, "URL:", local.yes)#
				#local.partials.urlInput(local.urldbinput, local.style, local.source, local.no, local.textbox, local.none, local.noValue)#
				#local.partials.endSection()#
			<cfelseif local.style EQ "apa6">
				#local.partials.beginSection(local.urlsection, "URL:", local.yes)#
				#local.partials.urlInput(local.urldbinput, local.style, local.source, local.yes, local.textbox, local.none, local.noValue)#
				#local.partials.endSection()#
			</cfif>

			<!--- DOI --->
			<cfif local.style EQ "apa6">
				#local.partials.beginSection(local.doisection, "DOI:", local.yes)#
				#local.partials.textbox(local.doidbinput, local.textbox, 45, local.none, local.noValue)#
				#local.partials.endSection()#
			</cfif>

			<!--- Date accessed --->
			#local.partials.beginSection(local.dbaccessdate, "Date accessed:", local.yes)#
			#local.partials.dateInput(local.dbaccessdate, local.textbox, local.noValue, local.monthDropdown)#
			#local.partials.endSection()#

		</div>
	</div>

	<!--- Submit button --->
	#local.partials.beginSection(local.submitbutton, "", local.yes)#
	#local.partials.submitbutton(local.submitclass)#
	#local.partials.endSection()#

	<!--- footer --->
	#local.partials.footercreate()#

	<!--- citation holder --->
	#local.partials.citationhold()#

</div>
</cfoutput>