<cfparam name="URL.source" default="">
<cfset source = URL.source>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		
		<!-- Stylesheets -->
		<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.6/themes/base/jquery-ui.css" type="text/css" media="all" />
		<link rel="stylesheet" href="css/css.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="css/colorbox.css" type="text/css" media="screen" />
		
		<!-- jQuery -->
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.6/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/jquery_plugins/jquery.form.js"></script>
		<script type="text/javascript" src="js/jquery_plugins/jquery.colorboxmin.js"></script>
		<script type="text/javascript" src="js/document_ready.js"></script>
	</head>
	<body>
		<noscript><div class="noscript">Javascript is disabled in your browser. Citation Builder will not function correctly without it.</div></noscript>
		<h1><a href="index.cfm">Citation Builder</a></h1>		
		<div style="position: relative;">
			<form id="citeform" action="/common/lib/citationbuilder/citationbuild.cfc?method=generateCitationMarkup" method="post">
				<div><input type="hidden" id="mediumholder" name="mediumholder" value="website" /></div>
				
				<!--- Load the appropriate form template based on the source passed in through the URL --->
				<cfswitch expression="#source#">
					<cfcase value="book">
						<cfinclude template='templates/booktemplate.cfm'>
					</cfcase>
					<cfcase value="scholar">
						<cfinclude template="templates/scholarjournaltemplate.cfm">
					</cfcase>
					<cfcase value="bookchapter">
						<cfinclude template="templates/bookchaptertemplate.cfm">
					</cfcase>
					<cfcase value="website">
						<cfinclude template="templates/websitetemplate.cfm">
					</cfcase>
					<cfcase value="magazine">
						<cfinclude template="templates/magazinetemplate.cfm">
					</cfcase>
					<cfcase value="newspaper">
						<cfinclude template="templates/newspapertemplate.cfm">
					</cfcase>
				</cfswitch>
			</form>
			<div id="sourcechangeholder" class="sourcechangeholder">
				Cite a...
				<table width="200px">
					<tr>
						<td>
							<ul>
								<li><a href="cite.cfm?source=book">book (in entirety)</a></li>
								<li><a href="cite.cfm?source=bookchapter">chapter or essay from a book</a></li>
								<li><a href="cite.cfm?source=magazine">magazine article</a></li>
								<li><a href="cite.cfm?source=newspaper">newspaper article</a></li>
								<li><a href="cite.cfm?source=scholar">scholarly journal article</a></li>
								<li><a href="cite.cfm?source=website">web site</a></li>
							</ul>
						</td>
					</tr>
					<tr>
						<td align="right">
							<a href="" id="close" name="close">x Close</a>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>