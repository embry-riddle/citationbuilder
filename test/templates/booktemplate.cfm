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
	param name="local.novalue" default="novalue";
	param name="local.contributormi0" default="contributormi0";
	param name="local.Anonymous" default="Anonymous";
	param name="local.yes" default="yes";
	param name="local.submitButton" default="submitButton";
	param name="local.submitclass" default="submitclass";
	param name="local.doisection" default="doisection";
	param name="local.doiwebsiteInput" default="doiwebsiteInput";
	param name="local.doidbInput" default="doidbInput";
	//specific constants
	param name="local.booktitle" default="booktitle";
	param name="local.booktitleInput" default="booktitleInput";
	param name="local.publicationInfo" default="publicationInfo";
	param name="local.publisherInput" default="publisherInput";
	param name="local.pubinfotable" default="pubinfotable";
	param name="local.publisherlocationInput" default="publisherlocationInput";
	param name="local.publicationyearInput" default="publicationyearInput";
	param name="local.websitetitle" default="websitetitle";
	param name="local.websitetitleInput" default="websitetitleInput";
	param name="local.urlsection" default="urlsection";
	param name="local.urlwebsiteInput" default="urlwebsiteInput";
	param name="local.webaccessdate" default="webaccessdate";
	param name="local.monthdropdown" default="monthdropdown";
	param name="local.databasetitle" default="databasetitle";
	param name="local.databaseInput" default="databaseInput";
	param name="local.urldbInput" default="urldbInput";
	param name="local.dbaccessdate" default="dbaccessdate";
	param name="local.ebookmedium" default="ebookmedium";
	param name="local.mediumInput" default="mediumInput";
	param name="local.urlebookInput" default="urlebookInput";
	param name="local.contributorlname0" default="contributorlname0";
	param name="local.doiebookInput" default="doiebookInput";
</cfscript>
<cfoutput>
	<!--- Heading --->
	#local.partials.heading("Cite a book (in entirety)", local.source, local.style)#

	<div id="tabs">
		<ul>
			<li><a href="##print" class="print">in print</a></li>
			<li><a href="##website" class="website">on a website</a></li>
			<li><a href="##db" class="db">in a database</a></li>
			<li><a href="##ebook" class="ebook">as a digital file</a></li>
		</ul>
		<div>
			<!--- header --->
			#local.partials.headerCreate()#

			<!--- Contributor --->
			#local.partials.beginSection(local.contributor, "Contributor(s):", local.no)#
			#local.partials.contributor(local.contributor, local.contributorfname0, local.contributormi0, local.contributorlname0, local.textbox, local.none, local.noValue, local.anonymous)#
			#local.partials.endsection()#

			<!--- Book title --->
			#local.partials.beginSection(local.booktitle, "Book title:", local.yes)#
			#local.partials.textbox(local.booktitleInput, local.textbox, 45, local.none, local.novalue)#
			#local.partials.endsection()#

			<!--- Publication info --->
			#local.partials.beginSection(local.publicationInfo, "Publication info:", local.no)#
			#local.partials.publicationInfo(local.pubinfotable, local.publisherInput, local.publisherLocationInput, local.publicationYearInput, local.textbox, local.none, local.noValue)#
			#local.partials.endsection()#
		</div>
		<div id="revolvecontent">
			<div id="print">
			</div>
			<div id="website">
				<!--- Website title --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.websitetitle, "Website title:", local.yes)#
					#local.partials.textbox(local.websitetitleInput, local.textbox, 45, local.none, local.novalue)#
					#local.partials.endsection()#
				</cfif>

				<!--- URL --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.urlsection, "URL:", local.yes)#
					#local.partials.urlInput(local.urlwebsiteInput, local.style, local.source, local.no, local.textbox, local.none, local.noValue)#
					#local.partials.endsection()#
				<cfelseif local.style EQ "apa6">
					#local.partials.beginSection(local.urlsection, "URL:", local.yes)#
					#local.partials.urlInput(local.urlwebsiteInput, local.style, local.source, local.yes, local.textbox, local.none, local.noValue)#
					#local.partials.endsection()#
				</cfif>

				<!--- DOI --->
				<cfif local.style EQ "apa6">
					#local.partials.beginSection(local.doisection, "DOI:", local.yes)#
					#local.partials.textbox(local.doiwebsiteInput, local.textbox, 45, local.none, local.novalue)#
					#local.partials.endsection()#
				</cfif>
				
				<!--- Date accessed --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.webaccessdate, "Date accessed:", local.yes)#
					#local.partials.dateInput(local.webaccessdate, local.textbox, local.noValue, local.monthDropdown)#
					#local.partials.endsection()#
				</cfif>
			</div>

			<div id="db">
				<!--- Database title --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.databasetitle, "Database title:", local.yes)#
					#local.partials.textbox(local.databaseInput, local.textbox, 45, local.none, local.novalue)#
					#local.partials.endsection()#
				</cfif>

				<!--- URL --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.urlsection, "URL:", local.yes)#
					#local.partials.urlInput(local.urldbInput, local.style, local.source, local.no, local.textbox, local.none, local.noValue)#
					#local.partials.endsection()#
				<cfelseif local.style EQ "apa6">
					#local.partials.beginSection(local.urlsection, "URL:", local.yes)#
					#local.partials.urlInput(local.urldbInput, local.style, local.source, local.yes, local.textbox, local.none, local.noValue)#
					#local.partials.endsection()#
				</cfif>

				<!--- DOI --->
				<cfif local.style EQ "apa6">
					#local.partials.beginSection(local.doisection, "DOI:", local.yes)#
					#local.partials.textbox(local.doidbInput, local.textbox, 45, local.none, local.novalue)#
					#local.partials.endsection()#
				</cfif>

				<!--- Date accessed --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.webaccessdate, "Date accessed:", local.yes)#
					#local.partials.dateInput(local.dbaccessdate, local.textbox, local.noValue, local.monthDropdown)#
					#local.partials.endsection()#
				</cfif>
			</div>
			
			<div id="ebook">
				<!--- Medium --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.ebookmedium, "Medium:", local.yes)#
					#local.partials.mediumInput(local.mediumInput, local.textbox, local.none, local.noValue, local.monthDropdown)#
					#local.partials.endsection()#
				</cfif>

				<!--- URL --->
				<cfif local.style EQ "mla7">
					#local.partials.beginSection(local.urlsection, "URL:", local.yes)#
					#local.partials.urlInput(local.urlebookInput, local.style, local.source, local.no, local.textbox, local.none, local.noValue)#
					#local.partials.endsection()#
				<cfelseif local.style EQ "apa6">
					#local.partials.beginSection(local.urlsection, "URL:", local.yes)#
					#local.partials.urlInput(local.urlebookInput, local.style, local.source, local.yes, local.textbox, local.none, local.noValue)#
					#local.partials.endsection()#
				</cfif>

				<!--- DOI --->
				<cfif local.style EQ "apa6">
					#local.partials.beginSection(local.doisection, "DOI:", local.yes)#
					#local.partials.textbox(local.doiebookInput, local.textbox, 45, local.none, local.novalue)#
					#local.partials.endsection()#
				</cfif>
			</div>
		</div>

		<!--- Submit button --->
		#local.partials.beginSection(local.submitButton, "", local.yes)#
		#local.partials.submitButton(local.submitclass)#
		#local.partials.endsection()#

		<!--- footer --->
		#local.partials.footercreate()#

		<!--- citation holder --->
		#local.partials.citationhold()#

	</div>
</cfoutput>