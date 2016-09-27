/**
*
* @file  /C/Users/shann93d/Documents/citationbuilder/includes/public string functions.cfc
* @author Chris Shannon 
* @description ColdFusion port of the PHP CitationBuilder
*
*/

component output="false" displayname=""  {

	public struct function init(){
		return this;
	}

		
/*****Citation public string functionality******/

	/********************************/
	/*    String manipulation       */
	/********************************/

	//Converts a passed style variable into the appropriate text
	public string function styleConvert(
		string style = "")
	{
		var html = "";
		switch(style) {
			case "apa6":
				html = "APA 6";
				break;
			case "mla7":
				html = "MLA 7";
				break;
		} 
		return html;
	}
	
	//Clean variables of slashes and leading/trailing spaces
	public string function cleanVars(
		string text = "")
	{
		var cleanText = replace(text, "\", "", "ALL");
		cleanText = trim(cleanText);
		return cleanText;
	}
	
	//Uppercase all words in string
	public string function upperCaseWords (
		string text = "")
	{
		var lCaseText = lCase(text);
		var uCaseText = reReplace(lCaseText,"\b(\w)","\u\1","ALL");
		return uCaseText;
	}
	
	//Uppercase first word in a string
	public string function uCaseFirstLetter (
		string text = "")
	{
		var firstChar = uCase(left(text, 1));
		var lcText = lCase(right(text, len(text) - 1));
		return (firstChar & lcText);
	}

	public string function uCaseSubtitleFirstLetter(
		string html = "")
	{
		var matches = reMatch("/:[ ]+[a-z]/", html);
		if (arrayLen(matches) != 0) {
			html = reReplace(html, "/:[ ]+[a-z]/", uCase(matches[1]));
		}

		return html;
	}
	
	//Remove articles (A, An, The) before a string

	/**
	 * @param string text
	 */
	public string function removeArticle(
		string text = "")
	{
		var removeArticle  = reReplace(text, "\[.*?(\A |\An |\The ).*?\]", "", "ALL");
		return removeArticle;
	}
	
	//Force articles, prepositions, and conjuctions to lowercase

	/**
	 * @param string $forcearticlelower
	 */
	public string function forceArticleLower(
		string forceArticleLower = "") 
	{
		forceArticleLower = replace(forceArticleLower, " A ", " a ", "all");
		forceArticleLower = replace(forceArticleLower, " An ", " an ", "all");
		forceArticleLower = replace(forceArticleLower, " And ", " and ", "all");
		forceArticleLower = replace(forceArticleLower, " About ", " about ", "all");
		forceArticleLower = replace(forceArticleLower, " As ", " as ", "all");
		forceArticleLower = replace(forceArticleLower, " At ", " at ", "all");
		forceArticleLower = replace(forceArticleLower, " Away ", " away ", "all");
		forceArticleLower = replace(forceArticleLower, " But ", " but ", "all");
		forceArticleLower = replace(forceArticleLower, " By ", " by ", "all");
		forceArticleLower = replace(forceArticleLower, " Due ", " due ", "all");
		forceArticleLower = replace(forceArticleLower, " For ", " for ", "all");
		forceArticleLower = replace(forceArticleLower, " From ", " from ", "all");
		forceArticleLower = replace(forceArticleLower, " In ", " in ", "all");
		forceArticleLower = replace(forceArticleLower, " Into ", " into ", "all");
		forceArticleLower = replace(forceArticleLower, " Like ", " like ", "all");
		forceArticleLower = replace(forceArticleLower, " Of ", " of ", "all");
		forceArticleLower = replace(forceArticleLower, " Off ", " off ", "all");
		forceArticleLower = replace(forceArticleLower, " On ", " on ", "all");
		forceArticleLower = replace(forceArticleLower, " Onto ", " onto ", "all");
		forceArticleLower = replace(forceArticleLower, " Or ", " or ", "all");
		forceArticleLower = replace(forceArticleLower, " Over ", " over ", "all");
		forceArticleLower = replace(forceArticleLower, " Per ", " per ", "all");
		forceArticleLower = replace(forceArticleLower, " Than ", " than ", "all");
		forceArticleLower = replace(forceArticleLower, " The ", " the ", "all");
		forceArticleLower = replace(forceArticleLower, " Till ", " till ", "all");
		forceArticleLower = replace(forceArticleLower, " To ", " to ", "all");
		forceArticleLower = replace(forceArticleLower, " Until ", " until ", "all");
		forceArticleLower = replace(forceArticleLower, " Up ", " up ", "all");
		forceArticleLower = replace(forceArticleLower, " Upon ", " upon ", "all");
		forceArticleLower = replace(forceArticleLower, " Via ", " via ", "all");
		forceArticleLower = replace(forceArticleLower, " With ", " with ", "all");
		forceArticleLower = replace(forceArticleLower, " Within ", " within ", "all");
		forceArticleLower = replace(forceArticleLower, " Without ", " without ", "all");
		forceArticleLower = replace(forceArticleLower, " Within ", " within ", "all");
		forceArticleLower = replace(forceArticleLower, " Within ", " within ", "all");
		return forceArticleLower;
	}
	
	//Add a period to the end of an article title unless it is a ".", "?", or "!"
	public string function articlePeriod(
		string articleTitle = "")
	{
		var lastArticleTitleChar = right(articleTitle, 1);
		if ((lastArticleTitleChar != ".") && (lastArticleTitleChar != "?") && (lastArticleTitleChar != "!")) {
			articleTitle &= ".";
		}
		return articleTitle;
	}
		
	//Check if a day should be displayed based on a month selection
	public string function dayShow(month) {
		var noShow = 1;
		switch(month) {
			case "January":
				noShow = 0;
				break;
			case "February":
				noShow = 0;
				break;
			case "March":
				noShow = 0;
				break;
			case "April":
				noShow = 0;
				break;
			case "May":
				noShow = 0;
				break;
			case "June":
				noShow = 0;
				break;
				case "July":
				noShow = 0;
				break;
			case "August":
				noShow = 0;
				break;
			case "September":
				noShow = 0;
				break;
				case "October":
				noShow = 0;
				break;
			case "November":
				noShow = 0;
				break;
			case "December":
				noShow = 0;
				break;
		}
		return noShow;
	}
	
	//Check that a URL begins with "http://", "ftp://", "telnet://", or "gopher://" (case-insensitive).  If not, assume http and prepend "http://".
	public string function checkUrlPrepend(urlWebsiteInput) {
		var httpPrefix = findNoCase('http://', urlWebsiteInput);
		var httpsPrefix = findNoCase('https://', urlWebsiteInput);
		var ftpPrefix = findNoCase('ftp://', urlWebsiteInput);
		var telnetPrefix = findNoCase('telnet://', urlWebsiteInput);
		var gopherPrefix = findNoCase('gopher://', urlWebsiteInput);
		if ((httpPrefix != false) && (ftpPrefix != false) && (telnetPrefix != false) && (gopherPrefix != false) && (httpsPrefix != false)) {
		   urlWebsiteInput = "http://" & urlWebsiteInput;
		}
		return urlWebsiteInput;
	}
	
	//Format a name and pull the first initial
	public string function firstInitial(
		string name = "")
	{
		initial = uCase(left(name, 1));
		return initial;
	}
}