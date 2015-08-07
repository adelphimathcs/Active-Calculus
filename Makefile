
BOOK_FILE_NAME = captain_z
TEMP_DIR = out

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

PDF_BUILDER = pandoc
PDF_BUILDER_FLAGS = \
	--latex-engine xelatex \
	--template ../_layouts/pdf-template.tex \
	--listings

EPUB_BUILDER = pandoc
EPUB_BUILDER_FLAGS = \
	--epub-cover-image

MOBI_BUILDER = kindlegen

combine:
	mkdir -p $(TEMP_DIR)
	cat _posts/*.md | tools/remove_header.rb > $(TEMP_DIR)/$(BOOK_FILE_NAME).md
	cp -r img/ ${TEMP_DIR}/img
	cp _layouts/metadata.xml $(TEMP_DIR)/

add_titles: combine
	cat $(TEMP_DIR)/$(BOOK_FILE_NAME).md | tools/add_titles.rb > $(TEMP_DIR)/$(BOOK_FILE_NAME).ebook.md

tex: combine
	cd $(TEMP_DIR) && $(PDF_BUILDER) $(PDF_BUILDER_FLAGS) $(BOOK_FILE_NAME).md -o $(BOOK_FILE_NAME).tex

pdf: combine
	cd $(TEMP_DIR) && $(PDF_BUILDER) $(PDF_BUILDER_FLAGS) $(BOOK_FILE_NAME).md -o $(BOOK_FILE_NAME).pdf

epub: add_titles
	# --epub-stylesheet=stylesheet.css --toc --toc-depth=1
	cd $(TEMP_DIR) && $(EPUB_BUILDER) $(EPUB_BUILDER_FLAGS) img/epub_title.png  --epub-metadata=metadata.xml  $(BOOK_FILE_NAME).ebook.md -o $(BOOK_FILE_NAME).epub

mobi: epub
	cd $(TEMP_DIR) && $(MOBI_BUILDER) $(BOOK_FILE_NAME).epub

clean:
	rm -f $(BOOK_FILE_NAME).pdf
	rm -rf $(TEMP_DIR)

format_section: 
	cat book/4.1.VelocityDistance.tex | tools/format_section_tex.rb > _posts/2013-08-01-4.1.VelocityDistance.md
	pandoc --template _layouts/sections.md -f latex -t markdown  _posts/2013-08-01-4.1.VelocityDistance.md -o _posts/2013-08-01-4.1.VelocityDistance.md

format_activities:
	cat book/activities/4.1.Act1.tex | tools/format_activities_tex.rb > _includes/activities/4.1.Act1.md
	pandoc -f latex -t markdown  _includes/activities/4.1.Act1.md -o _includes/activities/4.1.Act1.md 
	cat book/activities/4.1.Act2.tex | tools/format_activities_tex.rb > _includes/activities/4.1.Act2.md
	pandoc -f latex -t markdown  _includes/activities/4.1.Act2.md -o _includes/activities/4.1.Act2.md 	
	cat book/activities/4.1.Act3.tex | tools/format_activities_tex.rb > _includes/activities/4.1.Act3.md		
	pandoc -f latex -t markdown  _includes/activities/4.1.Act3.md -o _includes/activities/4.1.Act3.md 	

format_previews:
	cat book/previews/4.1.PA1.tex | tools/format_previews_tex.rb > _includes/previews/4.1.PA1.md
	pandoc -f latex -t markdown  _includes/previews/4.1.PA1.md -o _includes/previews/4.1.PA1.md 		

format_exercises: 
	cat book/exercises/4.1.VelocityDistanceEx.tex | tools/format_exercises_tex.rb > _includes/exercises/4.1.VelocityDistanceEx.md
	pandoc -f latex -t markdown  _includes/exercises/4.1.VelocityDistanceEx.md -o _includes/exercises/4.1.VelocityDistanceEx.md



