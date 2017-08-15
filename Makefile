winter.html: winter.Rmd
	Rscript -e "rmarkdown::render('winter.Rmd')"

winter.R: winter.Rmd
	Rscript -e "knitr::purl('winter.Rmd')"

Fig1.pdf: animal_data.csv
	./make_fig1.r

winter.pdf: Fig1.pdf winter.tex
	pdflatex RJwrapper.tex
	bibtex RJwrapper
	pdflatex RJwrapper.tex
	pdflatex RJwrapper.tex
	mv RJwrapper.pdf winter.pdf

winter_submission.tar.gz: winter.pdf Fig1.pdf winter.R animal_data.csv
	rm -f winter_submission.tar.gz
	tar -czf winter_submission.tar.gz ../rentrez_ms
