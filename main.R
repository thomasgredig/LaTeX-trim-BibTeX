## trims a bibtex file
######################

library(stringr)

######## configuration, overwrite in myConfig.R #########
path.source = '.'
output.file = 'trimmed-bibtex.bib'
#########################################################

# load all functions, except main.R
for(q1 in dir('R', pattern='[^(main)].*\\.R$')) { source(file.path('R',q1)) }

# find the AUX file with the citations
fn = get.AuxFile(path.source)
fn = file.path(path.source, fn)

# extract the citations
citation.list = get.CitationList(fn)
citation.list = tolower(unique(citation.list))

citation.list

# get the bibliography files
bib.list = get.BibliographyList(fn)
bibfile = file.path(path.source,bib.list[1])

# load bibtex file 
d = readLines(bibfile)
d <- str_replace_all(d, "[^[:graph:]]", " ")
from <- which(str_extract(d, "[:graph:]") == "@")
to  <- c(from[-1] - 1, length(d))

# separate all bib items
itemslist <- mapply(
  function(x, y) return(d[x:y]),
  x = from, y = to - 1,
  SIMPLIFY = FALSE
)
print(paste("File contains",length(itemslist),"bib entries."))
# see http://www.bibtex.org/Format/

itemslist = remove.bibItem('abstract',itemslist)
itemslist = remove.bibItem('keywords',itemslist)
itemslist = remove.bibItem('language',itemslist)
itemslist = remove.bibItem('copyright',itemslist)
itemslist = remove.bibItem('file',itemslist)
itemslist = remove.bibItem('doi',itemslist)
itemslist = remove.bibItem('issn',itemslist)

# find all Bibtex Keys
BibTeXKeys <- lapply(itemslist,
                          function(x) {
                            str_extract(x[1], "\\{(.*)?,")
                          }
)
BibTeXKeys <- gsub(',$','',BibTeXKeys)
BibTeXKeys <- tolower(gsub('^\\{','',BibTeXKeys))

# find all types of publications (article, ...)
PublicationType <- lapply(itemslist,
                     function(x) {
                       str_extract(x[1], "[:alpha:]+")
                     }
)

Bib.CitationList <- lapply(citation.list,
            function(x) {
              grep(x, BibTeXKeys)
            })
Bib.CitationList = unlist(Bib.CitationList)



# write new BibTex file that only includes used citations
t1 = unlist(itemslist[Bib.CitationList])
writeLines(t1, output.file)


