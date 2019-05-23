get.CitationList <- function(filename) {
  d = read.table(filename, stringsAsFactors = FALSE, header=FALSE)
  n = grep('citation',d$V1)
  l = gsub('\\\\citation\\{','',d$V1[n])
  gsub('\\}$','',l)
}