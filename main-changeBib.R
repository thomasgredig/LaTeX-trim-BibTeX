# converts a bibliography item name
#

######## configuration, overwrite in myConfig.R #########
path.source = '.'
input.file = 'test.tex'
#########################################################

# load all functions, except main.R
library(stringr)
for(q1 in dir('R', pattern='[^(main)].*\\.R$')) {  source(file.path('R',q1)) }

# find all the bib IDs
filename = file.path(path.source, input.file)
bibIDs = get.AllReferncesFromTeX(filename)
unique(bibIDs)

# load the BIBLIOGRAPHY and match
# -------------------------------
# find the AUX file with the citations
fn = get.AuxFile(path.source)
fn = file.path(path.source, fn)
fn = get.BibliographyList(fn)
fn = global.filePath(path.source,fn)

itemslist = get.BibData(fn[1])
# clean up
# see http://www.bibtex.org/Format/

itemslist = remove.bibItem('abstract',itemslist)
itemslist = remove.bibItem('keywords',itemslist)
itemslist = remove.bibItem('language',itemslist)
itemslist = remove.bibItem('copyright',itemslist)
itemslist = remove.bibItem('file',itemslist)
itemslist = remove.bibItem('doi',itemslist)
itemslist = remove.bibItem('issn',itemslist)

# guess new Bib ID
years = gsub('\\D','',unlist(get.bibItem('year',itemslist)))
author.lastname = get.bibLastname(unlist(get.bibItem('author',itemslist)))
titles = get.firstWord(get.bibItem('title',itemslist))

paste(author.lastname, titles, years, sep='_')
