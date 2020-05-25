# configuration
###############

library(stringr)
######## configuration, overwrite in myConfig.R #########
path.source = '.'
output.file = 'trimmed-bibtex.bib'
#########################################################

# load all functions, except main.R
for(q1 in dir('R', pattern='[^(main)].*\\.R$')) { source(file.path('R',q1)) }
