# converts a bibliography item name into a new format
#

######## configuration, overwrite in myConfig.R #########
path.source = '.'
input.file = 'test.tex'
#########################################################

# load all functions, except main.R
library(stringr)
for(q1 in dir('R', pattern='[^(main)].*\\.R$')) {  source(file.path('R',q1)) }

# find all the bib IDs
filename = file.path(path.source, input.file)  # CHANGE: need to change this to get.TexFile()
bibIDs = get.AllReferncesFromTeX(filename)
unique(bibIDs)

# load the BIBLIOGRAPHY and match
# -------------------------------
# find the AUX file with the citations
fn = get.AuxFile(path.source)
fn = file.path(path.source, fn)
fn = get.BibliographyList(fn)
fn = global.filePath(path.source,fn)

itemslist = get.BibData(fn[2])  # CHANGE: loop through all
# clean up
# see http://www.bibtex.org/Format/

itemslist = remove.bibItem('abstract',itemslist)
itemslist = remove.bibItem('keywords',itemslist)
itemslist = remove.bibItem('language',itemslist)
itemslist = remove.bibItem('copyright',itemslist)
itemslist = remove.bibItem('file',itemslist)
itemslist = remove.bibItem('doi',itemslist)
itemslist = remove.bibItem('issn',itemslist)

# guess new Bib Key
years = gsub('\\D','',unlist(get.bibItem('year',itemslist)))
author.lastname = get.bibLastname(unlist(get.bibItem('author',itemslist)))
titles = get.firstWord(get.bibItem('title',itemslist))

# these are the desired looking bib Keys
new.bibIDs = paste(author.lastname, titles, years, sep='_')
new.bibIDs = gsub("[^[:graph:]]",'',new.bibIDs)  # remove umlaute
new.bibIDs = gsub('[\\(\\)\\.]','',new.bibIDs)  
new.bibIDs

ID = 27
itemslist[ID] -> i7
get.bibItem('title',i7)
get.firstWord(unlist(get.bibItem('title',i7)))

# these are the bib Keys from the file.
# get.bibKey(itemslist[12])
# get.bibItem('title',itemslist[12]) -> m
# m
# unlist(lapply(str_split(m,' '),'[[',1))
# get.bibLastname(m)

old.bibIDs = unlist(get.bibKey(itemslist))
old.bibIDs

d = data.frame(
  oldKeys = old.bibIDs,
  newKeys = new.bibIDs,
  equal = (tolower(old.bibIDs) == tolower(new.bibIDs))
)
d1 = subset(d, equal==FALSE)
head(d1,n=15)
write.csv(d, file.path(path.source,'bib-key-conversion.csv'))
