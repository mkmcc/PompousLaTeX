.PHONY: all tiles grids pdfs images clean

# Directories
CARDDIR := card
PDFDIR := pdf

# Step 0: Detect all .tex files in card/
TEX_FILES := $(wildcard $(CARDDIR)/*.tex)
PDF_FILES := $(patsubst $(CARDDIR)/%.tex,$(PDFDIR)/%.pdf,$(TEX_FILES))

# Main build target
all: images

# Step 1: Run Ruby scripts
tiles:
	ruby test-tiles.rb

grids:
	ruby test-grids.rb

# Step 2: Build all PDFs
pdfs: tiles grids $(PDF_FILES)

$(PDFDIR)/%.pdf: $(CARDDIR)/%.tex
	cd $(CARDDIR) && pdflatex $(notdir $<)
	cp $(CARDDIR)/$(notdir $@) $(PDFDIR)/

# Step 3: Convert to PNGs
images: pdfs
	cd $(PDFDIR) && ruby convert.rb

# Clean intermediate files
clean:
	cd $(CARDDIR) && rm -f *.aux *.log *.out *.toc *.pdf
	cd $(PDFDIR) && rm -f *.tmp.png *.pdf *.png
	rm -f png/*.png
