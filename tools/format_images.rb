
## Guide
#re = / # Match a MARKDOWN CODE section.
#    (\r?\n)              # $1: CODE must be preceded by blank line
#    (                    # $2: CODE contents
#      (?:                # Group for multiple lines of code.
#        (?:\r?\n)+       # Each line preceded by a newline,
#        (?:[ ]{4}|\t).*  # and begins with four spaces or tab.
#      )+                 # One or more CODE lines
#      \r?\n              # CODE folowed by blank line.
#    )                    # End $2: CODE contents
#    (?=\r?\n)            # CODE folowed by blank line.
#    /x
#result = subject.gsub(re, '\1<pre>\2</pre>')

## Match
#![caption_text1 \n
#caption_text2\ 
#...
#caption_textn<span
#data-label="figure_label"></span>](path/to/file.eps)

## Make
# {% include images.md path="path/to/file.png" caption=caption_text1 + ... + caption_textn  label="figure_label" %}


pattern = / # Match a MARKDOWN CODE section.
	!\[
    (  
      (?:  )+ 
      \r?\n              # CODE folowed by blank line.
    )                    # End $2: CODE contents
    (?=\r?\n)            # CODE folowed by blank line.
    /x

