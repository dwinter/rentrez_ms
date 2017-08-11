winter.html: winter.Rmd
	Rscript -e "rmarkdown::render('winter.Rmd')"

Fig1.pdf: animal_data.csv
	./make_fig1.r

winter.pdf: Fig1.pdf winter.tex
	pdflatex RJwrapper.tex
	bibtex RJwrapper
	pdflatex RJwrapper.tex
	pdflatex RJwrapper.tex
	mv RJwrapper.pdf winter.pdf
