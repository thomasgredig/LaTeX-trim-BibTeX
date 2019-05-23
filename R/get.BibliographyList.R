get.BibliographyList <- function(filename) {
  d = read.table(filename, stringsAsFactors = FALSE, header=FALSE)
  n = grep('bibdata',d$V1)
  l = gsub('\\\\bibdata\\{','',d$V1[n])
  l = gsub('\\}$','',l)
  if (length(l)<1) {
    warning("No bibliography file found")
  }
  # remove bib extension, if it has it
  l = gsub('\\.bib$','',l)
  paste0(l,'.bib')
}