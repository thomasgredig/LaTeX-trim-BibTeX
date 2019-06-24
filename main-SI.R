# main-SI

# converts 54~nm into \SI{54}{nm}
# also creates a log file


######## configuration, overwrite in myConfig.R #########
path.source = '.'
output.logfile = 'log.txt'
#########################################################

# load all functions, except main.R
for(q1 in dir('R', pattern='[^(main)].*\\.R$')) { source(file.path('R',q1)) }

tex.fileList = get.TexFile(path.source)

filename = file.path(path.source, tex.fileList[10])
convert.Units(filename, 't.tex')