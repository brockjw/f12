#!/usr/bin/ruby
# Design:
# (1) Accept STDIN as hash in JSon or XMLformat
# (2) Convert the JSon or XML format hash to a ruby hash
# (3) Create html to display the information in the hash
# (4) Return an html as string through STDOUT

require 'rubygems'
require 'json'
require 'xmlsimple'

#input = File.read('../test/tricky.xml') # For debugging
input = STDIN.gets

if input == nil || input == ""
  STDOUT.puts("")
  exit
end

content_headers = input.split("\n\n")[0]

begin
  ruby_hash = JSON.parse(input.split("\n\n")[1]).sort
rescue
  begin
    ruby_hash = XmlSimple.xml_in(input).sort
  rescue  
    raise "Input not in application/json or text/xml format."
  end
end

class String
  def to_html
    self
  end
end

class Object
  def to_html
    self.to_s
  end
end

class Hash
  def to_html
    self.sort.inject("") { |r,e| 
      r += "<h3>#{e[0]}:</h3>" + '<ul style="line-height: 0em">' + "&nbsp" + e[1].to_html + "</ul>"
    }
  end
end

class Array
  def to_html
    if self[1].class == Array
      Hash[self].to_html
    else
      self.inject("") { |r,e|
        r += "<li>" + e.to_html + "</li>"
      }
    end
  end
end


STDOUT.puts( content_headers.split("\n").inject(""){|r,e| r += "#{e}<br>"} + ruby_hash.to_html )
