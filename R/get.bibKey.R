# returns the key from the bibitem:
get.bibKey <- function(item.list) {
  lapply(item.list,
         function(x) {  
           gsub("[^a-z0-9A-Z\\_\\:\\-]",'',str_extract(x[1],'\\{.*'))
         })
}
# gsub('^[a-z]',' [] ','qWer-qwer')

