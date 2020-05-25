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
d$zip = as.character(gsub('.*[- ](\\d{3,5}).*','\\1',d$name))
length(which(is.na(d$zip)==TRUE))
d[which(is.na(d$zip)==TRUE),]
d$state = gsub('.*([A-Z]{2})\\s{1}\\d{5}.*','\\1',d$name)
d$state[which(nchar(d$state)>2)]=''


# now find all the latitudes and longitudes
k1 = which(d$country=='USA')
zips = d$zip[k1]
d$lat = NA
d$lng = NA
d$city = NA
for(zp in unique(zips)) {
  m = GNpostalCodeSearch(postalcode=zp,country="USA")
  k2 = which(d$zip==zp)
  d$lat[k2] = m$lat
  d$lng[k2] = m$lng
  d$city[k2] = m$placeName
}

write.csv(d, file='~/Downloads/univ.csv', row.names = FALSE)
