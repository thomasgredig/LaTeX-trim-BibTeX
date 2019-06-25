# find all units
convert.Units <- function(filename, out.filename) {
  if(file.exists(filename)) {
      d = readLines(filename)
      q1 = grep('\\d+~\\w+', d)
      if(length(q1)>0) {
        # find 1.2~nm
        d1 =  gsub('(\\d*\\.\\d+)~(\\w+)','\\\\SIa{\\1}{\\2}',d)
        # find 190~nm
        d2 =  gsub('(\\d+)~(\\w+)','\\\\SIa{\\1}{\\2}',d1)
        writeLines(d2, out.filename)
      }
  }
}


a = 'bla bla 1.77~eV and 23~nm bla bla'
gsub('(\\d*\\.\\d+)~(\\w+)','\\\\SIa{\\1}{\\2}',a)
