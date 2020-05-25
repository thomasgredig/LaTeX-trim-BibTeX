######################
# finds affiliations from
# bibtext file
#
# Author: Thomas Gredig
# Date: 2020-May-24
######################

source('config.R') # can be overwritten by myConfig.R
file.bibtex = '~/Downloads/test.bib'

# load the file with the full BibTeX record:
bibs = get.BibData(file.bibtex)
print(paste('Found ',length(bibs),'bibliography items.'))

# extract all the keys from each bib item
n = lapply(bibs, FUN = get.KeyItemList)
sapply(n, nrow)

# get the affiliations for each entry
n1 = sapply(n, FUN=function(x) { x[which(x$name=='Affiliation'),'item'] })
n1 = as.character(levels(n1)[n1])
# some papers have several affiliations, so split
n2 = strsplit(n1,'\\s{4}')
# there may be several authors with the same affiliation, only keep last author + affiliation
n3 = lapply(n2, function(x) { sapply(strsplit(x, ';') ,tail,1) })
# remove last author, and only get affiliation
univ.list = lapply(n3, function(x) { gsub('.*?,.*?,\\s*?(.*)','\\1',x) } )
write.csv(unlist(univ.list), file='univ.csv', row.names = FALSE)


