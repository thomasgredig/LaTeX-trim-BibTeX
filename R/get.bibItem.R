# returns an item from the bib file
get.bibItem <- function(bibItemName, item.list) {
  lapply(item.list,
         function(x) {
           q1 = grep("=",x)
           n1 = grep(bibItemName, trimws(unlist(lapply(strsplit(x[q1],"="),'[[',1))))
           if(length(n1)==0) { 
             ""
           } else  { 
             # convert "" to brackets {}
             gsub('=.*?\\"',"={",x[q1[n1[1]]]) -> q2
             gsub('\\",','},',q2) -> q2
             # only get the part from the {}
             # sometimes there are multiple lines for authors, so terminate with }
             gsub('[\\"\\{\\}]','',str_extract(paste0(q2,'}'), '\\{(.*)\\}'))
           }
         })
}

#gsub('=.*?\\"?',"={","  title = {Interferenz von {{R{\\\"o}ntgenstrahlen}} an D{\\\"u}nnen {{Schichten}}},") 
