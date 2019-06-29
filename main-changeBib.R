# converts a bibliography item name
#

######## configuration, overwrite in myConfig.R #########
path.source = '.'
input.file = 'test.tex'
#########################################################

# load all functions, except main.R
library(stringr)
for(q1 in dir('R', pattern='[^(main)].*\\.R$')) {  source(file.path('R',q1)) }

filename = file.path(path.source, input.file)
bibIDs = get.AllReferncesFromTeX(filename)

# find the AUX file with the citations
fn = get.AuxFile(path.source)
fn = file.path(path.source, fn)
get.BibliographyList(fn)

unique(bibIDs)

get.BibData(fn[1])