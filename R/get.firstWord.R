get.firstWord <- function(word.list) {
  # returns the first word always
  w = unlist(lapply(str_split(word.list,' '),'[[',1))
  gsub("\\'",'',iconv(w, to='ASCII//TRANSLIT'))
}