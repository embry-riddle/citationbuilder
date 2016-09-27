/**
*
* @file  /C/Users/shann93d/Documents/citationbuilder/includes/formats/apa6_format.cfc
* @author Chris Shannon 
* @description ColdFusion port of the PHP CitationBuilder
*
*/

import 'common.lib.citationbuilder.util';

/**********************************************************/
/*     American Psychological Association (APA) format    */
/**********************************************************/

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

	//Creates a book (in entirety) citation
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
		param name="citationInput.dbDccessDateMonth" default = "";
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
		var dbDccessDateMonth = variables.util.cleanVars(citationInput.dbDccessDateMonth);
		var dbAccessDateYear = variables.util.cleanVars(citationInput.dbAccessDateYear);
		var urlDbInput = variables.util.cleanVars(citationInput.urlDbInput);
		var doiDbInput = variables.util.cleanVars(citationInput.doiDbInput);
		var yearPublishedInput = variables.util.cleanVars(citationInput.yearPublishedInput);
		var mediumInput = variables.util.cleanVars(citationInput.mediumInput);
		var urlEbookInput = variables.util.cleanVars(citationInput.urlEbookInput);
		var doiEbookInput = variables.util.cleanVars(citationInput.doiEbookInput);

		//Add the contributors
		var html = apaAuthorFormat(contributors);
		//Add the publishing date (if provided)
		if (publicationYearInput != "") {
			html &= " (" & publicationYearInput & "). ";
		}
		//Add the book title (if provided)
		if (bookTitleInput != "") {
			html &= bookTitleApaFormat(bookTitleInput, "yes") & " ";
		}
		//Add the translators (if provided)
		html &= apaTranslators(contributors) & " ";
		//Add the editors (if provided)
		html &= apaEditors(contributors) & " ";
		//in print
		if (medium == "print") {
			//Add the publisher location (if provided)
			if (publisherLocationInput != "") {
				html &= variables.util.upperCaseWords(publisherLocationInput) & ": ";
			}
			//Add the publisher (if provided)
			if (publisherInput != "") {
				html &= variables.util.upperCaseWords(publisherInput) & ".";
			}
		}
		//on a website
		if (medium == "website") {
			//Add the URL (if provided)
			if (urlWebsiteInput != "") {
				html &= "Retrieved from " & variables.util.checkUrlPrepend(urlWebsiteInput);
			}
			else if(doiWebsiteInput != "") {
				//Add the DOI (if provided)
				html &= "doi:" & doiWebsiteInput;
			}
		}
		//in a database
		if (medium == "db") {
			//Add the URL (if provided)
			if (urlDbInput != "") {
				html &= "Retrieved from " & variables.util.checkUrlPrepend(urlDbInput);
			}
			else if(doiDbInput != "") {
				//Add the DOI (if provided)
				html &= "doi:" & doiDbInput;
			}
		}
		//as an ebook
		if (medium == "ebook") {
			//Add the URL (if provided)
			if (urlEbookInput != "") {
				html &= "Retrieved from " & variables.util.checkUrlPrepend(urlEbookInput);
			}
			else if(doiEbookInput != "") {
				//Add the DOI (if provided)
				html &= "doi:" & doiEbookInput;
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
		var html = apaAuthorFormat(contributors);
		//Add the publishing date (if provided)
		if (publicationYearInput != "") {
			html &= " (" & publicationYearInput & "). ";
		}
		//Add the chapter/essay title (if provided)
		if (chapterEssayInput != "") {
			html &= articleTitleApaFormat(chapterEssayInput) & " ";
		}
		//Add the translators (if provided)
		html &= apaTranslators(contributors) & " ";
		//Add the editors (if provided)
		if (apaEditors(contributors) != "") {
			html &= apaEditors(contributors) & " ";
		}
		else {
			html &= "In ";
		}
		//Add the book title and page numbers (if provided)
		var pageHolder = apaNewsPaperPages(pagesStartInput, pageSendInput, pagesNonconsecutiveInput, pagesNonconsecutivePageNumsInput);
		if (pageHolder != "") {
			//There are page numbers to display
			if (bookTitleInput != "") {
				//There is a book title to display
				html &= bookTitleApaFormat(bookTitleInput, "no") & " ";
			}
			html &= "(" & pageHolder & "). ";
		}
		else if (bookTitleInput != "") {
			//There is a book title to display
			html &= bookTitleApaFormat(bookTitleInput, "yes") & " ";
		}
		//Add the publisher location (if provided)
		if (publisherLocationInput != "") {
			html &= variables.util.upperCaseWords(publisherLocationInput) & ": ";
		}
		//Add the publisher (if provided)
		if (publisherInput != "") {
			html &= variables.util.upperCaseWords(publisherInput) & ". ";
		}
		//on a website
		if (medium == "website") {
			//Add the URL (if provided)
			if (urlWebsiteInput != "") {
				html &= "Retrieved from " & variables.util.checkUrlPrepend(urlWebsiteInput);
			}
			else if(doiWebsiteInput != "") {
				//Add the DOI (if provided)
				html &= "doi:" & doiWebsiteInput;
			}
		}
		//in a database
		if (medium == "db") {
			//Add the URL (if provided)
			if (urlDbInput != "") {
				html &= "Retrieved from " & variables.util.checkUrlPrepend(urlDbInput);
			}
			else if(doiDbInput != "") {
				//Add the DOI (if provided)
				html &= "doi:" & doiDbInput;
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
		var html = apaAuthorFormat(contributors);
		//Add the publishing date
		html &= apaMagNewsDate(datePublishedDay, datePublishedMonth, datePublishedYear) & ". ";
		//Add the article title (if provided)
		if (articleTitleInput != "") {
			html &= articleTitleApaFormat(articleTitleInput) & " ";
		}
		//Add the magazine title (if provided)
		if (magazineTitleInput != "") {
			var magTitleHolder = variables.util.upperCaseWords(magazineTitleInput);
			html &= "<i>" & variables.util.forceArticleLower(magTitleHolder) & "</i>";
		}
		if (medium == "print") {
			//Add the volume and issue numbers (if provided)
			if (printAdvancedInfoVolume != "" || printAdvancedInfoIssue != "") {
				//Add a comma after the magazine title (if provided)
				if (magazineTitleInput != "") {
					html &= ", ";
				}
				html &= "<i>" & printAdvancedInfoVolume & "</i>";
				if (printAdvancedInfoIssue != "") {
					//Add the issue number (if provided)
					html &= "(" & printAdvancedInfoIssue & ")";
				}
			}
			//Add the page numbers (if provided)
			var pageHolder = apaScholarJournalPages(pagesStartInput, pageSendInput, pagesNonconsecutiveInput, pagesNonconsecutivePageNumsInput);
			if (pageHolder != "") {
				//There are page numbers
				if (printAdvancedInfoVolume != "" || printAdvancedInfoIssue != "") {
					//There is a volume & issue number preceeding
					html &= ", " & pageHolder;
				}
				else {
					//There is no volume & issue number preceeding
					if (magazineTitleInput != "") {
						//There is a magazine title preceeding
						html &= ", " & pageHolder;
					}
					else {
						//There is no magazine title preceeding
						html &= pageHolder;
					}
				}
			}
			//Add a period
			html &= ". ";
		}
		if (medium == "website") {
			//Add the volume and issue numbers (if provided)
			if (websiteAdvancedInfoVolume != "" || websiteAdvancedInfoIssue != "") {
				//Add a comma after the magazine title (if provided)
				if (magazineTitleInput != "") {
					html &= ", ";
				}
				html &= "<i>" & websiteAdvancedInfoVolume & "</i>";
				if (websiteAdvancedInfoIssue != "") {
					//Add the issue number (if provided)
					html &= "(" & websiteAdvancedInfoIssue & ")";
				}
			}
			//Add the page numbers (if provided)
			var pageHolder = apaScholarJournalPages(webpagesStartInput, webpagesEndInput, webpagesNonconsecutiveInput, webpagesNonconsecutivePageNumsInput);
			if (pageHolder != "") {
				//There are page numbers
				if (printAdvancedInfoVolume != "" || printAdvancedInfoIssue != "") {
					//There is a volume & issue number preceeding
					html &= ", " & pageHolder;
				}
				else {
					//There is no volume & issue number preceeding
					if (magazineTitleInput != "") {
						//There is a magazine title preceeding
						html &= ", " & pageHolder;
					}
					else {
						//There is no magazine title preceeding
						html &= pageHolder;
					}
				}
			}
			//Add a period
			html &= ". ";
			//Add the URL (if provided)
			if (urlWebsiteInput != "") {
				html &= "Retrieved from " & variables.util.checkUrlPrepend(urlWebsiteInput);
			}
		}
		if (medium == "db") {
			//Add the volume and issue numbers (if provided)
			if (dbAdvancedInfoVolume != "" || dbAdvancedInfoIssue != "") {
				//Add a comma after the magazine title (if provided)
				if (magazineTitleInput != "") {
					html &= ", ";
				}
				html &= "<i>" & dbAdvancedInfoVolume & "</i>";
				if (dbAdvancedInfoIssue != "") {
					//Add the issue number (if provided)
					html &= "(" & dbAdvancedInfoIssue & ")";
				}
			}
			//Add the page numbers (if provided)
			var pageHolder = apaScholarJournalPages(dbPagesStartInput, dbPagesEndInput, dbPagesNonconsecutiveInput, dbPagesNonconsecutivePageNumsInput);
			if (pageHolder != "") {
				//There are page numbers
				if (dbAdvancedInfoVolume != "" || dbAdvancedInfoIssue != "") {
					//There is a volume & issue number preceeding
					html &= ", " & pageHolder;
				}
				else {
					//There is no volume & issue number preceeding
					if (magazineTitleInput != "") {
						//There is a magazine title preceeding
						html &= ", " & pageHolder;
					}
					else {
						//There is no magazine title preceeding
						html &= pageHolder;
					}
				}
			}
			//Add a period
			html &= ". ";
			//Add the URL (if provided)
			if (urlDbInput != "") {
				html &= "Retrieved from " & variables.util.checkUrlPrepend(urlDbInput);
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

		var style = variables.util.cleanVars(styleholder); 
		var medium = variables.util.cleanVars(mediumholder); 
		var contributors = contributors; 
		var articleTitleInput = variables.util.cleanVars(articleTitleInput); 
		var newspaperTitleInput = variables.util.cleanVars(newspaperTitleInput); 
		var newspaperCityInput = variables.util.cleanVars(newspaperCityInput); 
		var datePublishedDay = variables.util.cleanVars(datePublishedDay); 
		var datePublishedMonth = variables.util.cleanVars(datePublishedMonth); 
		var datePublishedYear = variables.util.cleanVars(datePublishedYear); 
		var editionInput = variables.util.cleanVars(editionInput); 
		var sectionInput = variables.util.cleanVars(sectionInput); 
		var pagesStartInput = variables.util.cleanVars(pagesStartInput); 
		var pagesEndInput = variables.util.cleanVars(pagesEndInput); 
		var pagesNonconsecutiveInput = variables.util.cleanVars(pagesNonconsecutiveInput); 
		var pagesNonconsecutivePageNumsInput = variables.util.cleanVars(pagesNonconsecutivePageNumsInput); 
		var websiteTitleInput = variables.util.cleanVars(websiteTitleInput); 
		var urlWebsiteInput = variables.util.cleanVars(urlWebsiteInput); 
		var electronicPublishDay = variables.util.cleanVars(electronicPublishDay); 
		var electronicPublishMonth = variables.util.cleanVars(electronicPublishMonth); 
		var electronicPublishYear = variables.util.cleanVars(electronicPublishYear); 
		var webAccessDateDay = variables.util.cleanVars(webAccessDateDay); 
		var webAccessDateMonth = variables.util.cleanVars(webAccessDateMonth); 
		var webAccessDateYear = variables.util.cleanVars(webAccessDateYear); 
		var dbNewspaperCityInput = variables.util.cleanVars(dbNewspaperCityInput); 
		var dbDatePublishedDateDay = variables.util.cleanVars(dbDatePublishedDateDay); 
		var dbDatePublishedDateMonth = variables.util.cleanVars(dbDatePublishedDateMonth); 
		var dbDatePublishedDateYear = variables.util.cleanVars(dbDatePublishedDateYear); 
		var dbEditionInput = variables.util.cleanVars(dbEditionInput); 
		var dbPagesStartInput = variables.util.cleanVars(dbPagesStartInput); 
		var dbPageSendInput = variables.util.cleanVars(dbPageSendInput); 
		var dbPagesNonconsecutiveInput = variables.util.cleanVars(dbPagesNonconsecutiveInput); 
		var databaseInput = variables.util.cleanVars(databaseInput); 
		var dbAccessDateDay = variables.util.cleanVars(dbAccessDateDay); 
		var dbAccessDateMonth = variables.util.cleanVars(dbAccessDateMonth); 
		var dbAccessDateYear = variables.util.cleanVars(dbAccessDateYear); 
		var urlDbInput = variables.util.cleanVars(urlDbInput); 

		//Add the contributors
		var html = apaAuthorFormat(contributors);
		//Add the publishing date
		if (medium == "print") {
			html &= apaMagNewsDate(datePublishedDay, datePublishedMonth, datePublishedYear) & ". ";
		}
		if (medium == "website") {
			html &= apaMagNewsDate(electronicPublishDay, electronicPublishMonth, electronicPublishYear) & ". ";
		}
		if (medium == "db") {
			html &= apaMagNewsDate(dbDatePublishedDateDay, dbDatePublishedDateMonth, dbDatePublishedDateYear) & ". ";
		}
		//Add the article title (if provided)
		if (articleTitleInput != "") {
			html &= articleTitleApaFormat(articleTitleInput) & " ";
		}
		//in print
			if (medium == "print") {
				//Add the newspaper title
				html &= "<i>" & variables.util.upperCaseWords(newspaperTitleInput) & "</i>";
				//Add a comma after the newspaper title
				html &= ", ";
				//Add the page numbers
				html &= apaNewsPaperPages(pagesStartInput, pageSendInput, pagesNonconsecutiveInput, pagesNonconsecutivePageNumsInput) & ".";
			}
		//on a website
			if (medium == "website") {
				//Add the newspaper title
				html &= "<i>" & variables.util.upperCaseWords(newspaperTitleInput) & "</i>";
				//Add a period after the newspaper title
				html &= ". ";
				//Add the Home page URL (if provided)
				if (urlWebsiteInput != "") {
					//Add the URL
					html &= "Retrieved from " & urlWebsiteInput;
				}
			}
		//in a database
			if (medium == "db") {
				//Add the newspaper title
				html &= "<i>" & variables.util.upperCaseWords(newspaperTitleInput) & "</i>";
				//Add a period after the newspaper title
				html &= ". ";
				//Add the Home page URL (if provided)
				if (urlDbInput != "") {
					//Add the URL
					html &= "Retrieved from " & urlDbInput;
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
		var html = apaAuthorFormat(contributors);
		//Add the publishing date (if provided)
		if (yearPublishedInput != "") {
			html &= " (" & yearPublishedInput & "). ";
		}
		//Add the article title (if provided)
		if (articleTitleInput != "") {
			html &= articleTitleApaFormat(articleTitleInput) & " ";
		}
		//Add the journal title (if provided)
		if (journalTitleInput != "") {
			journalTitleHolder = variables.util.upperCaseWords(journalTitleInput);
			html &= "<i>" & variables.util.forceArticleLower(journalTitleHolder) & "</i>";
		}
		//Add the volume and issue numbers (if provided)
		if (volume != "" || issue != "") {
			//Add a comma after the journal title (if provided)
			if (journalTitleInput != "") {
				html &= ", ";
			}
			html &= "<i>" & volume & "</i>";
			if (issue != "") {
				//Add the issue number (if provided)
				html &= "(" & issue & ")";
			}
		}
		//Add the page numbers (if provided)
		var pageHolder = apaScholarJournalPages(pagesStartInput, pageSendInput, pagesNonconsecutiveInput, pagesNonconsecutivePageNumsInput);
		if (pageHolder != "") {
			//There are page numbers
			if (volume != "" || issue != "") {
				//There is a volume & issue number preceeding
				html &= ", " & pageHolder;
			}
			else {
				//There is no volume & issue number preceeding
				if (journalTitleInput != "") {
					//There is a magazine title preceeding
					html &= ", " & pageHolder;
				}
				else {
					//There is no journal title preceeding
					html &= pageHolder;
				}
			}
		}
		//Add a period
		html &= ". ";
		//on a website
			if (medium == "website") {
				//Add the URL (if provided)
				if (urlWebsiteInput != "") {
					html &= "Retrieved from " & variables.util.checkUrlPrepend(urlWebsiteInput);
				}
				else if(doiWebsiteInput != "") {
					//Add the DOI (if provided)
					html &= "doi:" & doiWebsiteInput;
				}
			}
		//in a database
			if (medium == "db") {
				//Add the URL (if provided)
				if (urlDbInput != "") {
					html &= "Retrieved from " & variables.util.checkUrlPrepend(urlDbInput);
				}
				else if(doiDbInput != "") {
					//Add the DOI (if provided)
					html &= "doi:" & doiDbInput;
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
		var html = apaAuthorFormat(contributors);
		//Add the publishing date
		html &= apaMagNewsDate(electronicPublishDay, electronicPublishMonth, electronicPublishYear) & ". ";
		//Add the article title (if provided)
		if (articleTitleInput != "") {
			html &= articleTitleApaFormat(articleTitleInput) & " ";
		}
		//Add the website title (if provided)
		if (websiteTitleInput != "") {
			html &= "Retrieved from " & websiteTitleInput & " ";
		}
		//Add the URL (if provided)
		if (urlWebsiteInput != "") {
			html &= "website: " & variables.util.checkUrlPrepend(urlWebsiteInput);
		}
		return html;
	}
	
	// Private Functions
	
	//Format a date published (APA)
	private string function apaMagNewsDate(
		string datePublishedDay = "", 
		string datePublishedMonth = "",
		string datePublishedYear = "") 
	{
		var apaMagNewsDate = "";
		if (datePublishedDay == "" && datePublishedMonth == "" && datePublishedYear == "") {
			apaMagNewsDate = "(n.d.)";
		}
		else {
			apaMagNewsDate = "(" & datePublishedYear & ", " & datePublishedMonth;
			if (datePublishedDay != "") {
				apaMagNewsDate &= " " & datePublishedDay;
			}
			apaMagNewsDate &= ")";
		}
		return apaMagNewsDate;
	}

	//Format page numbers for a newspaper citing (APA)
	private string function apaNewsPaperPages(
		numeric pagesStartInput = 0, 
		numeric pageSendInput = 0, 
		string pagesNonconsecutiveInput = "", 
		string pagesNonconsecutivePageNumsInput = "") 
	{
		var html = "";
		if ((val(pagesStartInput) == val(pageSendInput) || pagesStartInput != 0 && pageSendInput == 0) && (pagesStartInput != 0 && pagesNonconsecutiveInput == "")) {
			//if start page equals end page or there is a start page, but no end page
			html = "p. " & variables.util.upperCaseWords(pagesStartInput);
		}
		if (val(pagesStartInput) < val(pageSendInput) && pagesNonconsecutiveInput == "") {
			//if start page is less than end page and the pages are consecutive
			html = "pp. " & variables.util.upperCaseWords(pagesStartInput) & "-" & variables.util.upperCaseWords(pageSendInput);
		}
		if (pagesNonconsecutiveInput != "" && pagesNonconsecutivePageNumsInput != "") {
			//if the pages are not consecutive and there are page numbers to display
			html = "pp. " & pagesNonconsecutivePageNumsInput;
		}
		return html;
	}

	//Format page numbers for a scholarly journal citing (APA)
	private string function apaScholarJournalPages(
		numeric pagesStartInput = 0,
		numeric pageSendInput = 0,
		string pagesNonconsecutiveInput = "",
		string pagesNonconsecutivePageNumsInput = "") 
	{
		var html = "";
		if ((val(pagesStartInput) == val(pageSendInput) || pagesStartInput != 0 && pageSendInput == 0) && (pagesStartInput != 0 && pagesNonconsecutiveInput == "")) {
			//if start page equals end page or there is a start page, but no end page
			html = variables.util.upperCaseWords(pagesStartInput);
		}
		if (val(pagesStartInput) < val(pageSendInput) && pagesNonconsecutiveInput == "") {
			//if start page is less than end page and the pages are consecutive
			html = variables.util.upperCaseWords(pagesStartInput) & "-" & variables.util.upperCaseWords(pageSendInput);
		}
		if (pagesNonconsecutiveInput != "" && pagesNonconsecutivePageNumsInput != "") {
			//if the pages are not consecutive and there are page numbers to display
			html = pagesNonconsecutivePageNumsInput;
		}
		return html;
	}

	//Format the author names (APA)
	private string function apaAuthorFormat(
		array contributors = []) 
	{
		//Count the number of contributors in the array
		var countContributors = arrayLen(contributors);
		//Count the number of authors in the array
		var countAuthors = 0;
		for (contributor in contributors) {
			
			if (contributor["cselect"]=="author") {
				countAuthors++;
			}
		}
		var html = "";
		for (i=1; i<=countContributors; i++) {
			//If this contributor is an author
			if (contributors[i]["cselect"]=="author") {
				if (i==1) {
					//First time through the loop
					if (countAuthors > 1) {
						//There is more than one author
						html &= variables.util.upperCaseWords(contributors[i]["lname"]);
						if ((contributors[i]["fname"] != "" || contributors[i]["mi"] != "")) {
						//The author is a person and not a corporation
							//Check for a hyphen in the first name
							hyphenTest = find("-", contributors[i]["fname"]);
							if (hyphenTest != 0) {
								html &= ", " & uCase(left(contributors[i]["fname"], 1)) & ".-";
							}
							else {
								html &= ", " & uCase(left(contributors[i]["fname"], 1)) & ".";
							}
							if (contributors[i]["mi"] != "") {
								html &= " " & variables.util.upperCaseWords(contributors[i]["mi"]) & "., ";
							}
							else {
								html &= ", ";
							}
						}
						else {
							//The author is a corporation and not a person
							html &= ", ";
						}
					}
					else {
						//There is only one author
						if ((contributors[i]["lname"]!="Anonymous") || (contributors[i]["lname"] == "" && contributors[i]["fname"] == "" && contributors[i]["mi"] == "")) {
							//The author is not Anonymous or blank
							html &= variables.util.upperCaseWords(contributors[i]["lname"]);
							if ((contributors[i]["fname"] != "" || contributors[i]["mi"] != "")) {
							//The author is a person and not a corporation
								//Check for a hyphen in the first name
								hyphenTest = find("-", contributors[i]["fname"]);
								if (hyphenTest != 0) {
									html &= ", " & uCase(left(contributors[i]["fname"], 1)) & ".-";
								}
								else {
									html &= ", " & uCase(left(contributors[i]["fname"], 1)) & ". ";
								}
								if (contributors[i]["mi"] != "") {
									html &= variables.util.upperCaseWords(contributors[i]["mi"]) & ". ";
								}
							}
							else {
								//The author is a corporation and not a person
								html &= ". ";
							}
						}
					}
				}
				else if (i >= 6) {
					//Sixth or more time through the loop
					if (countAuthors > 7 && i == 6) {
						//There are more than 7 authors and this is the sixth time through the loop
						html &= " " & variables.util.upperCaseWords(contributors[i]["lname"]) & ", ";
						if ((contributors[i]["fname"] != "" || contributors[i]["mi"] != "")) {
							//The author is a person and not a corporation
							//Check for a hyphen in the first name
							hyphenTest = find("-", contributors[i]["fname"]);
							if (hyphenTest != 0) {
								html &= uCase(left(contributors[i]["fname"], 1)) & ".-";
							}
							else {
								html &= uCase(left(contributors[i]["fname"], 1)) & ".";
							}
							if (contributors[i]["mi"] != "") {
								html &= " " & variables.util.upperCaseWords(contributors[i]["mi"]) & ".";
							}
							html &= ", . . . ";
						}
						else {
							//The author is a corporation and not a person
							html &= ", . . . ";
						}
					}
					else if (countAuthors == 7 && i == 6) {
						//There are 7 authors and this is the sixth time through the loop
						html &= " " & variables.util.upperCaseWords(contributors[i]["lname"]);
						if ((contributors[i]["fname"] != "" || contributors[i]["mi"] != "")) {
							//The author is a person and not a corporation
							//Check for a hyphen in the first name
							hyphenTest = find("-", contributors[i]["fname"]);
							if (hyphenTest != 0) {
								html &= ", " & uCase(left(contributors[i]["fname"], 1)) & ".-";
							}
							else {
								html &= ", " & uCase(left(contributors[i]["fname"], 1)) & ". ";
							}
							if (contributors[i]["mi"] != "") {
								html &= variables.util.upperCaseWords(contributors[i]["mi"]) & "., & ";	
							}
							else {
								html &= variables.util.upperCaseWords(contributors[i]["mi"]) & ", & ";	
							}
						}
						else {
							//The author is a corporation and not a person
							html &= ", & ";
						}
					}
					else if (i == countContributors) {
						//This is the last time through the loop
						//If there are 6 authors add an ampersand before the name, otherwise do not
						if (countAuthors==6) {
							html &= " & " & variables.util.upperCaseWords(contributors[i]["lname"]);
							if ((contributors[i]["fname"] != "" || contributors[i]["mi"] != "")) {
								//The author is a person and not a corporation
								//Check for a hyphen in the first name
								hyphenTest = find("-", contributors[i]["fname"]);
								if (hyphenTest != 0) {
									html &= ", " & uCase(left(contributors[i]["fname"], 1)) & ".-";
								}
								else {
									html &= ", " & uCase(left(contributors[i]["fname"], 1)) & ". ";
								}
								if (contributors[i]["mi"] != "") {
									html &= variables.util.upperCaseWords(contributors[i]["mi"]) & ". ";
								}
							}
							else {
								//The author is a corporation and not a person
								html &= ". ";
							}
						}
						else {
							html &= " " & variables.util.upperCaseWords(contributors[i]["lname"]);
							if ((contributors[i]["fname"] != "" || contributors[i]["mi"] != "")) {
								//The author is a person and not a corporation
								//Check for a hyphen in the first name
								hyphenTest = find("-", contributors[i]["fname"]);
								if (hyphenTest != 0) {
									html &= ", " & uCase(left(contributors[i]["fname"], 1)) & ".-";
								}
								else {
									html &= ", " & uCase(left(contributors[i]["fname"], 1)) & ". ";
								}
								if (contributors[i]["mi"] != "") {
									html &= variables.util.upperCaseWords(contributors[i]["mi"]) & ". ";
								}
							}
							else {
								//The author is a corporation and not a person
								html &= ". ";
							}
						}
					}
				}
				else {
					if ((i+1)==countContributors) {
						//This is the last time through the loop
						if (countAuthors>1) {
							//There is more than one author
							html &= " & " & variables.util.upperCaseWords(contributors[i]["lname"]);
							if ((contributors[i]["fname"] != "" || contributors[i]["mi"] != "")) {
								//The author is a person and not a corporation
								//Check for a hyphen in the first name
								hyphenTest = find("-", contributors[i]["fname"]);
								if (hyphenTest != 0) {
									html &= ", " & uCase(left(contributors[i]["fname"], 1)) & ".-";
								}
								else {
									html &= ", " & uCase(left(contributors[i]["fname"], 1)) & ".";
								}
								if (contributors[i]["mi"] != "") {
										html &= " " & variables.util.upperCaseWords(contributors[i]["mi"]) & ". ";
								}
								html &= " ";
							}
							else {
								//The author is a corporation and not a person
								html &= ". ";
							}
						}
						else {
							//There is only one author
							if ((contributors[i]["lname"]!="Anonymous") || (contributors[i]["lname"] == "" && contributors[i]["fname"] == "" && contributors[i]["mi"] == "")) {
								//The author is not Anonymous or blank
								html &= variables.util.upperCaseWords(contributors[i]["lname"]);
								if ((contributors[i]["fname"] != "" || contributors[i]["mi"] != "")) {
									//The author is a person and not a corporation
									//Check for a hyphen in the first name
									hyphenTest = find("-", contributors[i]["fname"]);
									if (hyphenTest != 0) {
										html &= ", " & uCase(left(contributors[i]["fname"], 1)) & ".-";
									}
									else {
										html &= ", " & uCase(left(contributors[i]["fname"], 1)) & ". ";
									}
									if (contributors[i]["mi"] != "") {
										html &= variables.util.upperCaseWords(contributors[i]["mi"]) & ". ";
									}
								}
								else {
									//The author is a corporation and not a person
									html &= ". ";
								}
							}
						}
					}
					else {
						html &= " " & variables.util.upperCaseWords(contributors[i]["lname"]);
						if ((contributors[i]["fname"] != "" || contributors[i]["mi"] != "")) {
							//The author is a person and not a corporation
							//Check for a hyphen in the first name
							hyphenTest = find("-", contributors[i]["fname"]);
							if (hyphenTest != 0) {
								html &= ", " & uCase(left(contributors[i]["fname"], 1)) & ".-";
							}
							else {
								html &= ", " & uCase(left(contributors[i]["fname"], 1)) & ".";
							}
							if (contributors[i]["mi"] != "") {
								html &= " " & variables.util.upperCaseWords(contributors[i]["mi"]) & ".,";
							}
							else {
								html &= ", ";
							}
						}
						else {
							//The author is a corporation and not a person
							html &= ", ";
						}
					}
				}
			}	
		}
		return html;
	}

	//Format the translator names (APA)
	private string function apaTranslators(
		array contributors = [])
	{
		var countContributors = arrayLen(contributors);
		//Count the number of authors in the array
		var countAuthors = 0;
		//Count the number of translators in the array
		var countTranslators = 0;
		for (contributor in contributors) {
			if (contributor["cselect"]=="author") {
				countAuthors++;
			}
			else if(contributor["cselect"]=="translator") {
				countTranslators++;
			}
		}
		var html = "";
		//Translator iterative counter
		var t=1;
		for (i = 1; i <= countContributors; i++) {
			if (contributors[i]["cselect"]=="translator") {
			//If this contributor is an translator
				if (t == 1) {
					//First time through the loop
					if (countTranslators>1) {
						//There is more than one translator
						html &= "(";
							html &= left(variables.util.upperCaseWords(contributors[i]["fname"]), 1) & ". ";
							if (contributors[i]["mi"] != "") {
								html &= variables.util.upperCaseWords(contributors[i]["mi"]) & ". ";
							}
						html &= variables.util.upperCaseWords(contributors[i]["lname"]);
						if (countTranslators > 2) {
							//There are more than two translators
							html &= ",";
						}
					}
					else {
						//There is only one translator
						if ((contributors[i]["lname"]!="Anonymous") || (contributors[i]["lname"] == "" && contributors[i]["fname"] == "" && contributors[i]["mi"] == "")) {
							//The translator is not Anonymous or blank
							html &= "(";
							html &= left(variables.util.upperCaseWords(contributors[i]["fname"]), 1) & ". ";
							if (contributors[i]["mi"] != "") {
								html &= variables.util.upperCaseWords(contributors[i]["mi"]) & ". ";
							}
							html &= variables.util.upperCaseWords(contributors[i]["lname"]);
						}
					}
				}
				else if (t == countTranslators) {
					//Last time through the loop
					if (countTranslators > 1) {
						//There is more than one translator
						html &= " & " & left(variables.util.upperCaseWords(contributors[i]["fname"]), 1) & ". ";
						if (contributors[i]["mi"] != "") {
							html &= variables.util.upperCaseWords(contributors[i]["mi"]) & ". ";
						}
						html &= variables.util.upperCaseWords(contributors[i]["lname"]);
					}
					else {
						//There is only one translator
						if ((contributors[i]["lname"]!="Anonymous") || (contributors[i]["lname"] == "" && contributors[i]["fname"] == "" && contributors[i]["mi"] == "")) {
							//The translator is not Anonymous or blank
							html &= "(";
							html &= left(variables.util.upperCaseWords(contributors[i]["fname"]), 1) & ". ";
							if (contributors[i]["mi"] != "") {
								html &= variables.util.upperCaseWords(contributors[i]["mi"]) & ". ";
							}
							html &= variables.util.upperCaseWords(contributors[i]["lname"]);
						}
					}
				}
				else if ((t+1) == countTranslators) {
					//Second to last time through the loop
					html &= " " & left(variables.util.upperCaseWords(contributors[i]["fname"]), 1) & ". ";
					if (contributors[i]["mi"] != "") {
						html &= variables.util.upperCaseWords(contributors[i]["mi"]) & ". ";
					}
					html &= variables.util.upperCaseWords(contributors[i]["lname"]);				
				}
				else {
					html &= " " & left(variables.util.upperCaseWords(contributors[i]["fname"]), 1) & ". ";
					if (contributors[i]["mi"] != "") {
						html &= variables.util.upperCaseWords(contributors[i]["mi"]) & ". ";
					}
					html &= variables.util.upperCaseWordsI(contributors[i]["lname"]) & ",";				
				}
				t++;
			}
		}
		if (countTranslators > 0) {
			html &= ", Trans.).";
		}
		return html;
	}

	//Format the editor names (APA)
	private string function apaEditors(
		array contributors = [])
	{
		var countContributors = arrayLen(contributors);
		//Count the number of authors in the array
		var countAuthors = 0;
		//Count the number of editors in the array
		var countEditors = 0;
		for(contributor in contributors) {
			if (contributor["cselect"]=="author") {
				countAuthors++;
			}
			else if(contributor["cselect"]=="editor") {
				countEditors++;
			}
		}
		var html = "";
		//editor iterative counter
		var t=1;
		for (i = 1; i <= countContributors; i++) {
			if (contributors[i]["cselect"]=="editor") {
			//If this contributor is an editor
				if (t==1) {
					//First time through the loop
					if (countEditors > 1) {
						//There is more than one editor
						html &= "In ";
							if (contributors[i]["fname"] != "") {
								html &= left(variables.util.upperCaseWords(contributors[i]["fname"]) ,1) & ". ";
							}
							if (contributors[i]["mi"] != "") {
								html &= " " & variables.util.upperCaseWords(contributors[i]["mi"]) & ". ";
							}
						html &= variables.util.upperCaseWords(contributors[i]["lname"]);
						if (countEditors > 2) {
							//There are more than two editors
							html &= ",";
						}
					}
					else {
						//There is only one editor
						html &= "In ";
							if ((contributors[i]["lname"]!="Anonymous") || (contributors[i]["lname"] == "" && contributors[i]["fname"] == "" && contributors[i]["mi"] == "")) {
								//The editor is not Anonymous or blank
								if (contributors[i]["fname"] != "") {
									html &= left(variables.util.upperCaseWords(contributors[i]["fname"]), 1) & ". ";
								}
								if (contributors[i]["mi"] != "") {
									html &= " " & variables.util.upperCaseWords(contributors[i]["mi"]) & ". ";
								}
								html &= variables.util.upperCaseWords(contributors[i]["lname"]);
							}
					}
				}
				else if (t == countEditors) {
					//Last time through the loop
					if (countEditors > 1) {
						//There is more than one editor
						if (contributors[i]["fname"] != "") {
								html &= " & " & left(variables.util.upperCaseWords(contributors[i]["fname"]), 1) & ". ";
							}
							if (contributors[i]["mi"] != "") {
								html &= " " & variables.util.upperCaseWords(contributors[i]["mi"]) & ". ";
							}
						html &= variables.util.upperCaseWords(contributors[i]["lname"]);
					}
					else {
						//There is only one editor
						if ((contributors[i]["lname"]!="Anonymous") || (contributors[i]["lname"] == "" && contributors[i]["fname"] == "" && contributors[i]["mi"] == "")) {
							//The editor is not Anonymous or blank
							if (contributors[i]["fname"] != "") {
								html &= left(variables.util.upperCaseWords(contributors[i]["fname"]), 1) & ". ";
							}
							if (contributors[i]["mi"] != "") {
								html &= " " & variables.util.upperCaseWords(contributors[i]["mi"]) & ". ";
							}
							html &= variables.util.upperCaseWords(contributors[i]["lname"]);
						}
					}
				}
				else if ((t+1) == countEditors) {
					//Second to last time through the loop
					if (contributors[i]["fname"] != "") {
								html &= " " & left(variables.util.upperCaseWords(contributors[i]["fname"]), 1) & ". ";
							}
							if (contributors[i]["mi"] != "") {
								html &= " " & variables.util.upperCaseWords(contributors[i]["mi"]) & ". ";
							}
					html &= variables.util.upperCaseWords(contributors[i]["lname"]);				
				}
				else {
					if (contributors[i]["fname"] != "") {
								html &= " " & left(variables.util.upperCaseWords(contributors[i]["fname"]), 1) & ". ";
							}
							if (contributors[i]["mi"] != "") {
								html &= " " & variables.util.upperCaseWords(contributors[i]["mi"]) & ". ";
							}
					html &= variables.util.upperCaseWords(contributors[i]["lname"]) & ",";				
				}
				t++;
			}
		}
		if (countEditors == 1) {
			html &= " (Ed.),";
		}
		if (countEditors > 1) {
			html &= " (Eds.),";
		}
		return html;
	}

	//Format an article title (APA)
	private string function articleTitleApaFormat(
		string articleTitleInput = "") 
	{
		//Uppercase the first word in article title
		articleTitleInput = variables.util.uCaseFirstLetter(articleTitleInput);
		//If the article title contains a subtitle, capitalize the first word after the colon
		articleTitleInput = variables.util.uCaseSubtitleFirstLetter(articleTitleInput);

		//Punctuate after the article title
		articleTitleInput = variables.util.articlePeriod(articleTitleInput);
		return articleTitleInput;
	}

	//Format a book title (APA)
	/**
	 * @param string addPunctuation
	 */
	private string function bookTitleApaFormat(
		string bookTitleInput = "", 
		string addPunctuation = "") {
		//Uppercase the first word in article title
		html = variables.util.uCaseFirstLetter(bookTitleInput);
		//If the article title contains a subtitle, capitalize the first word after the colon
		html = variables.util.uCaseSubtitleFirstLetter(html);

		if (addPunctuation == "yes") {
			//Punctuate after the book title, if necessary
			html = variables.util.articlePeriod(html);
		}
		html = "<i>" & html & "</i>";
		return html;
	}

}