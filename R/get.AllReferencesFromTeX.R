# returns all BibTex references from a file
get.AllReferncesFromTeX <- function(filename) {
  d = readLines(filename)
  q1 = grep('\\\\cite\\{', d)
  m = str_extract_all(d[q1], regex("\\\\cite\\{[A-Za-z0-9-_,]+\\}"))
  m1 = gsub('\\\\cite\\{','',unlist(m))
  m2 = gsub('\\}','',m1)
  unlist(str_split(m2,','))
}