#!/usr/bin/env Rscript
library(treemap)
library(grid)
library(gridExtra)

make_title <- function(col_name, data){
    n <- sum(data[,col_name])
    with_commas <- formatC(n, format = "d", big.mark = ",")
    paste0(col_name, " (n = ", with_commas, ")")
}

# Generate a treemap from taxonmic data.frame
# * data= tidy_taxonomy data.frame
# * size_col = name of column for tm tile-size
# * fill_col = name of column for tile-fil
# * row = plot row in 2x2 grid
# * col = plot col in 2x2 grid
# * pal = palette for fill
taxic_diversity_tm <- function(data, size_col, fill_col, row, col, pal){    
    treemap(data, 
        index=c("phylum", "class", "order"), vSize=size_col, vColor=fill_col, 
        palette=pal, type='categorical', position.legend="none", 
        title=make_title(size_col, data), border.col=c("white","white","black"),
        vp = viewport(layout.pos.row = row, layout.pos.col = col)
    )
}

main <- function(){
    animal_orders <- read.csv("animal_data.csv", stringsAsFactors=FALSE)
    # 24 phyla means some fill-colours will be re-used, ordering phylum factor by spp
    # will prevent any "major" phyla from getting the same colour.
    spp_per_phylum <- aggregate(species ~ phylum, FUN=sum, data=animal_orders)
    phyla_ordered <- spp_per_phylum$phylum[ order(spp_per_phylum$species, decreasing=TRUE)]
    animal_orders$phylum <- factor(animal_orders$phylum, levels=phyla_ordered)
    pal   <-  rep(RColorBrewer::brewer.pal(8, name="Set1"), 3)

    pdf("Fig1.pdf", width=10, height=10)
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(2, 2)))
    taxic_diversity_tm(animal_orders, "species",   "phylum", 1,1, pal)
    taxic_diversity_tm(animal_orders, "papers",    "phylum", 1,2, pal)
    taxic_diversity_tm(animal_orders, "sequences", "phylum", 2,1, pal)
    taxic_diversity_tm(animal_orders, "genomes",   "phylum", 2,2, pal)
    dev.off()
}

if( !interactive() ){
    main() == 1
}
