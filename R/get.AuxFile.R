get.AuxFile <- function(pfad) {
  dir(pfad, pattern = 'n\\.aux$')[1]
}