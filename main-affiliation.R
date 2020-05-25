######################
# finds affiliations from
# bibtext file
#
# Author: Thomas Gredig
# Date: 2020-May-24
######################

options(geonamesUsername="enter-username") # overwrite in myConfig.R
source('config.R') # can be overwritten by myConfig.R
file.bibtex = '~/Downloads/test.bib'
library(geonames)
# example: GNpostalCodeSearch(postalcode=32611,country="USA")


# load the file with the full BibTeX record:
bibs = get.BibData(file.bibtex)
print(paste('Found ',length(bibs),'bibliography items.'))

# extract all the keys from each bib item
n = lapply(bibs, FUN = get.KeyItemList)
sapply(n, nrow)
# delete those keys with 0 entries
k1 = which(sapply(n, nrow)==0)
n[[k1]] <- NULL

# get the affiliations for each entry
n1 = sapply(n, FUN=function(x) { x[which(x$name=='Affiliation'),'item'] })
n1 = as.character(levels(n1)[n1])
# some papers have several affiliations, so split
n2 = strsplit(n1,'\\s{4}')
# there may be several authors with the same affiliation, only keep last author + affiliation
n3 = lapply(n2, function(x) { sapply(strsplit(x, ';') ,tail,1) })
# remove last author, and only get affiliation
univ.list = lapply(n3, function(x) { gsub('.*?,.*?,\\s*?(.*)','\\1',x) } )

univ = gsub('^\\s+','',unlist(univ.list))
# univ.us = univ[grep('USA',univ)]
d = data.frame(
  name = univ,
  country = gsub('\\.$','',sapply(strsplit(univ,'\\s'),tail,1))
)
d$zip = gsub('.*[A-Z]{2}\\s{1}(\\d{5}).*','\\1',d$name)
d$state = gsub('.*([A-Z]{2})\\s{1}\\d{5}.*','\\1',d$name)
write.csv(d, file='~/Downloads/univ.csv', row.names = FALSE)
