# search the AUX files for a bibdata file
get.BibliographyList <- function(file.list) {
  bib.list = c()
  for(filename in file.list) {
    d = readLines(filename)
    n = grep('bibdata',d)
    l = gsub('\\\\bibdata\\{','',d[n])
    l = gsub('\\}$','',l)
    if(length(l)>0) {
      # remove bib extension, if it has it
      l = gsub('\\.bib$','',l)
      bib.list = c(bib.list, paste0(l,'.bib'))
    }
  }
  if (length(bib.list)<1) {
    warning("No bibliography file in aux file found.")
  }
  bib.list
}
