# returns file.list with the path pre-pended,
# only if it is not a global path
global.filePath <- function(path, file.list) {
  q = grep('^/', file.list, perl=TRUE)
  c(file.path(path,file.list[-q]),file.list[q])
}