/**
*
* @file  /C/Users/shann93d/Documents/citationbuilder/includes/public string util.cfc
* @author Chris Shannon 
* @description ColdFusion port of the PHP CitationBuilder
*
*/

import 'common.lib.citationbuilder.util';
import 'common.lib.citationbuilder.partials';
import 'common.lib.citationbuilder.formats.apa6_format';
import 'common.lib.citationbuilder.formats.mla7_format';

component output="false"  {
	variables.util = new util();
	variables.apa6 = new apa6_format(variables.util);
	variables.mla7 = new mla7_format(variables.util);
	
	remote any function generateCitationMarkup (
		string styleholder = "",
		string sourceholder = "",
		string mediumholder = "")
	{
		var partials = new partials(variables.util);
		var style = styleholder;
		var source = sourceholder;
		var medium = mediumholder;
		
		writeOutput(partials.citationContainStart(style));
		writeOutput(generateCitationContent(arguments));
		writeOutput(partials.citationContainEnd());
		writeOutput(partials.citationContainEnd());
	}

	public string function generateCitationContent(
		struct citationInput = {})
	{
		//Creates a citation
		param name="citationInput.addidvalue" default="";
		param name="citationInput.styleholder" default="";
		param name="citationInput.sourceholder" default="";
		var addidvalue = variables.util.cleanVars(citationInput['addidvalue']);
		var style = variables.util.cleanVars(citationInput['styleholder']);
		var source = variables.util.cleanVars(citationInput['sourceholder']);

		if (!structKeyExists(citationInput, "contributors")) {
			citationInput.contributors = [];
			
			for (var i = 0; i < addidvalue; i++) {
				param name="citationInput.contributorselect#i#" default="";
				param name="citationInput.contributorfname#i#" default="";
				param name="citationInput.contributormi#i#" default="";
				param name="citationInput.contributorlname#i#" default="";
				
				var cselect = variables.util.cleanVars(citationInput['contributorselect' & i]);
				var fname = variables.util.cleanVars(citationInput['contributorfname' & i]);
				var mi = variables.util.cleanVars(citationInput['contributormi' & i]);
				var lname = variables.util.cleanVars(citationInput['contributorlname' & i]);
				
				addcontributor = {};
				if (lname != "") {
					addcontributor.cselect = cselect;
					addcontributor.fname = fname;
					addcontributor.mi = mi;
					addcontributor.lname = lname;
					arrayAppend(citationInput.contributors, addcontributor);
				}
			}
		}
		else {
			for (contributor in citationInput.contributors) {
				param name="contributor.cselect" default="";
				param name="contributor.fname" default="";
				param name="contributor.mi" default="";
				param name="contributor.lname" default="";
			}
		}
		
		var citationContent = "";
		var format = structKeyExists(variables, style) ? variables[style] : {};
		if (!structIsEmpty(format)) {
			format.method = structKeyExists(format, source & "Cite") ? format[source & "Cite"] : {};
			if (!structIsEmpty(format.method)) {
				citationContent = format.method(citationInput);
			}
			else {
				citationContent = "Invalid source selected.";
			}
		}
		else {
			citationContent = "Invalid style selected";
		}

		return citationContent;
	}

	remote void function test(
		any testData = {})
	{
		if (isJSON(testData)) {
			testData = deserializeJSON(testData);
		}
		if (structIsEmpty(testData)) {
			testData = {
				styleholder = "mla7",
				sourceholder = "book",
				mediumholder = "website",
				contributors = [
					{
						cselect = "author",
						fname = "Test",
						mi = "T",
						lname = "Testor"
					}
				],
				articleTitleInput = "Article Title",
				magazineTitleInput = "Magazine Title",
				datePublishedDay = "1",
				datePublishedMonth = "January",
				datePublishedYear = "2003",
				pagesStartInput = "100",
				pagesEndInput = "105",
				pagesNonconsecutiveInput = "",
				pagesNonconsecutivePageNumsInput = "",
				printAdvancedInfoVolume = "10",
				printAdvancedInfoIssue = "58",
				websiteTitleInput = "Test Site",
				webpagesStartInput = "1",
				webpageSendinput = "3",
				webpagesNonconsecutiveInput = "",
				webpagesNonconsecutivePageNumsInput = "",
				websiteAdvancedInfoVolume = "1",
				websiteAdvancedInfoIssue = "5",
				webAccessDateDay = "2",
				webAccessDateMonth = "Feburary",
				webAccessDateYear = "2004",
				urlWebsiteInput = "test.com",
				dbPagesStartInput = "400",
				dbPageSendInput = "404",
				dbPagesNonconsecutiveInput = "",
				dbAdvancedInfoVolume = "50",
				dbAdvancedInfoIssue = "60",
				databaseInput = "",
				dbAccessDateDay = "",
				dbAccessDateMonth = "",
				dbAccessDateYear = "",
				urlDbInput = ""
			};
		}
		
		var response = generateCitationContent(testData);
		writeDump(response);
	}
}