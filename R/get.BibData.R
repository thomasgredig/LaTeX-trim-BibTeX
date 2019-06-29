get.BibData <- function(bibfile) {
  d = readLines(bibfile)
  d <- str_replace_all(d, "[^[:graph:]]", " ")
  from <- which(str_extract(d, "[:graph:]") == "@")
  to  <- c(from[-1] - 1, length(d))
  
  # separate all bib items
  itemslist <- mapply(
    function(x, y) return(d[x:y]),
    x = from, y = to - 1,
    SIMPLIFY = FALSE
  )
  itemslist
}