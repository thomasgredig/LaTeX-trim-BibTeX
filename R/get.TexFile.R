# returns a list of AUX files
get.TexFile <- function(pfad) {
  tex.list = dir(pfad, pattern = '\\.tex$', recursive = TRUE)
  if (length(tex.list)==0) {
    warning('TEX files not found.')
  }
  tex.list
}