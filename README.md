# A manuscript for rentrez (at last!)

This repository contains the code and source files for a manuscript describing 
[rentrez](https://github.com/ropensci/rentrez), an R package for the EUtils API.

## Build the manuscript


Unfortunately a [bug/issue with `pandoc`](https://github.com/jgm/pandoc/issues/2493)
combined with the [particular format of the R Journal style](https://github.com/rstudio/rticles/issues/49)
means it is difficult to create a fully-reproducable document that meets the _R
Journal_ requirements. Rather than hacking something together, I have decided to
make an initial document using Rmarkdown (`winter.Rmd`), compile that document
to standard markdown (`winter.md`) and edit this file to create the a LaTeX 
document for submission. 

So, if you want to check the code runs and play with the examples I give you can
compile a html version of the manuscript text usinh `Make`:

```sh
make winter.html
```

If you want to compile the pdf that will be submitted to the journal you can
instead type (but not now R code is run to produce this file)

```sh
make winter.pdf
```



