--- 
layout: post
title: DOCTYPE.. (X)HTML, Strict or Transitional?
wordpress_id: 167
wordpress_url: http://www.winstonyw.com/?p=167
date: 2008-08-28 23:22:30 +08:00
---
Lately, I have been reading up on DOCTYPE and (X)HTML as I felt that my knowledge of them was limited. This post is a summary and brain-dump of my readings and is not to be taken as an exhaustive documentation on the subject of DOCTYPE and (X)HTML. Do correct me if I err in any of the stuff mentioned below.

<h3>DOCTYPE</h3>
A DOCTYPE, or Document Type Declaration, defines the legal structure, elements and attributes of a web page. It is declared at the very top of every web page, and is required for browsers and validators to parse and render the document consistently and correctly.

<h3>HTML vs. XHTML</h3>
In the process of creating a web page, we have the choice of declaring our markup to be either HTML or XHTML. However, based on my observations, web pages nowadays are mostly declared as XHTML because XHTML, being known as a reformulation of HTML in XML, is an extension and improvement over HTML.

To quote the current <a href="http://www.w3.org/TR/xhtml1/" target="_blank">XHTML 1.0 Recommendation</a>:
<blockquote>The XHTML family is the next step in the evolution of the Internet. By migrating to XHTML today, content developers can enter the XML world with all of its attendant benefits, while still remaining confident in their content's backward and future compatibility.</blockquote>

As XHTML conforms to the syntax of XML, XHTML pages are required to be well-formed. By enforcing well-formed rules in our markup, XHTML is more consistent to code and easier to maintain. The following are some of the more important rules of being well-formed:
<ul>
	<li>elements must be properly nested</li>
    	<li>elements and attributes must be written in lowercase</li>
    	<li>non-empty elements must be closed</li>
    	<li>empty elements are minimized as a single element and closed with a space before the trailing slash</li>
    	<li>images must contain alternative text</li>
    	<li>markup characters: &lt;, &gt;, &amp; and &quot; are escaped</li>
</ul>

Being well-formed also means that XHTML is backward-compatible and can be served as HTML, using the media type: <em>text/html</em>. In fact, web servers and server-side scripting environments (PHP, Ruby etc) use this media type for content delivery, and so by default, XHTML pages are served as HTML. 
    
In addition, XHTML inherits a useful feature from XML in XML namespaces. Because of this, XHTML markup can include other markup languages like MathML, SMIL, or SVG, and thus extend the basic functionality of a web document. This is semantic flexibility that isn't available in HTML.

Deciding between HTML and XHTML is the easy part, but for each declaration, there are also different flavours to choose from, such as the Strict and Transitional DOCTYPE (and Frameset DOCTYPE).

<h3>Strict DOCTYPE</h3>
A Strict DOCTYPE enforces the separation of structure and presentation, requiring that presentational elements are shifted from markup to CSS. Using a Strict DOCTYPE also ensures that all markup are fully standards-compliant, and would only be processed by browsers in their strictest, standards-compliant mode. Ultimately, this results in the most consistent and forward compatible interpretation of the markup.

<h3>Transitional DOCTYPE</h3>
A Transitional DOCTYPE is used when transiting from legacy markup to modern standards, permitting the use of some deprecated elements or attributes that were common in legacy markup. This DOCTYPE is not meant to be used permanently and all markup should aim towards implementing the Strict DOCTYPE.

<h3>Differences between Strict and Transitional DOCTYPE</h3>
In general, most of the differences between a Strict and Transitional DOCTYPE are related to presentational elements. Listed below are some of the differences that are more likely to cause problems when migrating from Transitional to Strict DOCTYPE.

<h5>Elements not allowed with Strict DOCTYPEs:</h5>
   <ul>
 	<li>center</li>
    	<li>font</li>
    	<li>iframe</li>
    	<li>strike</li>
    	<li>u </li>
</ul>

<h5>Attributes not allowed with Strict DOCTYPEs:</h5>
<ul>
	<li>align (allowed on table elements: col, colgroup, tbody, td, tfoot, th, thead, and tr)</li>
     	<li>language</li>
     	<li>background</li>
     	<li>bgcolor</li>
     	<li>border (allowed on table)</li>
     	<li>height (allowed on img and object)</li>
     	<li>hspace</li>
     	<li>noshade</li>
     	<li>nowrap</li>
     	<li>target</li>
     	<li>text</li>
    	<li>link</li>
     	<li>vlink</li>
     	<li>alink</li>
     	<li>vspace</li>
     	<li>width (allowed on img, object, table, col, and colgroup)</li>
</ul>

<h3>Conclusion</h3>
As most of the readings point out, we should strive to use a Strict DOCTYPE for our web quality's sake. This is because a Strict DOCTYPE promotes the separation of presentation and structure, and results in code consistency and ease of maintenance of any website. HTML 4.01 Strict or XHTML 1.0 Strict? That would depends on our requirements and application architecture. But from a <a href="http://en.wikipedia.org/wiki/Standardista" target="_blank">Web Standardista</a>'s point of view, making sure that a Strict DOCTYPE is in use is more important than anything else.

Note to self: I should start to transit this blog into a Strict DOCTYPE.

<h5>Resources:</h5>
<ul>
<li><a href="http://www.alistapart.com/stories/doctype/" target="_blank">Fix Your Site With the Right DOCTYPE!</a></li>
	<li><a href="http://www.w3.org/QA/2002/04/valid-dtd-list.html" target="_blank">Recommended Lists of DTDs</a></li>
<li><a href="http://www.w3.org/MarkUp/2004/xhtml-faq" target="_blank">HTML and XHTML Frequently Answered Questions</a></li>
	<li><a href="http://codex.wordpress.org/HTML_to_XHTML" target="_blank">HTML to XHTML</a></li>
	<li><a href="http://en.wikipedia.org/wiki/XHTML" target="_blank">XHTML Wikipedia</a></li>
	<li><a href="http://xhtml.com/en/xhtml/serving-xhtml-as-html/" target="_blank">Serving XHTML As HTML</a></li>
	<li><a href="http://www.robertnyman.com/2005/11/02/html-or-xhtml/" target="_blank">HTML or XHTML</a></li>
 	<li><a href="http://24ways.org/2005/transitional-vs-strict-markup" target="_blank">Transitional vs. Strict Markup</a></li>
 	<li><a href="http://www.zvon.org/xxl/xhtmlReference/Output/comparison.html" target="_blank">Comparison of Strict and Transitional XHTML</a></li>
 	<li><a href="http://www.blackwidows.co.uk/resources/tutorials/xhtml/attribute-comparison.php" target="_blank">XHTML1.0 Element Attributes by DTD</a></li>
 </ul>
