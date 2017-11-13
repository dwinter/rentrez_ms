winter.html: winter.Rmd
	Rscript -e "rmarkdown::render('winter.Rmd')"

winter.R: winter.Rmd
	Rscript -e "knitr::purl('winter.Rmd')"

Fig1.pdf: animal_data.csv

clean:
	rm -f RJ*.bbl RJ*.aux RJ*.blg RJ*.brf RJ*.log 	RJ*.out
	rm -f winter_submission.zip

winter.pdf: Fig1.pdf winter.tex
	$(MAKE) clean
	pdflatex RJwrapper.tex
	bibtex RJwrapper
	pdflatex RJwrapper.tex
	pdflatex RJwrapper.tex
	pdflatex RJwrapper.tex
	mv RJwrapper.pdf winter.pdf

rentrez_preprint.pdf: Fig1.pdf winter.tex
	$(MAKE) clean
	pdflatex RJpreprint.tex
	bibtex RJpreprint
	pdflatex RJpreprint.tex
	pdflatex RJpreprint.tex
	pdflatex RJpreprint.tex
	mv RJpreprint.pdf rentrez_preprint.pdf

winter_submission.zip: winter.pdf Fig1.pdf winter.R animal_data.csv
	$(MAKE) clean
	cd ../; zip -r  rentrez_ms/winter_submission.zip rentrez_ms/Fig1.pdf rentrez_ms/animal_data.csv rentrez_ms/winter.bib rentrez_ms/RJournal.sty rentrez_ms/RJwrapper.tex rentrez_ms/winter.tex rentrez_ms/winter.R rentrez_ms/winter.pdf rentrez_ms/make_fig1.r rentrez_ms/tidytaxon/ rentrez_ms/cover_letter.pdf

