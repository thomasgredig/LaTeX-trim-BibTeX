# searchs all paths for files and returns if image is
# found in one of the paths or needs to attach an extension
# pfad = relative path added to all
find.imageFile <- function(pfad, paths, imagefile) {
  imagefile = file.path(pfad, paths, imagefile)
  #imagefile = file.path( path.source, paths, r$image[25])
  imagefile = gsub('\\"','',imagefile)
  imagefile=c(imagefile,paste0(imagefile,'.png'),paste0(imagefile,'.jpg'))
  imagefile[which(file.exists(imagefile)==TRUE)]
}