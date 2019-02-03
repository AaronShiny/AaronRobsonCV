.PHONY: all build clean

.DEFAULT_GOAL := all
all: build

build: *.pdf

%.pdf: %.tex
ifneq (, $(shell which pdflatex))
	@echo Build locally.
	pdflatex -interaction=nonstopmode -halt-on-error $<
else
	@echo Build using Docker image.
	docker run --rm -i --user="$(id -u):$(id -g)" --net=none \
		-v $(PWD):/data \
		blang/latex:ctanbasic \
		pdflatex $<
endif

clean:
	rm -f *.log *.dvi *.synctex.gz *.pdf
