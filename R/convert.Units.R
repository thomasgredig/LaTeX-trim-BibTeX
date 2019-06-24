# find all units
convert.Units <- function(filename, out.filename) {
  if(file.exists(filename)) {
      d = readLines(filename)
      d1 =  gsub('(\\d+)~(\\w+)','\\\\SI{\\1}{\\2}',d)
      writeLines(d1, out.filename)
  }
}