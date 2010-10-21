# ApplicationController.rb
# WebKitTest
#
# Created by Larry Staton Jr. on 10/20/10.
# Copyright 2010 Sweetpea Software. All rights reserved.

require "Cat"

class ApplicationController < NSObject

	attr_accessor :window, :webView
	
	def applicationDidFinishLaunching(notification)
		NSLog("Application did finish launching")
		page_url = NSURL.URLWithString('http://jquery.com')
		@webView.mainFrame.loadRequest(NSURLRequest.requestWithURL(page_url))
		@window.orderFrontRegardless
	end
	
	# WebView delegate methods
	def webView(view, didFinishLoadForFrame:frame)
		NSLog("Finished loading frame")
		@kitty = Cat.new("Moose", 12)
		jsc = view.windowScriptObject
		
		# Call JavaScript from MacRuby
		# Using jQuery (we're on their page)
		puts jsc.evaluateWebScript("$('#jq-intro > h2').text()")
		jsc.evaluateWebScript("$('#jq-intro > h2').css('color', 'yellow')")
		
		# Call Ruby from JavaScript
		# Set the JavaScript variable "animal" to our Cat instance
		jsc.setValue(@kitty, forKey: "animal")
		# Tell JavaScript that our Cat instance responds to age method
		# No colon at end of selector because no arguments
		@kitty.respondsToSelector("age")
		# Call the age method on our Cat instance from JavaScript
		puts jsc.evaluateWebScript("animal.age()")
		# Execute Ruby code from the DOM
		jsc.evaluateWebScript("$('#jq-intro > h2').append(animal.age())")
	end
end