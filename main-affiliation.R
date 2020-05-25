######################
# finds affiliations from
# bibtext file
#
# Author: Thomas Gredig
# Date: 2020-May-24
######################

source('config.R')
file.bibtex = '~/Downloads/test.bib'

# load all the citations
bibs = get.BibData(file.bibtex)
print(paste('Found ',length(bibs),'bibliography items.'))

# parse one bib item
# q = bibs[[3]]
# q = get.KeyItemList(bibs[[3]])
# head(q)
# q[which(q$name=='Affiliation'),]

n = lapply(bibs, FUN = get.KeyItemList)
sapply(n, nrow)

d = n[[1]]
n1 = sapply(n, FUN=function(x) { x[which(x$name=='Affiliation'),'item'] })
n1 = as.character(levels(n1)[n1])
n2 = strsplit(n1,';')
n2[[1]]
