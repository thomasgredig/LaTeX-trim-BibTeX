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
  q1 = grep(',',cit.list)
  if(length(q1)>0) { # separate comma-separated items
    cit.list=c(cit.list[-q1],unlist(strsplit(cit.list[q1],',')))
  }
  cit.list
  # unique(cit.list) # this is too slow
}