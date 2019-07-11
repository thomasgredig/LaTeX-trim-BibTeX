get.bibLastname <- function(lastnames) {
  # returns the last name of the first author
  ln = unlist(lapply(str_split(lastnames,' '),'[[',1))
  ln2 = gsub('[,\\.]','',ln)

  gsub("[\\~\\']",'',iconv(ln2, to='ASCII//TRANSLIT'))
}
