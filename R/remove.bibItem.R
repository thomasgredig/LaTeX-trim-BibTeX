# bibItemName is "abstract", "doi", "file", etc.
remove.bibItem <- function(bibItemName, item.list) {
  lapply(item.list,
         function(x) {
           q1 = grep("=",x)
           n1 = grep(bibItemName, trimws(unlist(lapply(strsplit(x[q1],"="),'[[',1))))
           if(length(n1)==0) { x } else  { x[-q1[n1]] }
         })
}
