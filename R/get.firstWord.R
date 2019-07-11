capitalizeFirstLetter <- function(s) {
  paste(toupper(substr(s, 1,1)), tolower(substring(s, 2)),sep="", collapse=" ")
}

get.firstWord <- function(word.list) {
  gsub("the ","",tolower(word.list)) -> word.list
  gsub("a ","",word.list) -> word.list
  gsub("an ","",word.list) -> word.list
  gsub("as ","",word.list) -> word.list
  gsub("some ","",word.list) -> word.list
  
  # returns the first word always
  w = unlist(lapply(str_split(word.list,' '),'[[',1))
  w = gsub("[,\\'\\:]",'',iconv(w, to='ASCII//TRANSLIT'))
  
 
  # make sure first letter is capitalized, all others are lower case.
  unlist(lapply(w,capitalizeFirstLetter))
}

# get.firstWord(c("Thomas Gredig","Gredig Thomas","WEREW","Thomas-Gredig"))

