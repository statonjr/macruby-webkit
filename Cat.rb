# Cat.rb
# WebKitTest
#
# Created by Larry Staton Jr. on 10/20/10.
# Copyright 2010 Sweetpea Software. All rights reserved.

class Cat < NSObject

	attr_accessor :name, :age
	
	def initialize(name="Willie", age=42)
		@name = name
		@age = age
	end
	
	# Make all the Cat's methods available from JavaScript
	def self.isSelectorExcludedFromWebScript(sel); false end

end
