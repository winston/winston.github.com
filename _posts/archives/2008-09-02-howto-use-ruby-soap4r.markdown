--- 
layout: post
title: HOWTO Use Ruby SOAP4R
wordpress_id: 171
wordpress_url: http://www.winstonyw.com/?p=171
date: 2008-09-02 00:52:52 +08:00
---
Ruby comes with an implementation of SOAP (SOAP4R), a protocol for exchanging XML-based messages, and recently, I had a chance to use this library. Having no knowledge of the SOAP4R library, I conveniently consulted the <a href="http://www.amazon.com/Programming-Ruby-Pragmatic-Programmers-Second/dp/0974514055/ref=sr_1_3_s9_rk?ie=UTF8&s=books&s9r=8a5801be0c14f3e7010c1b3d44870007&itemPosition=3&qid=1220285385&sr=8-3" target="_blank">Pickaxe book</a> which was on my table, and it presented me with an excellent overview of the library.

Now, I'm going to document the two different approaches of connecting to a SOAP API which I have learned from the book, so that I don't forget them easily. I recommend the Pickaxe book if you are interested in more detailed explanations.

<a href="http://www.xurrency.com" target="_blank">Xurrency</a> is an online currency conversion service which I am using in one of my projects and <a href="http://www.xurrency.com/api" target="_blank">Xurrency's API is based in SOAP</a>. The API has several methods exposed and I'll only be using one of them in my examples, but the principle is the same for other method invocations.

The method that I'll be using is: <em>float getValue(float $amount, string $base, string target)</em> which returns a float value for a currency conversion.

<h3>First Example</h3>
[code=ruby]
#Require The Library
require 'soap/rpc/driver'

#Connections
endpoint = 'http://www.xurrency.com/servidor_soap.php'
proxy    = SOAP::RPC::Driver.new(endpoint)

#Add Method
proxy.add_method('getValue', 'amount', 'base', 'target')

#Call API Method and Get Exchange Rate
rate = proxy.getValue('1','usd','eur')
puts 'Rate: #{rate}'
[/code]

The output:
[code=sh]
sh> ruby currency.rb
Rate: 0.6787
[/code]

<h3>Second Example</h3>
[code=ruby]
#Require The Library
require 'soap/wsdlDriver'

#Connections
wsdl_url = 'http://xurrency.com/api.wsdl'
proxy    = SOAP::WSDLDriverFactory.new(wsdl_url).create_rpc_driver

#Call API Method and Get Exchange Rate
rate = proxy.getValue(1,'usd','eur')
puts 'Rate: #{rate}'
[/code]

The output:
[code=sh]
sh> ruby currency.rb
Rate: 0.6787
[/code]

In the first example, I created a local proxy for the Xurrency API, adds the method which I want to use, and then invokes it.

In the second example, I made use of a WSDL (Web Services Description Language) document available at <em>http://xurrency.com/api.wsdl</em>. This WSDL document describes the Xurrency API, and so SOAP can read this WSDL and perform dynamic discovery of the API interfaces which removes the need to add the <em>getValue</em> method explicitly.

To quote from the Pickaxe book, a WSDL document is:
<blockquote>..an XML document that describes the types, methods, and access mechanisms for a Web services interface. SOAP clients can read WSDL file to create the interfaces to a server automatically..</blockquote>

Despite the differences when connecting to the SOAP API, the underlying concept is similar for both the examples. The SOAP library creates local proxies that SOAP uses to connect to the remote server API (which is published by a SOAP server). When a method is invoked on the local proxy, the invocation is passed to the corresponding API interface on the server via XML. The server then processes the method invocation, and the returned values are passed back to the client through the proxy.

What I have written are just some basic concepts of using SOAP with Ruby. But it's really simple right? For further reading, please refer to the <a href="http://www.ruby-doc.org/stdlib/libdoc/soap/rdoc/index.html" target="_blank">RubyDoc</a>, or the <a href="http://dev.ctor.org/soap4r" target="_blank">Trac</a> (which has some great examples too). 

For a <a href="http://github.com/keita/ruby-xurrency/tree/master" target="_blank">rubygem that wraps Xurrency's API</a>, there's one on <a href="http://www.github.com" target="_blank">GitHub</a>, authored by Keita. Alternatively, my colleague <a href="http://www.practicalguile.com/" target="_blank">Douglas</a> has also created a <a href="http://github.com/bianster/currency-convertor/tree/master" target="_blank">simple currency converter which uses the data from Yahoo Finance</a>.
