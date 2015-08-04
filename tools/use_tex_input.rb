#!/usr/bin/env ruby

# print all the lines in every file passed via command line that contains login
sep_count = 0
ARGF.each do |line|
  if line =~ /\\input\{(.*)\}/
  	text = File.read("book/"+$1+ ".tex")
    line.gsub!(line, text )
  end
  puts line
end

