<http://citationbuilder.url.ph/>

Citation Builder, ColdFusion Port, version 1.0
Developed by Chris Shannon
September 27, 2016

CHANGES
--------------------------------------
* Converted PHP Code to ColdFusion, all PHP files have been deleted
* Overall: Moved away from existance-based logic to value-based logic.
* Overall: Switched to hashmap for passing data to eliminate lengthy function signatures
* functions.cfc: Split into util.cfc and partials.cfc
* util.cfc: Contains the string utility functions and is imported by citationbuild.cfc and the formats.
* partials.cfc Contains the sub-components, imported by the formats.
* Formats: Differentiated public and private functions
* citationbuild.cfc: Now a component and handles both form posts via generateCitationMarkup() as well as programmatic invocation via generateCitationContent().
* citationbuild.cfc: imports the formats and dynamically calls the functions. This allows new mediums to be added without needing to change citationbuild.cfc
* Moved	cite.cfm, templates, and all css and JS includes to "test" directory
* Application.cfc: Added to restrict form use to dev environments

NEW INSTRUCTIONS FOR EXTENDING THE CITATION BUILDER
--------------------------------------
1. Store your format specific functions in an identifiable file in the directory: formats/
2. Import the format specific functions file you created in #1 at the beginning of the file: citationbuild.cfc.
3. Add your new format to the Citation Builder interface. This can be found as the first function in the file: partials.cfc. The function is named: heading.

--------------------------------------
--------------------------------------

Citation Builder, version 1.0
Developed by Jason Walsh
December 12, 2011


[![Scrutinizer Code Quality](https://scrutinizer-ci.com/g/royopa/citationbuilder/badges/quality-score.png?b=master)](https://scrutinizer-ci.com/g/royopa/citationbuilder/?branch=master)
[![Build Status](https://scrutinizer-ci.com/g/royopa/citationbuilder/badges/build.png?b=master)](https://scrutinizer-ci.com/g/royopa/citationbuilder/build-status/master)

CONTENTS OF THIS FILE
------------------------------------

* About Citation Builder
* Installing Citation Builder
* Customizing Citation Builder
* Extending Citation Builder


ABOUT CITATION BUILDER
--------------------------------------- 

Citation Builder is a web-based tool designed to quickly and easily generate citations for sources consulted during the research process. While powerful tools such as RefWorks, Zotero, and Endnote exist to generate citations, understanding how to use these tools can require an investment of time. Citation Builder is an attempt to provide a low-barrier method for users to generate citations for commonly consulted source media in either APA (American Psychological Association) or MLA (Modern Language Association) formats.

For more information, visit our Github space at: http://github.com/phpforfree/citationbuilder or the North Carolina State University project page at: http://www.lib.ncsu.edu/dli/projects/citationbuilder/

For a demo of Citation Builder, visit the North Carolina State University Libraries installation at: http://www.lib.ncsu.edu/citationbuilder/ 

INSTALLING CITATION BUILDER
----------------------------------------------

Please note: Citation Builder installation requires the inclusion of jQuery libraries and plugins that are neither developed nor maintained by the Citation Builder developer.

Citation Builder installation requires the following:
	1. A web server running PHP 5.2.6 or later: http://php.net
	2. Inclusion of jQuery 1.4 or later: http://jquery.com
	3. Inclusion of jQuery UI 1.8.6 or later: http://jqueryui.com
	4. Inclusion of jQuery Form Plugin: http://jquery.malsup.com/form/
	5. Inclusion of jQuery Colorbox Plugin: http://colorpowered.com/colorbox/
	6. Knowledge of PHP scripting and Javascripting

To install Citation Builder:
	1. Copy the Citation Builder source code to a directory on your web server.
	2. Visit the directory you created in a web browser.     

EXTENDING CITATION BUILDER
----------------------------------------------

Citation Builder only supports APA and MLA citation formats. In addition, Citation Builder only supports books (in entirety), chapters or essays from books, magazines, newspapers, scholarly journal articles, and web sites as citation mediums. Additional citation formats or citation mediums could be added to Citation Builder, if desired. Development and support of any and all additions to the Citation Builder framework are the responsibility of the developing entity. Feel free to fork the project.

RECOMMENDATIONS FOR ADDING ADDITIONAL FORMATS
--------------------------------------------
	
	1. Store your format specific functions in an identifiable file in the directory: includes/formats/
	2. Include the format specific functions file you created in #1 at the end of the file: includes/functions.php. The includes/functions.php file is a set of functions that 
any format/medium in Citation Builder can use.
	3. Add the appropriate PHP logic to the end of the PHP switch cases in the file 
citationbuild.php to call the medium specific citation parsing functions you created in #1
	4. Add your new format to the Citation Builder interface. This can be found as the 
first function in the file: includes/functions.php. The function is named: heading.
