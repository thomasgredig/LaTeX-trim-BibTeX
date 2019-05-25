# load all the citations in the list of files
get.CitationList <- function(file.list) {
  cit.list = c()
  for(filename in file.list) {
    if(file.exists(filename)) {
      #d = read.table(filename, stringsAsFactors = FALSE, header=FALSE)
      d = readLines(filename)
      n = grep('citation',d)
      l = gsub('\\\\citation\\{','',d[n])
      cit.list = c(cit.list, gsub('\\}$','',l))
    }
  }
  cit.list
}