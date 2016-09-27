/**
*
* @file  /C/Users/shann93d/Documents/citationbuilder/includes/formats/mla7_format.cfc
* @author Chris Shannon 
* @description ColdFusion port of the PHP CitationBuilder
*
*/

import 'common.lib.citationbuilder.util';

/****************************************************/
/*     Modern Language Asoociation (MLA) format     */
/****************************************************/

component output="false"  {

	variables.util = {};
	
	// Public Functions
	
	public struct function init(
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

	/********************************/
	/*     Citation parsing         */
	/********************************/

	//Creates a book citation
	public string function bookCite(
		struct citationInput = {})
	{
		param name="citationInput.styleholder" default = "";
		param name="citationInput.mediumholder" default = "";
		param name="citationInput.contributors" default = "#[]#";
		param name="citationInput.publicationYearInput" default = "";
		param name="citationInput.bookTitleInput" default = "";
		param name="citationInput.publisherLocationInput" default = "";
		param name="citationInput.publisherInput" default = "";
		param name="citationInput.websiteTitleInput" default = "";
		param name="citationInput.webAccessDateDay" default = "";
		param name="citationInput.webAccessDateMonth" default = "";
		param name="citationInput.webAccessDateYear" default = "";
		param name="citationInput.urlWebsiteInput" default = "";
		param name="citationInput.doiWebsiteInput" default = "";
		param name="citationInput.databaseInput" default = "";
		param name="citationInput.dbAccessDateDay" default = "";
		param name="citationInput.dbAccessDateMonth" default = "";
		param name="citationInput.dbAccessDateYear" default = "";
		param name="citationInput.urlDbInput" default = "";
		param name="citationInput.doiDbInput" default = "";
		param name="citationInput.yearPublishedInput" default = "";
		param name="citationInput.mediumInput" default = "";
		param name="citationInput.urlEbookInput" default = "";
		param name="citationInput.doiEbookInput" default = "";

		var style = variables.util.cleanVars(citationInput.styleholder);
		var medium = variables.util.cleanVars(citationInput.mediumholder);
		var contributors = citationInput.contributors;
		var publicationYearInput = variables.util.cleanVars(citationInput.publicationYearInput);
		var bookTitleInput = variables.util.cleanVars(citationInput.bookTitleInput);
		var publisherLocationInput = variables.util.cleanVars(citationInput.publisherLocationInput);
		var publisherInput = variables.util.cleanVars(citationInput.publisherInput);
		var websiteTitleInput = variables.util.cleanVars(citationInput.websiteTitleInput);
		var webAccessDateDay = variables.util.cleanVars(citationInput.webAccessDateDay);
		var webAccessDateMonth = variables.util.cleanVars(citationInput.webAccessDateMonth);
		var webAccessDateYear = variables.util.cleanVars(citationInput.webAccessDateYear);
		var urlWebsiteInput = variables.util.cleanVars(citationInput.urlWebsiteInput);
		var doiWebsiteInput = variables.util.cleanVars(citationInput.doiWebsiteInput);
		var databaseInput = variables.util.cleanVars(citationInput.databaseInput);
		var dbAccessDateDay = variables.util.cleanVars(citationInput.dbAccessDateDay);
		var dbAccessDateMonth = variables.util.cleanVars(citationInput.dbAccessDateMonth);
		var dbAccessDateYear = variables.util.cleanVars(citationInput.dbAccessDateYear);
		var urlDbInput = variables.util.cleanVars(citationInput.urlDbInput);
		var doiDbInput = variables.util.cleanVars(citationInput.doiDbInput);
		var yearPublishedInput = variables.util.cleanVars(citationInput.yearPublishedInput);
		var mediumInput = variables.util.cleanVars(citationInput.mediumInput);
		var urlEbookInput = variables.util.cleanVars(citationInput.urlEbookInput);
		var doiEbookInput = variables.util.cleanVars(citationInput.doiEbookInput);

		//Add the contributors
		var html = mlaAuthorFormat(contributors);
		//Add the book title (if provided)
		if (bookTitleInput != "") {
			html &= mlaBookTitleFormat(bookTitleInput, "yes") & ' ';
		}
		//Add the translators (if no authors)
		html &= mlaTranslators(contributors);
		//Add the editors (if no authors)
		html &= mlaEditors(contributors);
		//Add the publisher location (if provided)
		if (publisherLocationInput != "") {
			html &= variables.util.upperCaseWords(publisherLocationInput) & ': ';
		}
		//Add the publisher (if provided)
		if (publisherInput != "") {
			html &= variables.util.upperCaseWords(publisherInput) & ', ';
		}
		//Add the publication year (if provided)
		if (publicationYearInput != "") {
			html &= publicationYearInput & '. ';
		}
		//in print
			if (medium == "print") {
				//Add the medium
				html &= 'Print.';
			}
		//on a website
			if (medium == "website") {
				//Add the title of the website (if provided)
				if (websiteTitleInput != "") {
					html &= '<i>' & variables.util.upperCaseWords(websiteTitleInput) & '</i>' & '. ';
				}
				//Add the medium
				html &= 'Web. ';
				//Add the access date (if provided)
				if (webAccessDateDay != "" || webAccessDateMonth != "" || webAccessDateYear != "") {
					html &= mlaAccessDate(webAccessDateDay, webAccessDateMonth, webAccessDateYear) & '. ';
				}
				//Add the URL (if provided)
				if (urlWebsiteInput != "") {
					html &= '&##60;';
					html &= variables.util.checkUrlPrepend(urlWebsiteInput);
					html &= '&##62;';
					html &= '. ';
				}
				
			}
		//in a database
			if (medium == "db") {
				//Add the database title (if provided)
				if (databaseInput != "") {
					html &= '<i>' & variables.util.upperCaseWords(databaseInput) & '</i>' & '. ';
				}
				//Add the medium
				html &= 'Web. ';
				//Add the access date (if provided)
				if (dbAccessDateDay != "" || dbAccessDateMonth != "" || dbAccessDateYear != "") {
					html &= mlaAccessDate(dbAccessDateDay, dbAccessDateMonth, dbAccessDateYear) & '. ';
				}
				//Add the URL (if provided)
				if (urlDbInput != "") {
					html &= '&##60;';
					html &= variables.util.checkUrlPrepend(urlDbInput);
					html &= '&##62;';
					html &= '. ';
				}
			}
		//as a digital file
			if (medium =="ebook") {
				//Add the Medium
				html &= mlaEbookMediumFormat(mediumInput) & '. ';
				//Add the URL (if provided)
				if (urlEbookInput) {
					html &= '&##60;';
					html &= variables.util.checkUrlPrepend(urlEbookInput);
					html &= '&##62;';
					html &= '. ';
				}
			}
		return html;
	}

	//Creates a chapter or essay from a book citation
	public string function bookchapterCite(
		struct citationInput = {})
	{	
		param name="citationInput.styleholder" default = "";
		param name="citationInput.mediumholder" default = "";
		param name="citationInput.contributors" default = "#[]#";
		param name="citationInput.publicationYearInput" default = "";
		param name="citationInput.chapterEssayInput" default = "";
		param name="citationInput.bookTitleInput" default = "";
		param name="citationInput.pagesStartInput" default = "";
		param name="citationInput.pageSendInput" default = "";
		param name="citationInput.pagesNonconsecutiveInput" default = "";
		param name="citationInput.pagesNonconsecutivePageNumsInput" default = "";
		param name="citationInput.publisherLocationInput" default = "";
		param name="citationInput.publisherInput" default = "";
		param name="citationInput.websiteTitleInput" default = "";
		param name="citationInput.webAccessDateDay" default = "";
		param name="citationInput.webAccessDateMonth" default = "";
		param name="citationInput.webAccessDateYear" default = "";
		param name="citationInput.urlWebsiteInput" default = "";
		param name="citationInput.doiWebsiteInput" default = "";
		param name="citationInput.databaseInput" default = "";
		param name="citationInput.dbAccessDateDay" default = "";
		param name="citationInput.dbDccessDateMonth" default = "";
		param name="citationInput.dbAccessDateYear" default = "";
		param name="citationInput.urlDbInput" default = "";
		param name="citationInput.doiDbInput" default = "";

		var style = variables.util.cleanVars(citationInput.styleholder);
		var medium = variables.util.cleanVars(citationInput.mediumholder);
		var contributors = citationInput.contributors;
		var publicationYearInput = variables.util.cleanVars(citationInput.publicationYearInput);
		var chapterEssayInput = variables.util.cleanVars(citationInput.chapterEssayInput);
		var bookTitleInput = variables.util.cleanVars(citationInput.bookTitleInput);
		var pagesStartInput = variables.util.cleanVars(citationInput.pagesStartInput);
		var pageSendInput = variables.util.cleanVars(citationInput.pageSendInput);
		var pagesNonconsecutiveInput = variables.util.cleanVars(citationInput.pagesNonconsecutiveInput);
		var pagesNonconsecutivePageNumsInput = variables.util.cleanVars(citationInput.pagesNonconsecutivePageNumsInput);
		var publisherLocationInput = variables.util.cleanVars(citationInput.publisherLocationInput);
		var publisherInput = variables.util.cleanVars(citationInput.publisherInput);
		var websiteTitleInput = variables.util.cleanVars(citationInput.websiteTitleInput);
		var webAccessDateDay = variables.util.cleanVars(citationInput.webAccessDateDay);
		var webAccessDateMonth = variables.util.cleanVars(citationInput.webAccessDateMonth);
		var webAccessDateYear = variables.util.cleanVars(citationInput.webAccessDateYear);
		var urlWebsiteInput = variables.util.cleanVars(citationInput.urlWebsiteInput);
		var doiWebsiteInput = variables.util.cleanVars(citationInput.doiWebsiteInput);
		var databaseInput = variables.util.cleanVars(citationInput.databaseInput);
		var dbAccessDateDay = variables.util.cleanVars(citationInput.dbAccessDateDay);
		var dbDccessDateMonth = variables.util.cleanVars(citationInput.dbDccessDateMonth);
		var dbAccessDateYear = variables.util.cleanVars(citationInput.dbAccessDateYear);
		var urlDbInput = variables.util.cleanVars(citationInput.urlDbInput);
		var doiDbInput = variables.util.cleanVars(citationInput.doiDbInput);

		//Add the contributors
		var html = mlaAuthorFormat(contributors);
		//Add the translators (if no authors)
		html &= mlaTranslators(contributors);
		//Add the chapter/essay title (if provided)
		if (chapterEssayInput != "") {
			//Uppercase all words in chapter/essay title, lowercase all articles, prepositions, & conjunctions, append a period, and encapsulate in double quotes
			chapterEssayInput = variables.util.upperCaseWords(chapterEssayInput);
			chapterEssayInput = variables.util.forceArticleLower(chapterEssayInput);
			chapterEssayInput = variables.util.articlePeriod(chapterEssayInput);
			html &= '"' & chapterEssayInput & '" ';
		}
		//Add the book title (if provided)
		if (bookTitleInput != "") {
			html &= mlaBookTitleFormat(bookTitleInput, "yes") & ' ';
		}
		//Add the translators (if no authors)
		html &= mlaTranslators(contributors);
		//Add the editors (if no authors)
		html &= mlaEditors(contributors);
		//Add the publisher location (if provided)
		if (publisherLocationInput != "") {
			html &= variables.util.upperCaseWords(publisherLocationInput) & ': ';
		}
		//Add the publisher (if provided)
		if (publisherInput != "") {
			html &= variables.util.upperCaseWords(publisherInput) & ', ';
		}
		//Add the publication year (if provided)
		if (publicationYearInput != "") {
			html &= publicationYearInput & '. ';
		}
		//Add the page numbers
		html &= mlaPageNumbers(pagesStartInput, pagesEndInput, pagesNonconsecutiveInput);
		//in print
			if (medium == "print") {
				//Add the medium
				html &= 'Print.';
			}
		//on a website
			if (medium == "website") {
				//Add the title of the website (if provided)
				if (websiteTitleInput != "") {
					html &= '<i>' & variables.util.upperCaseWords(websiteTitleInput) & '</i>' & '. ';
				}
				//Add the medium
				html &= 'Web. ';
				//Add the access date (if provided)
				if (webAccessDateDay != "" || webAccessDateMonth != "" || webAccessDateYear != "") {
					html &= mlaAccessDate(webAccessDateDay, webAccessDateMonth, webAccessDateYear) & '. ';
				}
				//Add the URL (if provided)
				if (urlWebsiteInput != "") {
					html &= '&##60;';
					html &= variables.util.checkUrlPrepend(urlWebsiteInput);
					html &= '&##62;';
					html &= '. ';
				}
				
			}
		//in a database
			if (medium == "db") {
				//Add the database title (if provided)
				if (databaseInput != "") {
					html &= '<i>' & variables.util.upperCaseWords(databaseInput) & '</i>' & '. ';
				}
				//Add the medium
				html &= 'Web. ';
				//Add the access date (if provided)
				if (dbAccessDateDay != "" || dbAccessDateMonth != "" || dbAccessDateYear != "") {
					html &= mlaAccessDate(dbAccessDateDay, dbAccessDateMonth, dbAccessDateYear) & '. ';
				}
				//Add the URL (if provided)
				if (urlDbInput != "") {
					html &= '&##60;';
					html &= variables.util.checkUrlPrepend(urlDbInput);
					html &= '&##62;';
					html &= '. ';
				}
			}		
		return html;
	}

	//Creates a magazine article citation
	public string function magazineCite(
		struct citationInput = {})
	{
		param name="citationInput.styleholder" default = "";
		param name="citationInput.mediumholder" default = "";
		param name="citationInput.contributors" default = "#[]#";
		param name="citationInput.articleTitleInput" default = "";
		param name="citationInput.magazineTitleInput" default = "";
		param name="citationInput.datePublishedDay" default = "";
		param name="citationInput.datePublishedMonth" default = "";
		param name="citationInput.datePublishedYear" default = "";
		param name="citationInput.pagesStartInput" default = "";
		param name="citationInput.pagesEndInput" default = "";
		param name="citationInput.pagesNonconsecutiveInput" default = "";
		param name="citationInput.pagesNonconsecutivePageNumsInput" default = "";
		param name="citationInput.printAdvancedInfoVolume" default = "";
		param name="citationInput.printAdvancedInfoIssue" default = "";
		param name="citationInput.websiteTitleInput" default = "";
		param name="citationInput.webpagesStartInput" default = "";
		param name="citationInput.webpageSendinput" default = "";
		param name="citationInput.webpagesNonconsecutiveInput" default = "";
		param name="citationInput.webpagesNonconsecutivePageNumsInput" default = "";
		param name="citationInput.websiteAdvancedInfoVolume" default = "";
		param name="citationInput.websiteAdvancedInfoIssue" default = "";
		param name="citationInput.webAccessDateDay" default = "";
		param name="citationInput.webAccessDateMonth" default = "";
		param name="citationInput.webAccessDateYear" default = "";
		param name="citationInput.urlWebsiteInput" default = "";
		param name="citationInput.dbPagesStartInput" default = "";
		param name="citationInput.dbPageSendInput" default = "";
		param name="citationInput.dbPagesNonconsecutiveInput" default = "";
		param name="citationInput.dbAdvancedInfoVolume" default = "";
		param name="citationInput.dbAdvancedInfoIssue" default = "";
		param name="citationInput.databaseInput" default = "";
		param name="citationInput.dbAccessDateDay" default = "";
		param name="citationInput.dbAccessDateMonth" default = "";
		param name="citationInput.dbAccessDateYear" default = "";
		param name="citationInput.urlDbInput" default = "";

		var style = variables.util.cleanVars(citationInput.styleholder);
		var medium = variables.util.cleanVars(citationInput.mediumholder);
		var contributors = citationInput.contributors;
		var articleTitleInput = variables.util.cleanVars(citationInput.articleTitleInput);
		var magazineTitleInput = variables.util.cleanVars(citationInput.magazineTitleInput);
		var datePublishedDay = variables.util.cleanVars(citationInput.datePublishedDay);
		var datePublishedMonth = variables.util.cleanVars(citationInput.datePublishedMonth);
		var datePublishedYear = variables.util.cleanVars(citationInput.datePublishedYear);
		var pagesStartInput = variables.util.cleanVars(citationInput.pagesStartInput);
		var pagesEndInput = variables.util.cleanVars(citationInput.pagesEndInput);
		var pagesNonconsecutiveInput = variables.util.cleanVars(citationInput.pagesNonconsecutiveInput);
		var pagesNonconsecutivePageNumsInput = variables.util.cleanVars(citationInput.pagesNonconsecutivePageNumsInput);
		var printAdvancedInfoVolume = variables.util.cleanVars(citationInput.printAdvancedInfoVolume);
		var printAdvancedInfoIssue = variables.util.cleanVars(citationInput.printAdvancedInfoIssue);
		var websiteTitleInput = variables.util.cleanVars(citationInput.websiteTitleInput);
		var webpagesStartInput = variables.util.cleanVars(citationInput.webpagesStartInput);
		var webpageSendinput = variables.util.cleanVars(citationInput.webpageSendinput);
		var webpagesNonconsecutiveInput = variables.util.cleanVars(citationInput.webpagesNonconsecutiveInput);
		var webpagesNonconsecutivePageNumsInput = variables.util.cleanVars(citationInput.webpagesNonconsecutivePageNumsInput);
		var websiteAdvancedInfoVolume = variables.util.cleanVars(citationInput.websiteAdvancedInfoVolume);
		var websiteAdvancedInfoIssue = variables.util.cleanVars(citationInput.websiteAdvancedInfoIssue);
		var webAccessDateDay = variables.util.cleanVars(citationInput.webAccessDateDay);
		var webAccessDateMonth = variables.util.cleanVars(citationInput.webAccessDateMonth);
		var webAccessDateYear = variables.util.cleanVars(citationInput.webAccessDateYear);
		var urlWebsiteInput = variables.util.cleanVars(citationInput.urlWebsiteInput);
		var dbPagesStartInput = variables.util.cleanVars(citationInput.dbPagesStartInput);
		var dbPageSendInput = variables.util.cleanVars(citationInput.dbPageSendInput);
		var dbPagesNonconsecutiveInput = variables.util.cleanVars(citationInput.dbPagesNonconsecutiveInput);
		var dbAdvancedInfoVolume = variables.util.cleanVars(citationInput.dbAdvancedInfoVolume);
		var dbAdvancedInfoIssue = variables.util.cleanVars(citationInput.dbAdvancedInfoIssue);
		var databaseInput = variables.util.cleanVars(citationInput.databaseInput);
		var dbAccessDateDay = variables.util.cleanVars(citationInput.dbAccessDateDay);
		var dbAccessDateMonth = variables.util.cleanVars(citationInput.dbAccessDateMonth);
		var dbAccessDateYear = variables.util.cleanVars(citationInput.dbAccessDateYear);
		var urlDbInput = variables.util.cleanVars(citationInput.urlDbInput);

		//Add the contributors
		var html = mlaAuthorFormat(contributors);
		//Add the article title (if provided)
		if (articleTitleInput != "") {
			//Uppercase all words in article title, lowercase all art., prep., & conj., append a period, and encapsulate in double quotes
			articleTitle = variables.util.upperCaseWords(articleTitleInput);
			articleTitle = variables.util.forceArticleLower(articleTitle);
			articleTitle = variables.util.articlePeriod(articleTitle);
			html &= '"' & articleTitle & '" ';
		}
		//in print
		if (medium == "print") {
			//Add the magazine title (if provided)
			if (magazineTitleInput != "") {
				magTitleHolder = variables.util.upperCaseWords(magazineTitleInput);
				html &= '<i>' & variables.util.forceArticleLower(magTitleHolder) & '</i>' & ' ';
			}
			//Add the date published (if provided)
			if (datePublishedDay != "" || datePublishedMonth != "" || datePublishedYear != "") {
				html &= mlaNewsPublishDate(datePublishedDay, datePublishedMonth, datePublishedYear);
				//Add a colon
				html &= ': ';
			}
			//Add the page numbers
			html &= mlaPageNumbers(pagesStartInput, pagesEndInput, pagesNonconsecutiveInput);
			//Add the medium
			html &= 'Print.';
		}
		//on website
		if (medium == "website") {
			//Add the website publisher/sponsor (if provided)
			if (magazineTitleInput != "") {
				html &= '<i>' & variables.util.upperCaseWords(magazineTitleInput) & '</i>' & '. ';
			}
			else {
				html &= 'N.p., ';
			}
			//Add the website title (if provided)
			if (websiteTitleInput != "") {
				html &= variables.util.upperCaseWords(websiteTitleInput) & ', ';
			}
			//Add the date published (if provided)
			html &= mlaNewsPublishDate(datePublishedDay, datePublishedMonth, datePublishedYear);
			//Add a period
			html &= '. ';
			//Add the medium
			html &= 'Web. ';
			//Add the access date (if provided)
			if (webAccessDateDay != "" || webAccessDateMonth != "" || webAccessDateYear != "") {
				html &= mlaAccessDate(webAccessDateDay, webAccessDateMonth, webAccessDateYear) & '. ';
			}
			//Add the URL (if provided)
			if (urlWebsiteInput != "") {
				html &= '&##60;';
				html &= variables.util.checkUrlPrepend(urlWebsiteInput);
				html &= '&##62;';
				html &= '. ';
			}
		}
		//in a database
		if (medium == "db") {
			//Add the magazine title (if provided)
			if (magazineTitleInput != "") {
				magTitleHolder = variables.util.upperCaseWords(magazineTitleInput);
				html &= '<i>' & variables.util.forceArticleLower(magTitleHolder) & '</i>' & ' ';
			}
			//Add the date published (if provided)
			html &= mlaNewsPublishDate(datePublishedDay, datePublishedMonth, datePublishedYear);
			//Add a period
			html &= '. ';
			//Add the page numbers
			html &= mlaPageNumbers(dbPagesStartInput, dbPageSendInput, dbPagesNonconsecutiveInput);
			//Add the database title (if provided)
			if (databaseInput != "") {
				html &= '<i>' & variables.util.upperCaseWords(databaseInput) & '</i>' & '. ';
			}
			//Add the medium
			html &= 'Web. ';
			//Add the access date (if provided)
			if (dbAccessDateDay != "" || dbAccessDateMonth != "" || dbAccessDateYear != "") {
				html &= mlaAccessDate(dbAccessDateDay, dbAccessDateMonth, dbAccessDateYear) & '. ';
			}
			//Add the URL (if provided)
			if (urlDbInput != "") {
				html &= '&##60;';
				html &= variables.util.checkUrlPrepend(urlDbInput);
				html &= '&##62;';
				html &= '. ';
			}
		}
		return html;
	}

	//Creates a newspaper article citation
	public string function newspaperCite(
		struct citationInput = {})
	{
		param name="citationInput.styleholder" default = "";
		param name="citationInput.mediumholder" default = "";
		param name="citationInput.contributors" default = "#[]#";
		param name="citationInput.articleTitleInput" default = "";
		param name="citationInput.newspaperTitleInput" default = "";
		param name="citationInput.newspaperCityInput" default = "";
		param name="citationInput.datePublishedDay" default = "";
		param name="citationInput.datePublishedMonth" default = "";
		param name="citationInput.datePublishedYear" default = "";
		param name="citationInput.editionInput" default = "";
		param name="citationInput.sectionInput" default = "";
		param name="citationInput.pagesStartInput" default = "";
		param name="citationInput.pagesEndInput" default = "";
		param name="citationInput.pagesNonconsecutiveInput" default = "";
		param name="citationInput.pagesNonconsecutivePageNumsInput" default = "";
		param name="citationInput.websiteTitleInput" default = "";
		param name="citationInput.urlWebsiteInput" default = "";
		param name="citationInput.electronicPublishDay" default = "";
		param name="citationInput.electronicPublishMonth" default = "";
		param name="citationInput.electronicPublishYear" default = "";
		param name="citationInput.webAccessDateDay" default = "";
		param name="citationInput.webAccessDateMonth" default = "";
		param name="citationInput.webAccessDateYear" default = "";
		param name="citationInput.dbNewspaperCityInput" default = "";
		param name="citationInput.dbDatePublishedDateDay" default = "";
		param name="citationInput.dbDatePublishedDateMonth" default = "";
		param name="citationInput.dbDatePublishedDateYear" default = "";
		param name="citationInput.dbEditionInput" default = "";
		param name="citationInput.dbPagesStartInput" default = "";
		param name="citationInput.dbPageSendInput" default = "";
		param name="citationInput.dbPagesNonconsecutiveInput" default = "";
		param name="citationInput.databaseInput" default = "";
		param name="citationInput.dbAccessDateDay" default = "";
		param name="citationInput.dbAccessDateMonth" default = "";
		param name="citationInput.dbAccessDateYear" default = "";
		param name="citationInput.urlDbInput" default = "";

		var style = variables.util.cleanVars(citationInput.styleholder); 
		var medium = variables.util.cleanVars(citationInput.mediumholder); 
		var contributors = citationInput.contributors; 
		var articleTitleInput = variables.util.cleanVars(citationInput.articleTitleInput); 
		var newspaperTitleInput = variables.util.cleanVars(citationInput.newspaperTitleInput); 
		var newspaperCityInput = variables.util.cleanVars(citationInput.newspaperCityInput); 
		var datePublishedDay = variables.util.cleanVars(citationInput.datePublishedDay); 
		var datePublishedMonth = variables.util.cleanVars(citationInput.datePublishedMonth); 
		var datePublishedYear = variables.util.cleanVars(citationInput.datePublishedYear); 
		var editionInput = variables.util.cleanVars(citationInput.editionInput); 
		var sectionInput = variables.util.cleanVars(citationInput.sectionInput); 
		var pagesStartInput = variables.util.cleanVars(citationInput.pagesStartInput); 
		var pagesEndInput = variables.util.cleanVars(citationInput.pagesEndInput); 
		var pagesNonconsecutiveInput = variables.util.cleanVars(citationInput.pagesNonconsecutiveInput); 
		var pagesNonconsecutivePageNumsInput = variables.util.cleanVars(citationInput.pagesNonconsecutivePageNumsInput); 
		var websiteTitleInput = variables.util.cleanVars(citationInput.websiteTitleInput); 
		var urlWebsiteInput = variables.util.cleanVars(citationInput.urlWebsiteInput); 
		var electronicPublishDay = variables.util.cleanVars(citationInput.electronicPublishDay); 
		var electronicPublishMonth = variables.util.cleanVars(citationInput.electronicPublishMonth); 
		var electronicPublishYear = variables.util.cleanVars(citationInput.electronicPublishYear); 
		var webAccessDateDay = variables.util.cleanVars(citationInput.webAccessDateDay); 
		var webAccessDateMonth = variables.util.cleanVars(citationInput.webAccessDateMonth); 
		var webAccessDateYear = variables.util.cleanVars(citationInput.webAccessDateYear); 
		var dbNewspaperCityInput = variables.util.cleanVars(citationInput.dbNewspaperCityInput); 
		var dbDatePublishedDateDay = variables.util.cleanVars(citationInput.dbDatePublishedDateDay); 
		var dbDatePublishedDateMonth = variables.util.cleanVars(citationInput.dbDatePublishedDateMonth); 
		var dbDatePublishedDateYear = variables.util.cleanVars(citationInput.dbDatePublishedDateYear); 
		var dbEditionInput = variables.util.cleanVars(citationInput.dbEditionInput); 
		var dbPagesStartInput = variables.util.cleanVars(citationInput.dbPagesStartInput); 
		var dbPageSendInput = variables.util.cleanVars(citationInput.dbPageSendInput); 
		var dbPagesNonconsecutiveInput = variables.util.cleanVars(citationInput.dbPagesNonconsecutiveInput); 
		var databaseInput = variables.util.cleanVars(citationInput.databaseInput); 
		var dbAccessDateDay = variables.util.cleanVars(citationInput.dbAccessDateDay); 
		var dbAccessDateMonth = variables.util.cleanVars(citationInput.dbAccessDateMonth); 
		var dbAccessDateYear = variables.util.cleanVars(citationInput.dbAccessDateYear); 
		var urlDbInput = variables.util.cleanVars(citationInput.urlDbInput); 

		//Add the contributors
		html = mlaAuthorFormat(contributors);
		//Add the article title (if provided)
		if (articleTitleInput != "") {
			//Uppercase all words in article title, lowercase all art., prep., & conj., append a period, and encapsulate in double quotes
			articleTitle = variables.util.upperCaseWords(articleTitleInput);
			articleTitle = variables.util.forceArticleLower(articleTitle);
			articleTitle = variables.util.articlePeriod(articleTitle);
			html &= '"' & articleTitle & '" ';
		}
		//in print
		if (medium == "print") {
			//Add the newspaper title (if provided)
			if (newspaperTitleInput != "") {
				//Uppercase all words in a newspaper's title
				newspaperTitleInput = variables.util.upperCaseWords(newspaperTitleInput);
				//Remove articles (A, An, The) before the newspaper title 
				newspaperTitleInput = removearticle(newspaperTitleInput);
				html &= '<i>' & newspaperTitleInput & '</i>' & ' ';
			}
			//Add the newspaper city (if provided)
			if (newspaperCityInput != "") {
				html &= '[' & variables.util.upperCaseWords(newspaperCityInput) & ']' & ' ';
			}
			//Add the date published (if provided)
			if (datePublishedDay != "" || datePublishedMonth != "" || datePublishedYear != "") {
				html &= mlaNewsPublishDate(datePublishedDay, datePublishedMonth, datePublishedYear);
			}
			//Add the edition (if provided)
			if (editionInput != "") {
				editionInput = lCase(editionInput);
				html &= ', ' & editionAbbrev(editionInput);
			}
			//Add the section (if provided)
			if (sectionInput != "") {
				html &= ', ' & mlaNewspaperSection(sectionInput);
			}
			//Add a colon
			html &= ': ';
			//Add the page numbers
			html &= mlaPageNumbers(pagesStartInput, pagesEndInput, pagesNonconsecutiveInput);
			//Add the medium
			html &= 'Print.';
		}
		//on a website
		if (medium == "website") {
			//Add the web site title (if provided)
			if (websiteTitleInput != "") {
				html &= '<i>' & variables.util.upperCaseWords(websiteTitleInput) & '</i>' & '. ';
			}
			//Add the newspaper title (if provided)
			if (newspaperTitleInput != "") {
				//Uppercase all words in a newspaper's title
				newspaperTitleInput = variables.util.upperCaseWords(newspaperTitleInput);
				//Remove articles (A, An, The) before the newspaper title 
				newspaperTitleInput = variables.util.removeArticle(newspaperTitleInput);
				html &= '<i>' & newspaperTitleInput & '</i>' & ', ';
			}
			//Add the electronically published date (if provided)
			if (electronicPublishDay != "" || electronicPublishMonth != "" || electronicPublishYear != "") {
				html &= mlaNewsPublishDate(electronicPublishDay, electronicPublishMonth, electronicPublishYear) & '. ';
			}
			//Add the medium
			html &= 'Web. ';
			//Add the access date (if provided) 
			if (webAccessDateDay != "" || webAccessDateMonth != "" || webAccessDateYear != "") {
				html &= mlaAccessDate(webAccessDateDay, webAccessDateMonth, webAccessDateYear) & '. ';
			}
			//Add the URL (if provided)
			if (urlWebsiteInput != "") {
				html &= '&##60;';
				html &= variables.util.checkUrlPrepend(urlWebsiteInput);
				html &= '&##62;';
				html &= '. ';
			}
		}
		//in a database
		if (medium == "db") {
			//Add the newspaper title (if provided)
			if (newspaperTitleInput != "") {
				//Uppercase all words in a newspaper's title
				newspaperTitleInput = variables.util.upperCaseWords(newspaperTitleInput);
				//Remove articles (A, An, The) before the newspaper title 
				newspaperTitleInput = removearticle(newspaperTitleInput);
				html &= '<i>' & newspaperTitleInput & '</i>' & ' ';
			}
			//Add the newspaper city (if provided)
			if (dbNewspaperCityInput != "") {
				html &= '[' & variables.util.upperCaseWords(dbNewspaperCityInput) & ']' & ' ';
			}
			//Add the date published (if provided)
			if (dbDatePublishedDateDay != "" || dbDatePublishedDateMonth != "" || dbDatePublishedDateYear != "") {
				html &= mlaNewsPublishDate(dbDatePublishedDateDay, dbDatePublishedDateMonth, dbDatePublishedDateYear);
			}
			//Add the edition (if provided)
			if (dbEditionInput != "") {
				dbEditionInput = lCase(dbEditionInput);
				html &= ', ' & editionAbbrev(dbEditionInput);
			}			
			//Add a colon
			html &= ': ';
			//Add the page numbers
			html &= mlaPageNumbers(dbPagesStartInput, dbPageSendInput, dbPagesNonconsecutiveInput);
			//Add the database title (if provided)
			if (databaseInput != "") {
				html &= '<i>' & variables.util.upperCaseWords(databaseInput) & '</i>' & '. ';
			}
			//Add the medium
			html &= 'Web. ';
			//Add the access date
			html &= mlaAccessDate(dbAccessDateDay, dbAccessDateMonth, dbAccessDateYear) & '. ';
			//Add the URL (if provided)
			if (urlDbInput != "") {
				html &= '&##60;';
				html &= variables.util.checkUrlPrepend(urlDbInput);
				html &= '&##62;';
				html &= '. ';
			}
		}
		return html;
	}

	//Creates a scholarly journal article citation
	public string function scholarCite(
		struct citationInput = {})
	{
		param name="citationInput.styleholder" default = "";
		param name="citationInput.mediumholder" default = "";
		param name="citationInput.contributors" default = "#[]#";
		param name="citationInput.yearPublishedInput" default = "";
		param name="citationInput.articleTitleInput" default = "";
		param name="citationInput.journalTitleInput" default = "";
		param name="citationInput.advancedinfovolume" default = "";
		param name="citationInput.advancedinfoissue" default = "";
		param name="citationInput.pagesStartInput" default = "";
		param name="citationInput.pagesEndInput" default = "";
		param name="citationInput.pagesNonconsecutiveInput" default = "";
		param name="citationInput.pagesNonconsecutivePageNumsInput" default = "";
		param name="citationInput.urlWebsiteInput" default = "";
		param name="citationInput.doiWebsiteInput" default = "";
		param name="citationInput.webAccessDateDay" default = "";
		param name="citationInput.webAccessDateMonth" default = "";
		param name="citationInput.webAccessDateYear" default = "";
		param name="citationInput.databaseInput" default = "";
		param name="citationInput.dbAccessDateDay" default = "";
		param name="citationInput.dbAccessDateMonth" default = "";
		param name="citationInput.dbAccessDateYear" default = "";
		param name="citationInput.urlDbInput" default = "";
		param name="citationInput.doiDbInput" default = "";
		
		var style = variables.util.cleanVars(citationInput.styleholder);
		var medium = variables.util.cleanVars(citationInput.mediumholder);
		var contributors = citationInput.contributors;
		var yearPublishedInput = variables.util.cleanVars(citationInput.yearPublishedInput);
		var articleTitleInput = variables.util.cleanVars(citationInput.articleTitleInput);
		var journalTitleInput = variables.util.cleanVars(citationInput.journalTitleInput);
		var volume = variables.util.cleanVars(citationInput.advancedinfovolume);
		var issue = variables.util.cleanVars(citationInput.advancedinfoissue);
		var pagesStartInput = variables.util.cleanVars(citationInput.pagesStartInput);
		var pagesEndInput = variables.util.cleanVars(citationInput.pagesEndInput);
		var pagesNonconsecutiveInput = variables.util.cleanVars(citationInput.pagesNonconsecutiveInput);
		var pagesNonconsecutivePageNumsInput = variables.util.cleanVars(citationInput.pagesNonconsecutivePageNumsInput);
		var urlWebsiteInput = variables.util.cleanVars(citationInput.urlWebsiteInput);
		var doiWebsiteInput = variables.util.cleanVars(citationInput.doiWebsiteInput);
		var webAccessDateDay = variables.util.cleanVars(citationInput.webAccessDateDay);
		var webAccessDateMonth = variables.util.cleanVars(citationInput.webAccessDateMonth);
		var webAccessDateYear = variables.util.cleanVars(citationInput.webAccessDateYear);
		var databaseInput = variables.util.cleanVars(citationInput.databaseInput);
		var dbAccessDateDay = variables.util.cleanVars(citationInput.dbAccessDateDay);
		var dbAccessDateMonth = variables.util.cleanVars(citationInput.dbAccessDateMonth);
		var dbAccessDateYear = variables.util.cleanVars(citationInput.dbAccessDateYear);
		var urlDbInput = variables.util.cleanVars(citationInput.urlDbInput);
		var doiDbInput = variables.util.cleanVars(citationInput.doiDbInput);

		//Add the contributors
		var html = mlaAuthorFormat(contributors);
		//Add the article title (if provided)
		if (articleTitleInput != "") {
			//Uppercase all words in article title, lowercase all art., prep., & conj., append a period, and encapsulate in double quotes
			var articleTitle = variables.util.upperCaseWords(articleTitleInput);
			articleTitle = variables.util.forceArticleLower(articleTitle);
			articleTitle = variables.util.articlePeriod(articleTitle);
			html &= '"' & articleTitle & '" ';
		}
		//Add the journal title (if provided)
		if (journalTitleInput != "") {
			journalTitleHolder = variables.util.upperCaseWords(journalTitleInput);
			html &= '<i>' & variables.util.forceArticleLower(journalTitleHolder) & ' </i>';
		}
		//Add the volume number (if provided)
		if (volume != "") {
			html &= volume;
		}
		//Add the issue number (if provided)
		if (issue != "") {
			html &= '.' & issue & ' ';
		}
		//Add the date published (if provided)
		if (yearPublishedInput != "") {
			html &= mlaSjYearPublished(yearPublishedInput);
		}
		//Add the page numbers
		html &= mlaPageNumbers(pagesStartInput, pagesEndInput, pagesNonconsecutiveInput);
		//in print
		if (medium == "print") {
			//Add the medium
			html &= 'Print.';
		}
		//on a website
		if (medium == "website") {
			//Add the medium
			html &= 'Web. ';
			//Add the access date (if provided)
			if (webAccessDateDay || webAccessDateMonth || webAccessDateYear) {
				html &= mlaAccessDate(webAccessDateDay, webAccessDateMonth, webAccessDateYear) & '. ';
			}
			//Add the URL (if provided)
			if (urlWebsiteInput != "") {
				html &= '&##60;';
				html &= variables.util.checkUrlPrepend(urlWebsiteInput);
				html &= '&##62;';
				html &= '. ';
			}
		}
		//in a database
		if (medium == "db") {
			//Add the database title (if provided)
			if (databaseInput != "") {
				html &= '<i>' & variables.util.upperCaseWords(databaseInput) & '</i>' & '. ';
			}
			//Add the medium
			html &= 'Web. ';
			//Add the access date (if provided)
			if (dbAccessDateDay != "" || dbAccessDateMonth != "" || dbAccessDateYear != "") {
				html &= mlaAccessDate(dbAccessDateDay, dbAccessDateMonth, dbAccessDateYear) & '. ';
			}
			//Add the URL (if provided)
			if (urlDbInput != "") {
				html &= '&##60;';
				html &= variables.util.checkUrlPrepend(urlDbInput);
				html &= '&##62;';
				html &= '. ';
			}
		}
		return html;
	}

	//Creates a web site citation
	public string function websiteCite(
		struct citationInput = {})
	{
		param name="citationInput.styleholder" default = "";
		param name="citationInput.mediumholder" default = "";
		param name="citationInput.contributors" default = "#[]#";
		param name="citationInput.articleTitleInput" default = "";
		param name="citationInput.websiteTitleInput" default = "";
		param name="citationInput.publisherSponsorInput" default = "";
		param name="citationInput.urlWebsiteInput" default = "";
		param name="citationInput.electronicPublishDay" default = "";
		param name="citationInput.electronicPublishMonth" default = "";
		param name="citationInput.electronicPublishYear" default = "";
		param name="citationInput.webAccessDateDay" default = "";
		param name="citationInput.webAccessDateMonth" default = "";
		param name="citationInput.webAccessDateYear" default = "";

		var style = variables.util.cleanVars(citationInput.styleholder);
		var medium = variables.util.cleanVars(citationInput.mediumholder);
		var contributors = citationInput.contributors;
		var articleTitleInput = variables.util.cleanVars(citationInput.articleTitleInput);
		var websiteTitleInput = variables.util.cleanVars(citationInput.websiteTitleInput);
		var publisherSponsorInput = variables.util.cleanVars(citationInput.publisherSponsorInput);
		var urlWebsiteInput = variables.util.cleanVars(citationInput.urlWebsiteInput);
		var electronicPublishDay = variables.util.cleanVars(citationInput.electronicPublishDay);
		var electronicPublishMonth = variables.util.cleanVars(citationInput.electronicPublishMonth);
		var electronicPublishYear = variables.util.cleanVars(citationInput.electronicPublishYear);
		var webAccessDateDay = variables.util.cleanVars(citationInput.webAccessDateDay);
		var webAccessDateMonth = variables.util.cleanVars(citationInput.webAccessDateMonth);
		var webAccessDateYear = variables.util.cleanVars(citationInput.webAccessDateYear);

		//Add the contributors
		var html = mlaAuthorFormat(contributors);
		//Add the article title (if provided)
		if (articleTitleInput != "") {
			//Uppercase all words in article title, lowercase all art., prep., & conj., append a period, and encapsulate in double quotes
			var articleTitle = variables.util.upperCaseWords(articleTitleInput);
			articleTitle = variables.util.forceArticleLower(articleTitle);
			articleTitle = variables.util.articlePeriod(articleTitle);
			html &= '"' & articleTitle & '" ';
		}
		//Add the web site title (if provided)
		if (websiteTitleInput != "") {
			html &= '<i>' & variables.util.upperCaseWords(websiteTitleInput) & '</i>' & '. ';
		}
		//Add the web site publisher/sponsor (if provided)
		if (publisherSponsorInput != "") {
			html &= variables.util.upperCaseWords(publisherSponsorInput) & ', ';
		}
		else {
			html &= 'N.p., ';
		}
		//Add the electronically published date (if provided)
		html &= mlaNewsPublishDate(electronicPublishDay, electronicPublishMonth, electronicPublishYear);
		//Add a period
		html &= '. ';
		//Add the medium
		html &= 'Web. ';
		//Add the access date (if provided)
		if (webAccessDateDay != "" || webAccessDateMonth != "" || webAccessDateYear != "") {
			html &= mlaAccessDate(webAccessDateDay, webAccessDateMonth, webAccessDateYear) & '. ';
		}
		//Add the URL (if provided)
		if (urlWebsiteInput != "") {
			html &= '&##60;';
			html &= variables.util.checkUrlPrepend(urlWebsiteInput);
			html &= '&##62;';
			html &= '. ';
		}
		return html;
	}
	
	// Private Functions
	
	//Format a date published (MLA)
	private string function mlaNewsPublishDate(
		string datePublishedDay = "",
	 	string datePublishedMonth = "",
	 	string datePublishedYear = "") 
	{
		var mlaNewsPublishDate = "";
		if (datePublishedDay == "" && datePublishedMonth == "" && datePublishedYear == "") {
			mlaNewsPublishDate &= 'n.d';
		}
		else {
			if (variables.util.dayShow(datePublishedMonth) == 0) {
				mlaNewsPublishDate = datePublishedDay & " ";
			}
			mlaNewsPublishDate &= shortenMonth(datePublishedMonth) & " ";
			mlaNewsPublishDate &= datePublishedYear;
		}
		return mlaNewsPublishDate;
	}

	//Format an access date for website or database (MLA)
	private string function mlaAccessDate(
		string dateAccessedDay = "", 
		string dateAccessedMonth = "",
		string dateAccessedYear = "") 
	{
		var mlaAccessDate = "";
		if (variables.util.dayShow(dateAccessedMonth) == 0) {
			mlaAccessDate = dateAccessedDay & " ";
		}
		mlaAccessDate &= shortenMonth(dateAccessedMonth) & " ";
		mlaAccessDate &= dateAccessedYear;
		return mlaAccessDate;
	}

	//Shorten a full month name into an abbreviation (MLA)
	private string function shortenMonth(
		string month = "")
	{
		switch(month) {
			case "January":
				month = "Jan.";
				break;
			case "February":
				month = "Feb.";
				break;
			case "March":
				month = "Mar.";
				break;
			case "April":
				month = "Apr.";
				break;
			case "May":
				month = "May";
				break;
			case "June":
				month = "June";
				break;
				case "July":
				month = "July";
				break;
			case "August":
				month = "Aug.";
				break;
			case "September":
				month = "Sept.";
				break;
				case "October":
				month = "Oct.";
				break;
			case "November":
				month = "Nov.";
				break;
			case "December":
				month = "Dec.";
				break;
		}
		return month;
	}

	//Ensure that ed. is at the end of edition (MLA)
	private string function editionAbbrev(
		string editionInput = "")
	{ 
		var mlaEdition = reReplace(editionInput, "/edition/", "ed.");
		mlaEdition = reReplace(mlaEdition, "/ed/", "ed.");
		mlaEdition = reReplace(mlaEdition, "/ed../", "ed.");
		
		var matches = reMatch("/ed./", mlaEdition);
		if (arrayLen(matches) != 0) {
			mlaEdition = mlaEdition;
		}
		else if (mlaEdition != "") {
			mlaEdition = mlaEdition & " ed.";
		}
		return mlaEdition;
	}

	//Creates the page number output (MLA)
	private string function mlaPageNumbers(
		numeric pagesStartInput = 0,
		numeric pagesEndInput = 0,
		string pagesNonconsecutiveInput = "")
	{
		var html = "";
		if (pagesStartInput == 0 && pagesEndInput == 0 && pagesNonconsecutiveInput == "") {
			//There are no page numbers
			html = "N. pag. ";
		}
		else if ((pagesStartInput == pagesEndInput) || (pagesStartInput != 0 && pagesEndInput == 0)) {
			//The article is only on one page
			html = variables.util.upperCaseWords(pagesStartInput) & ". ";
		}
		if (pagesStartInput < pagesEndInput && pagesNonconsecutiveInput == "") {
			//There is a consecutive range of pages
			html = variables.util.upperCaseWords(pagesStartInput) & "-" & variables.util.upperCaseWords(pagesEndInput) & ". ";
		}
		if (pagesNonconsecutiveInput != "") {
			//There are nonconsecutive pages
			html = variables.util.upperCaseWords(pagesStartInput) & "+. ";
		}
		return html;
	}

	//Format section number for a newspaper citing (MLA)
	private string function mlaNewspaperSection(
		string sectionInput = "") {
		var html = "";
		if (reFindNoCase("[0-9]", sectionInput) == 0) {
			html = sectionInput & ' sec.';
		}
		else {
			html = 'sec. ' & sectionInput;
		}
		return html;
	}

	//Format the author/editor names (MLA)
	private string function mlaAuthorFormat(
		array contributors = [])
	{
		var countContributors = arrayLen(contributors);
		//Count the number of authors in the array
		var countAuthors = 0;
		//Count the number of editors in the array
		var countEditors = 0;
		for (contributor in contributors) {
			if (contributor['cselect'] == 'author') {
				countAuthors++;
			}
			else if (contributor['cselect'] == 'editor') {
				countEditors++;
			}
		}
		var html = "";
		for (i = 1; i <= countContributors; i++) {
			if (contributors[i]['cselect']=='author') {
			//If this contributor is an author
				if (i == 1) {
					//First time through the loop
					if (countAuthors > 1) {
						//There is more than one author
						html &= variables.util.upperCaseWords(contributors[i]['lname']);
						if ((contributors[i]['fname'] != "" || contributors[i]['mi'] != "")) {
							//The author is a person and not a corporation
							html &= ', ' & variables.util.upperCaseWords(contributors[i]['fname']);
							if (contributors[i]['mi'] != "") {
								html &= ' ' & uCase(contributors[i]['mi']) & '.';
							}
						}
						html &= ',';
					}
					else {
						//There is only one author
						if ((contributors[i]['lname']!='Anonymous') || (contributors[i]['lname'] == "" && contributors[i]['fname'] == "" && contributors[i]['mi'] == "")) {
							//The author is not Anonymous or blank
							html &= variables.util.upperCaseWords(contributors[i]['lname']);
							if ((contributors[i]['fname'] != "" || contributors[i]['mi'] != "")) {
								//The author is a person and not a corporation
								html &= ', ' & variables.util.upperCaseWords(contributors[i]['fname']);
								if (contributors[i]['mi'] != "") {
									html &= ' ' & variables.util.upperCaseWords(contributors[i]['mi']);
								}
							}
							html &= '. ';
						}
					}
				}
				else if (i == countContributors) {
					//Last time through the loop
					if (countAuthors > 1) {
						//There is more than one author
						html &= ' and ' & variables.util.upperCaseWords(contributors[i]['fname']) & ' ';
						if (contributors[i]['mi'] != "") {
							html &= variables.util.upperCaseWords(contributors[i]['mi']) & '. ';
						}
						html &= variables.util.upperCaseWords(contributors[i]['lname']) & '. ';
					}
					else {
						//There is only one author
						if ((contributors[i]['lname']!='Anonymous') || (contributors[i]['lname'] == "" && contributors[i]['fname'] == "" && contributors[i]['mi'] == "")) {
							//The author is not Anonymous or blank
							html &= variables.util.upperCaseWords(contributors[i]['lname']) & ', ';
							html &= variables.util.upperCaseWords(contributors[i]['fname']);
							if (contributors[i]['mi'] != "") {
								html &= ' ' & variables.util.upperCaseWords(contributors[i]['mi']);
							}
							html &= '. ';
						}
					}
				}
				else {
					html &= ' ' & variables.util.upperCaseWords(contributors[i]['fname']) & ' ';
					if (contributors[i]['mi'] != "") {
						html &= variables.util.upperCaseWords(contributors[i]['mi']) & '. ';
					}
					html &= variables.util.upperCaseWords(contributors[i]['lname']) & ',';				
				}
			}
			else if ((contributors[i]['cselect'] == 'editor' && countAuthors == 0)) {
			//If this contributor is an editor and there are no authors listed
				if (i == 1) {
					//First time through the loop
					if (countEditors > 1) {
						//There is more than one editor
						html &= variables.util.upperCaseWords(contributors[i]['lname']);
						if ((contributors[i]['fname'] != "" || contributors[i]['mi'] != "")) {
							//The editor is a person and not a corporation
							html &= ', ' & variables.util.upperCaseWords(contributors[i]['fname']);
							if (contributors[i]['mi'] != "") {
								html &= ' ' & variables.util.upperCaseWords(contributors[i]['mi']) & '.';
							}
						}
						if (countEditors > 2) {
							html &= ',';
						}
					}
					else {
						//There is only one editor
						if ((contributors[i]['lname']!='Anonymous') || (contributors[i]['lname'] == "" && contributors[i]['fname'] == "" && contributors[i]['mi'] == "")) {
							//The editor is not Anonymous or blank
							html &= variables.util.upperCaseWords(contributors[i]['lname']);
							if ((contributors[i]['fname'] != "" || contributors[i]['mi'] != "")) {
								//The editor is a person and not a corporation
								html &= ', ' & variables.util.upperCaseWords(contributors[i]['fname']);
								if (contributors[i]['mi'] != "") {
									html &= ' ' & variables.util.upperCaseWords(contributors[i]['mi']);
								}
							}
							html &= ', ed. ';
						}
					}
				}
				else if (i == countContributors) {
					//Last time through the loop
					if (countEditors > 1) {
						//There is more than one editor
						html &= ' and ' & variables.util.upperCaseWords(contributors[i]['fname']) & ' ';
						if (contributors[i]['mi'] != "") {
							html &= variables.util.upperCaseWords(contributors[i]['mi']) & '. ';
						}
						html &= variables.util.upperCaseWords(contributors[i]['lname']) & ', eds. ';
					}
					else {
						//There is only one editor
						if ((contributors[i]['lname']!='Anonymous') || (contributors[i]['lname'] == "" && contributors[i]['fname'] == "" && contributors[i]['mi'] == "")) {
							//The editor is not Anonymous or blank
							html &= variables.util.upperCaseWords(contributors[i]['lname']) & ', ';
							html &= variables.util.upperCaseWords(contributors[i]['fname']);
							if (contributors[i]['mi'] != "") {
								html &= ' ' & variables.util.upperCaseWords(contributors[i]['mi']);
							}
							html &= ', ed. ';
						}
					}
				}
				else {
					html &= ' ' & variables.util.upperCaseWords(contributors[i]['fname']) & ' ';
					if (contributors[i]['mi'] != "") {
						html &= variables.util.upperCaseWords(contributors[i]['mi']) & '. ';
					}
					html &= variables.util.upperCaseWords(contributors[i]['lname']) & ',';				
				}	
			}
		}
		return html;
	}

	//Format the translator names (MLA)
	private string function mlaTranslators(
		array contributors = [])
	{
		var countContributors = arrayLen(contributors);
		//Count the number of authors in the array
		var countAuthors = 0;
		//Count the number of translators in the array
		var countTranslators = 0;
		for (contributor in contributors) {
			if (contributor['cselect'] == 'author') {
				countAuthors++;
			}
			else if (contributor['cselect'] == 'translator') {
				countTranslators++;
			}
		}
		var html = "";
		//Translator iterative counter
		var t = 1;
		for (i = 1; i <= countContributors; i++) {
			if (contributors[i]['cselect'] == 'translator') {
			//If this contributor is an translator
				if (t == 1) {
					//First time through the loop
					if (countTranslators > 1) {
						//There is more than one translator
						html &= 'Trans. ';
							html &= variables.util.upperCaseWords(contributors[i]['fname']) & ' ';
							if (contributors[i]['mi'] != "") {
								html &= variables.util.upperCaseWords(contributors[i]['mi']) & ' ';
							}
						html &= variables.util.upperCaseWords(contributors[i]['lname']);
						//If there are more than two translators, add a comma after the name
						if (counTranslators > 2) {
							html &= ',';
						}
					}
					else {
						//There is only one translator
						if ((contributors[i]['lname']!='Anonymous') || (contributors[i]['lname'] == "" && contributors[i]['fname'] == "" && contributors[i]['mi'] == "")) {
							//The translator is not Anonymous or blank
							html &= 'Trans. ';
							html &= variables.util.upperCaseWords(contributors[i]['fname']) & ' ';
							if (contributors[i]['mi'] != "") {
								html &= variables.util.upperCaseWords(contributors[i]['mi']) & ' ';
							}
							html &= variables.util.upperCaseWords(contributors[i]['lname']) & '. ';
						}
					}
				}
				else if (t == countTranslators) {
					//Last time through the loop
					if (countTranslators > 1) {
						//There is more than one translator
						html &= ' and ' & variables.util.upperCaseWords(contributors[i]['fname']) & ' ';
						if (contributors[i]['mi'] != "") {
							html &= variables.util.upperCaseWords(contributors[i]['mi']) & ' ';
						}
						html &= variables.util.upperCaseWords(contributors[i]['lname']) & '. ';
					}
					else {
						//There is only one translator
						if ((contributors[i]['lname']!='Anonymous') || (contributors[i]['lname'] == "" && contributors[i]['fname'] == "" && contributors[i]['mi'] == "")) {
							//The translator is not Anonymous or blank
							html &= 'Trans. ';
							html &= variables.util.upperCaseWords(contributors[i]['fname']) & ' ';
							if (contributors[i]['mi'] != "") {
								html &= variables.util.upperCaseWords(contributors[i]['mi']) & ' ';
							}
							html &= variables.util.upperCaseWords(contributors[i]['lname']) & '. ';
						}
					}
				}
				else {
					html &= ' ' & variables.util.upperCaseWords(contributors[i]['fname']) & ' ';
					if (contributors[i]['mi'] != "") {
						html &= variables.util.upperCaseWords(contributors[i]['mi']) & ' ';
					}
					html &= variables.util.upperCaseWords(contributors[i]['lname']) & ',';				
				}
				t++;
			}
		}
		return html;
	}

	//Format the editor names, if there is an author (MLA)
	private string function mlaEditors(
		array contributors = "")
	{
		var countContributors = arrayLen(contributors);
		//Count the number of authors in the array
		var countAuthors = 0;
		//Count the number of editors in the array
		var countEditors = 0;
		for (contributor in contributors) {
			if (contributor['cselect']=='author') {
				countAuthors++;
			}
			else if (contributor['cselect']=='editor') {
				countEditors++;
			}
		}
			var html = "";
		//editor iterative counter
		var t = 1;
		for (i = 1; i <= countContributors; i++) {
			if ((contributors[i]['cselect'] == 'editor') && (countAuthors != 0)) {
			//If this contributor is an editor and there are no authors
				if (t == 1) {
					//First time through the loop
					if (countEditors > 1) {
						//There is more than one editor
						html &= 'Ed. ';
							html &= variables.util.upperCaseWords(contributors[i]['fname']);
							if (contributors[i]['mi'] != "") {
								html &= ' ' & variables.util.upperCaseWords(contributors[i]['mi']) & ' ';
							}
						html &= variables.util.upperCaseWords(contributors[i]['lname']);
						//If there are more than two editors, add a comma after the name
						if (countEditors > 2) {
							html &= ',';
						}
					}
					else {
						//There is only one editor
						if ((contributors[i]['lname']!='Anonymous') || (contributors[i]['lname'] == "" && contributors[i]['fname'] == "" && contributors[i]['mi'] == "")) {
							//The editor is not Anonymous or blank
							html &= 'Ed. ';
							html &= variables.util.upperCaseWords(contributors[i]['fname']) & ' ';
							if (contributors[i]['mi'] != "") {
								html &= ' ' & variables.util.upperCaseWords(contributors[i]['mi']) & ' ';
							}
							html &= variables.util.upperCaseWords(contributors[i]['lname']) & '. ';
						}
					}
				}
				else if (t == countEditors) {
					//Last time through the loop
					if (countEditors > 1) {
						//There is more than one editor
						html &= ' and ' & variables.util.upperCaseWords(contributors[i]['fname']) & ' ';
						if (contributors[i]['mi'] != "") {
							html &= variables.util.upperCaseWords(contributors[i]['mi']) & ' ';
						}
						html &= variables.util.upperCaseWords(contributors[i]['lname']) & '. ';
					}
					else {
						//There is only one editor
						if ((contributors[i]['lname']!='Anonymous') || (contributors[i]['lname'] == "" && contributors[i]['fname'] == "" && contributors[i]['mi'] == "")) {
							//The editor is not Anonymous or blank
							html &= 'Ed. ';
							html &= variables.util.upperCaseWords(contributors[i]['fname']);
							if (contributors[i]['mi'] != "") {
								html &= ' ' & variables.util.upperCaseWords(contributors[i]['mi']) & ' ';
							}
							html &= variables.util.upperCaseWords(contributors[i]['lname']) & '. ';
						}
					}
				}
				else {
					html &= ' ' & variables.util.upperCaseWords(contributors[i]['fname']) & ' ';
					if (contributors[i]['mi'] != "") {
						html &= variables.util.upperCaseWords(contributors[i]['mi']) & ' ';
					}
					html &= variables.util.upperCaseWords(contributors[i]['lname']) & ',';				
				}
				t++;
			}
		}
		return html;
	}

	//Format a scholarly journal year published (MLA)
	private string function mlaSjYearPublished(
		string yearPublishedInput = "")
	{
		var html = '(' & yearPublishedInput & '): ';
		return html;
	}

	//Format a book title (MLA)
	/**
	 * @param string addPunctuation
	 */
	private string function mlaBookTitleFormat(
		string bookTitleInput = "",
		string addPunctuation = "")
	{
		//Uppercase the words in book title
		var html = variables.util.upperCaseWords(bookTitleInput);
		//Lowercase all articles, prepositions, & conjunctions
		html = variables.util.forceArticleLower(html);
		//If the article title contains a subtitle, capitalize the first word after the colon
		
		html = variables.util.uCaseSubtitleFirstLetter(html);

		if (addPunctuation=="yes") {
			//Punctuate after the book title, if necessary
			html = variables.util.articlePeriod(html);
		}
		html = '<i>' & html & '</i>';
		return html;
	}

	//Format an eBook medium (MLA)
	private string function mlaEbookMediumFormat(
		string mediumInput = "") {
		var html = "";
		var matches = reMatch("/[ ]+file/", mediumInput);

		if (arrayLen(matches) != 0) {
			html = mediumInput;
		}
		else if (mediumInput == "") {
			//the Medium field is blank
			html = '<i>Digital file</i>';
		}
		else {
			//does not have the word "file" at the end of the string
			html = mediumInput & ' file';
		}
		return html;
	}
}