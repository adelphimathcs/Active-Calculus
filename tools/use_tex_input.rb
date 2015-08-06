#!/usr/bin/env ruby

# print all the lines in every file passed via command line that contains login
sep_count = 0
ARGF.each do |line|
  if line =~ /\\input\{(.*)\}/
  	text = File.read("book/"+$1+ ".tex")
    line.gsub!(line, text )
  end

  if line =~ /\\framebox\{\\hspace\*\{3 pt\}/ 
    line.gsub!(line, "\\{\\% include motivating-quest-top.md \\%\\}" )
  end

  if line =~ /\\parbox\{\\boxwidth\}\{\\begin\{goals\}/
    line.gsub!(line, "\\begin{itemize}" )
  end   

  if line =~ /\\end\{goals\}\} \\hspace\*\{3 pt\}\}/
    line.gsub!(line, "\\end{itemize}\n\\{\\% include motivating-quest-bot.md \\%\\}" )    
  end

  if line["\\ba"]
  	line.gsub!(line["\\ba"], "\\begin{enumerate}" )
  end   

  if line["\\ea"]
  	line.gsub!(line["\\ea"], "\\end{enumerate}" )
  end     

#  if line["\\item"]
#    line.gsub!( line["\\item"], "* ")
#  end  

  puts line
end

