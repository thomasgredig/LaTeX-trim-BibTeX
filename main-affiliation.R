######################
# finds affiliations from
# bibtext file
#
# Author: Thomas Gredig
# Date: 2020-May-24
######################

#options(geonamesUsername="enter-username") # overwrite in myConfig.R
file.bibtex = '~/Downloads/test.bib'
source('config.R') # can be overwritten by myConfig.R

#library(geonames)
library(ggmap)
require(RCurl)
library(rjson)
# example: GNpostalCodeSearch(postalcode=32611,country="USA")


# load the file with the full BibTeX record:
bibs = get.BibData(file.bibtex)
print(paste('Found ',length(bibs),'bibliography items.'))

# extract all the keys from each bib item
n = lapply(bibs, FUN = get.KeyItemList)
sapply(n, nrow)
# delete those keys with 0 entries
k1 = which(sapply(n, nrow)==0)
n[[k1]] <- NULL

# get the affiliations for each entry
n1 = sapply(n, FUN=function(x) { x[which(x$name=='Affiliation'),'item'] })
n1 = as.character(levels(n1)[n1])
# some papers have several affiliations, so split
n2 = strsplit(n1,'\\s{4}')
# there may be several authors with the same affiliation, only keep last author + affiliation
n3 = lapply(n2, function(x) { sapply(strsplit(x, ';') ,tail,1) })
# remove last author, and only get affiliation
univ.list = lapply(n3, function(x) { gsub('.*?,.*?,\\s*?(.*)','\\1',x) } )

univ = gsub('^\\s+','',unlist(univ.list))
# univ.us = univ[grep('USA',univ)]
d = data.frame(
  name = univ,
  country = gsub('\\.$','',sapply(strsplit(univ,'\\s'),tail,1))
)
d$zip = as.character(gsub('.*[- ](\\d{3,5}).*','\\1',d$name))
length(which(is.na(d$zip)==TRUE))
d[which(is.na(d$zip)==TRUE),]
d$state = gsub('.*([A-Z]{2})\\s{1}\\d{5}.*','\\1',d$name)
d$state[which(nchar(d$state)>2)]=''




# # now find all the latitudes and longitudes
# k1 = which(d$country=='USA')
# zips = d$zip[k1]
# d$lat = NA
# d$lng = NA
# d$city = NA
# for(zp in unique(zips)) {
#   m = GNpostalCodeSearch(postalcode=zp,country="USA")
#   k2 = which(d$zip==zp)
#   d$lat[k2] = m$lat
#   d$lng[k2] = m$lng
#   d$city[k2] = m$placeName
# }
# 
# write.csv(d, file='~/Downloads/univ.csv', row.names = FALSE)


bGeoCode <- function(str, BingMapsKey){
  u <- URLencode(paste0("http://dev.virtualearth.net/REST/v1/Locations?q=", str, "&maxResults=1&key=", BingMapsKey))
  d <- getURL(u)
  j <- fromJSON(d,simplify = FALSE) 
  if (j$resourceSets[[1]]$estimatedTotal > 0) {
    lat <- j$resourceSets[[1]]$resources[[1]]$point$coordinates[[1]]
    lng <- j$resourceSets[[1]]$resources[[1]]$point$coordinates[[2]]
  }
  else {    
    lat <- lng <- NA
  }
  c(lat,lng)
}  

d$name = levels(d$name)[d$name]
d$lng <- d$lat <- NA
for(j in 1:nrow(d)) {
  print(j)
#  mj = bGeoCode(d$name[j], api.bing)
  d$lng[j]=mj[1]
  d$lat[j]=mj[2]
}

# mj = bGeoCode(d$name[1], api.bing)
# write.csv(d,'~/Downloads/OpticalLimiting.csv')

# make a map

d= read.csv('~/Downloads/OpticalLimiting.csv')
d$LON = d$lat
d$LAT = d$lng
d1 = subset(d, LAT> -50)
my.maps = c("terrain", "terrain-background", "satellite", "roadmap", "hybrid", "terrain", "watercolor",  "toner" )
sbbox <- make_bbox(lon = d1$LON, lat = d1$LAT, f = 0.1)
us_map <- get_map(location = sbbox, maptype = my.maps[3], source = "osm")
library(ggthemes)
ggmap(us_map, alpha=0.1) +
  geom_point(data = d1, aes(x = LON, y=LAT),
             col='red') +
  ggtitle('Publications on Optical Limiting') +
  theme_economist() +
  theme(      panel.grid.major=element_blank(),
              panel.grid.minor=element_blank(),
              legend.title = element_blank(),
              axis.text.x=element_blank(),
              axis.text.y=element_blank(),
              axis.ticks=element_blank(),
              axis.title.x=element_blank(),
              axis.title.y=element_blank())

ggplot(d1, aes(LON, LAT)) + 
  geom_point() + 
  theme_bw()

# Create the map
q2 = data.frame(
  long = d1$LON,
  lat = d1$LAT,
  group = 1
)
w_map <- map_data("world")
ggplot(w_map, aes(long, lat, group = group)) +
  geom_polygon(fill='grey80', color = "lightblue") +
  geom_point(data = q2, size=2, col='red') +
  ggtitle('Publications on Optical Limiting and Phthalocyanine',
        subtitle = 'Data Source: Gredig Lab, May 2020') +
  theme_economist()  +
  scale_y_continuous(limits = c(-55,90)) +
  theme(legend.position="bottom") +
  guides(col=guide_legend(nrow=2)) +
  theme(      panel.grid.major=element_blank(),
              panel.grid.minor=element_blank(),
              legend.title = element_blank(),
              axis.text.x=element_blank(),
              axis.text.y=element_blank(),
              axis.ticks=element_blank(),
              axis.title.x=element_blank(),
              axis.title.y=element_blank(),
              legend.key.size=unit(1,"point"))
ggsave('OpticalLimitingMap.png', width=9, height=6, dpi=300)

k.us= which(d$country=='USA')
d[k.us,]


             