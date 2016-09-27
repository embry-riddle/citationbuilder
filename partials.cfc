/**
*
* @file  /C/Users/shann93d/Documents/citationbuilder/includes/public string functions.cfc
* @author Chris Shannon 
* @description ColdFusion port of the PHP CitationBuilder
*
*/

import 'common.lib.citationbuilder.util';

component output="false" displayname=""  {
	
	variables.util = {};

	remote struct function init(
		struct util = {})
	{
		if (structIsEmpty(util)) {
			variables.util = new util();
		}
		else {
			variables.util = util;	
		}

		return this;
	}
	
	/*****Form public string functionality******/
	
	//Creates a page heading and links for style choice
	public string function heading(
		string heading = "",
		string source = "",
		string style = "")
	{
		var html = '<div>';
		html &= '<table width="100%"><tr><td width="8%" nowrap="nowrap">';
		html &= '<div id="mainheading" style="mainheading"><h2>' & heading;
		html &= '</h2></div></td><td><div id="change" class="change"><a href="">change</a>';
		html &= '<input type="hidden" id="sourceholder" name="sourceholder" value="' & source & '" /></div></td>';
		html &= '<td align="right"><div id="stylechoice" class="stylechoice"><input type="hidden" id="styleholder" name="styleholder" value="' & style & '" />';
		html &= 'Citation style: ';
		if (style == "apa6") {
			html &= ' <span class="styleselected">APA 6</span> ';
		}
		else {
			html &= ' <a href="cite.cfm?source=' & source & '&amp;style=apa6" id="apa6">APA 6</a> ';
		}
		if (style == "mla7") {
			html &= '| <span class="styleselected">MLA 7</span> ';
		}
		else {
			html &= '| <a href="cite.cfm?source=' & source & '&amp;style=mla7" id="mla7">MLA 7</a> ';
		}
		html &= '</div></td></tr></table></div>';
		return html;
	}

	/********************************/
	/*    Form Inputs               */
	/********************************/
	
	//Creates a checkbox and label div

	/**
	 * @param string id
	 */
	public string function checkbox(
		string id = "",
		string css = "")
	{
		var html = '<input type="checkbox" id="' & id & '" name="' & id & '"';
		html &= ' class="' & css & '" value="1" />';
		return html;
	}
	
	//Creates a month drop down list

	/**
	 * @param string id
	 */
	public string function monthDropdown(
		string id = "",
		string css = "")
	{
		var html = '<div class="' & css & '">';
		html &= '<select id="' & id & '" name="' & id & '">';
		html &= '<option></option>';
		html &= '<option value="January">January</option>'; 
		html &= '<option value="February">February</option>'; 
		html &= '<option value="March">March</option>'; 
		html &= '<option value="April">April</option>'; 
		html &= '<option value="May">May</option>'; 
		html &= '<option value="June">June</option>'; 
		html &= '<option value="July">July</option>'; 
		html &= '<option value="August">August</option>'; 
		html &= '<option value="September">September</option>'; 
		html &= '<option value="October">October</option>'; 
		html &= '<option value="November">November</option>'; 
		html &= '<option value="December">December</option>'; 
		html &= '<option value="Jan. &amp; Feb.">Jan. &amp; Feb.</option>'; 
		html &= '<option value="Feb. &amp; March">Feb. &amp; March</option>'; 
		html &= '<option value="March &amp; April">March &amp; April</option>'; 
		html &= '<option value="April &amp; May">April &amp; May</option>'; 
		html &= '<option value="May &amp; June">May &amp; June</option>'; 
		html &= '<option value="June &amp; July">June &amp; July</option>'; 
		html &= '<option value="July &amp; Aug.">July &amp; Aug.</option>'; 
		html &= '<option value="Aug. &amp; Sept.">Aug. &amp; Sept.</option>'; 
		html &= '<option value="Sept. &amp; Oct.">Sept. &amp; Oct.</option>'; 
		html &= '<option value="Oct. &amp; Nov.">Oct. &amp; Nov.</option>'; 
		html &= '<option value="Nov. &amp; Dec.">Nov. &amp; Dec.</option>'; 
		html &= '<option value="Dec. &amp; Jan.">Dec. &amp; Jan.</option>'; 
		html &= '<option value="Spring">Spring</option>'; 
		html &= '<option value="Summer">Summer</option>';
		html &= '<option value="Fall">Fall</option>'; 
		html &= '<option value="Winter">Winter</option>';
		html &= '</select>';
		html &= '</div>';
		return html;	
	}
	
	//Creates the submit button
	public string function submitButton(
		string css = "")
	{
		var html = '<input type="submit" class="' & css & '" value="Submit" />';
		return html;
	}
	
	//Creates a textbox and label div

	/**
	 * @param integer size
	 */
	public string function textbox(
		string id = "",
		string css = "",
		string size = "",
		string maxlength = "",
		string value = "")
	{
		var html = '<input type="text" id="' & id & '"';
		html &= ' name="' & id & '"';
		html &= ' class="' & css & '"';
		html &= ' size="' & size & '"';
		if (value!="noValue") {
			html &= ' value="' & value & '"';
		}
		html &= ' maxlength="' & maxlength & '" />';
		return html;
	}

	/********************************/
	/*    Form Sections             */
	/********************************/
	
	//Creates the Advanced Info section
	public string function advancedInfo(
		string id = "",
		string textboxVal = "",
		string none = "",
		string noValue = "")
	{
		var html = '<table id="' & id & '">';
		html &= '<tr>';
		html &= '<td>';
		html &= textbox(id & 'volume', textboxVal, 4, none, noValue);
		html &= '<br /><span class="small">Volume</span></td><td>';
		html &= textbox(id & 'issue', textboxVal, 4, none, noValue);
		html &= '<br /><span class="small">Issue</span></td><td>';
		html &= '</tr></table>';
		return html;
	}
	
	//Creates a section and label div
	public string function beginSection(
		string sectionId = "",
		string label = "",
		string top = "")
	{
		var html = '<div id="' & sectionId & '" ';
		html &= 'class="sectionchild">';
		html &= '<table>' & '<tr>' & '<td class="sectionlabel">';
		html &= label;
		html &= '</td>' & '<td>';
		return html;
	}
	
	//Creates the Contributor section
	public string function contributor(
		string id = "",
		string contributorfname0 = "",
		string contributormi0 = "",
		string contributorlname0 = "",
		string textboxVal = "",
		string none = "",
		string noValue = "",
		string anonymous = "")
	{
		var html = '<table id="' & id & 'table0">';
		html &= '<tr>';
		html &= '<td>';
		html &= '<select id="' & id & 'select0" name="' & id & 'select0">';
		html &= '<option value="author">Author</option>';
		html &= '<option value="editor">Editor</option>';
		html &= '<option value="translator">Translator</option>';
		html &= '</select>';
		html &= '</td><td>';
		html &= textbox(contributorfname0, textboxVal, 10, none, noValue);
		html &= '<br /><span class="small">First</span></td><td>';
		html &= textbox(contributormi0, textboxVal, 1, 1, noValue);
		html &= '<br /><span class="small">MI</span></td><td>';
		html &= textbox(contributorlname0, textboxVal, 12, none, anonymous);
		html &= '<br /><span class="small">Last / Corporation</span></td>';
		html &= '<td width="48px"></td>';
		html &= '</tr>';
		html &= '<tr><td colspan="5"><div id="adddiv"><input type="hidden" id="addidvalue" name="addidvalue" value="1" /></div></td></tr>';
		html &= '<tr><td colspan="5" class="addcontributor"><a href="" class="contribaddlink" id="contribaddlink">+ Add another contributor</a></td>';
		html &= '</tr></table>';
		return html;
	}
		
	//Creates a date input
	public string function dateInput(
		string id = "",
		string textboxVal = "",
		string noValue = "",
		string monthDropdownVal = "")
	{
		var html = '<table id="' & id & '">';
		html &= '<tr>';
		html &= '<td>';
		html &= textbox(id & 'day', textboxVal, 2, 2, noValue);
		html &= '<br /><span class="small">Day</span></td><td>';
		html &= monthDropdown(id & 'month', monthDropdownVal);
		html &= '<span class="small">Month</span></td><td>';
		html &= textbox(id & 'year', textboxVal, 4, 4, noValue);
		html &= '<br /><span class="small">Year</span></td>';
		html &= '</tr></table>';
		return html;
	}
	
	//Closes a section and label div
	public string function endsection () {
		var html = "</td></tr></table></div>";
		return html;
	}
	
	//Creates a footer for the form
	public string function footercreate() {
		var html = '<div id="footer" class="footer"></div>';
		return html;
	}
		
	//Creates a header for the form
	public string function headerCreate() {
		var html = '<div id="header" class="header">Fill in everything you know about your source:</div>';
		return html;
	}
	
	//Creates the Medium input
	public string function mediumInput(
		string mediumInput = "",
		string textboxVal = "",
		string none = "",
		string noValue = "",
		string monthDropdown = "")
	{
		var html = textbox(mediumInput, textboxVal, 45, none, noValue);
		html &= '<br/>';
		html &= 'Ex: PDF, Microsoft Word, MP3, etc.';
		return html;
	}
		
	//Creates the Newspaper city input
	public string function newspapercityinput(
		string id = "",
		string textboxVal = "",
		string none = "",
		string noValue = "")
	{
		var html = textbox(id, textboxVal, 45, none, noValue);
		html &= '<br/>';
		html &= 'Only include if city is not in newspaper name';
		return html;
	}
	
	//Creates the Pages section
	public string function pages(
		string id = "",
		string startInput = "",
		string endInput = "",
		string nonconsecutivePageNumsInput = "",
		string nonconsecutiveInput = "",
		string checkboxVal = "",
		string textboxVal = "",
		string none = "",
		string noValue = "")
	{
		var html = '<table id="' & id & '"><tr><td><div id="pagesstart">';
		html &= textbox(id & startInput, textboxVal, 4, none, noValue);
		html &= '<br /><span class="small">Start</span></div></td><td><div id="pagesend">';
		html &= textbox(id & endInput, textboxVal, 4, none, noValue);
		html &= '<br /><span class="small">End</span></div></td>';
		html &= '<td><div id="nonconsecutivepagenums" style="display: none;">';
		html &= textbox(id & nonconsecutivePageNumsInput, textboxVal, 27, none, noValue);
		html &= '<br /><span class="small">Separate the numbers with commas</span></div></td>';
		html &= '<td><div id="pagenccheck">';
		html &= checkbox(id & nonconsecutiveInput, checkboxVal);
		html &= '<span class="small">Pages are non-consecutive</span></div></td></tr></table>';
		return html;
	}
		
	//Creates the Publication Info section
	public string function publicationInfo(
		string id = "",
		string publisherInput = "",
		string publisherLocationInput = "",
		string publicationYearInput = "",
		string textboxVal = "",
		string none = "",
		string noValue = "")
	{
		var html = '<table id="' & id & '"><tr><td>';
		html &= textbox(publisherInput, textboxVal, 15, none, noValue);
		html &= '<br /><span class="small">Publisher</span></td><td>';
		html &= textbox(publisherLocationInput, textboxVal, 15, none, noValue);
		html &= '<br /><span class="small">Location</span></td><td>';
		html &= textbox(publicationYearInput, textboxVal, 4, 4, noValue);
		html &= '<br /><span class="small">Year</span></td></tr></table>';
		return html;
	}
		
	//Creates a URL input
	public string function urlInput(
		string id = "",
		string style = "",
		string source = "",
		string showOr = "",
		string textboxVal = "",
		string none = "",
		string noValue = "")
	{
		var html = textbox(id, textboxVal, 45, none, noValue);
		if (style == "apa6") {
			if (showOr == "yes") {
				html &= '<br /> OR';
			}
		}
		if (style == "mla7") {
			html &= '<br />MLA 7 says to omit the URL unless the source cannot be located without it, or if your instructor requires it.';
		}
		return html;
	}

	/********************************/
	/*     Citation layout          */
	/********************************/
	
	//Creates an overall container for citations
	public string function citationhold() {
		var html = '<div id="placeholder" class="placeholder"></div>';
		return html;
	}
	
	//Creates a single citation container
	public string function citationContainStart(
		string style = "")
	{
		var html = '<div id="overallcitationholder"><table width="100%"><tr><td align="center">Copy and paste the citation below into your work.</td></tr></table>';
		html &= '<div id="citationholder" class="citationholder"><span class="styleheading">' & variables.util.styleConvert(style) & '</span><br />';
		return html;
	}
	
	//Closes a single citation container
	public string function citationContainEnd() {
		var html = '</div>';
		return html;
	}
}