# returns an item from the bib file
get.bibItem <- function(bibItemName, item.list) {
  lapply(item.list,
         function(x) {
           q1 = grep("=",x)
           n1 = grep(bibItemName, trimws(unlist(lapply(strsplit(x[q1],"="),'[[',1))))
           if(length(n1)==0) { 
             ""
           } else  { 
             # only get the part from the {}
             gsub('[\\"\\{\\}]','',str_extract(x[q1[n1]], '\\{(.*)\\}'))
           }
         })
}