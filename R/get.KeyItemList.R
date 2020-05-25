get.KeyItemList <- function(bibData) {
  q2 = paste(bibData, collapse=" ")
  str_split_fixed(q2, '.*\\{.*\\}',1)
  q3 = str_extract_all(q2, '(?<=\\{).*(?=\\})')[[1]]
  
  p2 = str_extract_all(paste0(q3,','), '\\{{1,2}.*?\\}{1,2},')[[1]]
  p2 = gsub('\\{','',p2)
  p2 = gsub('\\}{1,2},','',p2)
  
  p1 = str_extract_all(q3, ',\\s{0,2}[a-zA-Z0-9-]+\\s{0,2}\\=')[[1]]
  p1 = gsub('\\s+\\=$','',p1)
  p1 = gsub('^,\\s+','',p1)
  
  if (length(p1) == length(p2)) {
    d = data.frame(
      name = p1,
      item = p2
    )
  } else { d = data.frame() }
  d
}