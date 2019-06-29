# main-SI

# converts 54~nm into \SI{54}{nm}
# also creates a log file


######## configuration, overwrite in myConfig.R #########
path.source = '.'
output.logfile = 'log.txt'
#########################################################

# load all functions, except main.R
for(q1 in dir('R', pattern='[^(main)].*\\.R$')) { source(file.path('R',q1)) }

# get list of files to convert
tex.fileList = get.TexFile(path.source)

# convert and save new files
for(fname in tex.fileList) {
  filename = file.path(path.source, fname)
  no = convert.Units(filename, gsub('.tex','-new.tex', filename))
  print(paste(no,"units converted in file:",filename))
}