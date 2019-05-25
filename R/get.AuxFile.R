# returns a list of AUX files
get.AuxFile <- function(pfad) {
  aux.list = dir(pfad, pattern = '\\.aux$')
  if (length(aux.list)==0) {
    warning('AUX files not found.')
  }
  aux.list
}