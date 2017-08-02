#' Count number of records from each fo a set of taxa in an NCBI database.
#'
#' Note: This function follows the NCBI's terms of use, meaning at most 
#' three taxa can be processed per second. 
#'
#'@export
#'@import rentrez
#'@param taxoa  Character, names of the taxa to gather information on.
#'@param db Character, NCBI database from which to gather data.
#'@param additional_terms Character, additional term to add to each search
#'@return A numeric vector that contains the number of records
#' matching the criteria
#'@examples
#' taxon_records(taxon_name="Plasmodium", db="genome")



taxon_records <- function(taxa, db, additional_terms = NULL){
  vapply(taxa, .taxon_records_one, 0.0, db=db, additional_terms=additional_terms)
}

.taxon_records_one <- function(taxon_name, db, additional_terms = NULL){
    q <- paste0(taxon_name, "[ORGN]")
    if(!is.null(additional_terms)){
        q <- paste(q,additional_terms)
    }
    as.numeric(entrez_search(db=db, term=q)$count)
}

#' Count number of child taxa of a given rank for a patricular taxon.
#'
#' Note: This function follows the NCBI's terms of use, meaning at most 
#' three taxa can be processed per second. 
#'
#'@export
#'@import rentrez
#'@param taxa Character, name of the taxa to gather information on.
#'@param child_rank character, taxonomic rank of child taxon to count (defaults
#'to species)
#'@return A numeric vector that contains the number of child taxa of the given 
#' rank for each provided parent taxon.
#'@examples
#' taxon_children(taxon_name="Plasmodium")


taxon_children <- function(taxa, child_rank="species"){
    vapply(taxa, .taxon_children_one, 0.0, child_rank=child_rank)
}

.taxon_children_one <- function(taxon_name, child_rank){
  q <- paste0(taxon_name, "[SBTR] AND ", child_rank, "[RANK]")
  as.numeric(entrez_search(db="taxonomy", term=q)$count)
}

