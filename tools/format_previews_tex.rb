#!/usr/bin/env ruby

# print all the lines in every file passed via command line that contains login
ARGF.each do |line|
  next if line.start_with? '%'

  if line =~ /(\\begin\{pa\} \\label\{.*\})/
    line.gsub!(line,  $1 + "\n\n" )
  end

  # includes input files
  if line =~ /\\input\{(.*)\}/
#    text = File.read("book/"+$1+ ".tex")
    line.gsub!(line, "\\{\\% include " + $1 + ".md \\%\\}" )
  end

#  if line =~ /\\input\{(.*)\}/
#    text = File.read("book/"+$1+ ".tex")
#    line.gsub!(line, text )
#  end  

  # Creates Motivating Question environment
#  if line =~ /\\framebox\{\\hspace\*\{3 pt\}/ 
#    line.gsub!(line, "\\{\\% include motivating-quest-top.md \\%\\}" )
#  end
#  if line =~ /\\end\{goals\}\} \\hspace\*\{3 pt\}\}/
#    line.gsub!(line, "\\end{itemize}\n\\{\\% include motivating-quest-bot.md \\%\\}" )    
#  end

  # Creates itemize environment
  if line =~ /\\parbox\{\\boxwidth\}\{\\begin\{goals\}/
    line.gsub!(line, "\\begin{itemize}" )
  end   

  # Creates enumerate environment
  if line["\\ba"]
  	line.gsub!(line["\\ba"], "\\begin{enumerate}" )
  end   
  if line["\\ea"]
  	line.gsub!(line["\\ea"], "\\end{enumerate}" )
  end     

  if line["\$\$"]
    line.gsub!( line["\$\$"], "\n\n\$\$\n\n")
  end  


  puts line
end

