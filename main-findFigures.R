############################################################
# (c) 2019 Thomas Gredig
# finds all figures / images in all TEX files of a folder
#
# configure path.source in myConfig.R
#
############################################################


######## configuration, overwrite in myConfig.R #########
path.source = '.'
OUTPUT.IMAGE = 'figure-summary.csv'
OUTPUT.IMAGE2 = 'figure-summary2.csv'
#########################################################

# load all functions, except main.R
library(stringr)
for(q1 in dir('R', pattern='[^(main)].*\\.R$')) {  source(file.path('R',q1)) }

# find all the TeX files
filelist.tex = get.TexFile(path.source)
path.source
r=NULL
paths=NULL

# find all images in all TeX files
for(f in filelist.tex) {
  filename = file.path(path.source, f)
  d = readLines(filename)
  # find all images with includegraphics
  n = grep('\\\\includegraphics',d)  
  if(length(n) > 0) {
    gsub('.*\\\\includ.*\\{(.*?)\\}.*','\\1',d[n]) -> r1
    r2 = data.frame(image = r1, stringsAsFactors = FALSE)
    r2$filename = filename
    r = rbind(r, r2)
  }
  
  # find all the paths for images (there should only be one!)
  n = grep('graphicspath',d)
  if (length(n) > 0) { 
    if ((length(n) > 1) | (!is.null(paths))) { warning("Too many Graphicspath found.") }
    paths = gsub('\\{','',unlist(strsplit(gsub('\\\\graphicspath\\{(.*)\\}','\\1',d[n]),'\\}'))) 
  }
}

# add local path as possibilty
paths=c('',paths)

# find duplicates of images
r$duplicated = duplicated(r$image)

# find correct location for each image
r$filesize = 0
r$date = ""
r$location = ""
for(j in 1:nrow(r)) {
  locs = find.imageFile(path.source, paths,r$image[j])
  if (length(locs)==0) {
    print(paste("Not found: ",r$image[j]))
  } else {
    r$location[j] = locs[1]
    if (length(locs)>1) {
      warning(paste('Several files found:',locs))
    }
    r$filesize[j] = file.info(locs[1])$size
    r$date[j] = as.character(as.Date(file.info(locs[1])$mtime))
  }
}

# save results
write.csv(r, file = file.path(path.source, OUTPUT.IMAGE))

print(paste("Found",nrow(r),"figures in",length(filelist.tex),"TeX files."))
print(paste("Output is saved in file: ",file.path(path.source, OUTPUT.IMAGE)))

# find all the R files
filelist.R = dir(path.source, pattern = '\\.[rR]$', recursive = TRUE)
path.source = '/Users/gredigcsulb/Dropbox/Research-Nguyen'
gsub('\\"','',r$image)


file.ggsave = c()
file.source = c()
for(f in filelist.R) {
  d = readLines(file.path(path.source,f))
  n = grep('ggsave', gsub('(.*)\\#.*','\\1',d))
  if (length(n)>0) {
    # get first parameter of ggsave
    s = gsub('.*ggsave\\((.*)\\)','\\1',d[n])
    for(s1 in s) {
      g = gsub('\\"','',getCommaSepArgs(s1)[[1]])
      if(length(g)>0) {
      file.source = c(file.source,f)
      file.ggsave = c(file.ggsave, g)
      } else {print(s1)}
    }
  }
}

r1 = data.frame(
  filename = file.source,
  image = file.ggsave
)
write.csv(r1, file = file.path(path.source, OUTPUT.IMAGE2))
print(file.path(path.source, OUTPUT.IMAGE2))
