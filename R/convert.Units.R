# find all units
convert.Units <- function(filename, out.filename) {
  if(file.exists(filename)) {
      d = readLines(filename)
      q1 = grep('\\d+~\\w+', d)
      if(length(q1)>0) {
        d1 =  gsub('(\\d+)~(\\w+)','\\\\SI2{\\1}{\\2}',d)
        writeLines(d1, out.filename)
      }
  }
}