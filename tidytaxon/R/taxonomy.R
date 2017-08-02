# parse out the taxonmic rank of a given Taxon element in an NCBI Taxonomy XML 
# (used in tidy_taxonomy)
get_taxon <- function(rec, rank){
  xp  <-paste0("LineageEx/Taxon/Rank[.='", rank,"']/../ScientificName")
  res <- xpathSApply(rec, xp, xmlValue)
  if(is.null(res)){
    return(NA)
  }
  res
}

# parse out the parents of a given rank from a taxonomic names of parental
# elements in an NCBI taxonmy XML recor
# (used in tidy_taxonomy)
extract_parents <- function(rec, child_rank, parents=c("phylum", "class")){
  res <- structure(lapply(parents,get_taxon, rec=rec), .Names=parents)
  res[[child_rank]] <- xpathSApply(rec, "ScientificName", xmlValue)
  res
}

#' Produce a tidydata summary of a taxomic group
#'@export
#'@import rentrez
#'@importFrom XML xpathSApply
#'@importFrom XML xmlValue
#'@param lowest_rank Character, name of the lowest taxonomic rank to be included in the data.frame
#'@param higher_ranks Character, taxonomic ranks between "taxon_rank" and subtree
#'@param subtree character, subtree from which to extract names
#'@return a data.frame containing a summary of the given taxonmic data in 'tidy'
#' format.
#'@examples
#'ape_taxonomy <- taxon_df(subtree="apes", lowest_rank="species", higher_ranks= c("family", "genus"))

tidy_taxonomy <- function(subtree,lowest_rank, higher_ranks){
  taxon_s <- entrez_search(db="taxonomy",
                           term= paste0(subtree, "[SBTR] AND ", lowest_rank, " [RANK]"),
                           use_history=TRUE)
  tax_recs <- entrez_fetch(db="taxonomy", web_history=taxon_s$web_history, rettype="xml", parsed=TRUE)
  contents <- lapply(tax_recs["/TaxaSet/Taxon"], extract_parents, parents=higher_ranks, child_rank=lowest_rank)
  tax_df <- do.call(rbind.data.frame, c(stringsAsFactors=FALSE, contents))
  tax_df
}
