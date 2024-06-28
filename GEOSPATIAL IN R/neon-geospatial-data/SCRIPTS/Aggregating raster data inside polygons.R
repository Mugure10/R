library(sf)
library(stars)
library(ggplot2)
library(dplyr)

harv_soils <- st_read('E:/LEARN/R/GEOSPATIAL IN R/neon-geospatial-data/harv/harv_soils.shp')
harv_dtm <- read_stars('E:/LEARN/R/GEOSPATIAL IN R/neon-geospatial-data/harv/harv_dtmfull.tif')

ggplot()+
  geom_stars(data = harv_dtm)+
  geom_sf(data = harv_soils,alpha=0)
#extracting data within the polygon

#calculating average elevation
elevs_by_soil <- aggregate(harv_dtm,harv_soils,mean)
elevs_by_soil$harv_dtmfull.tif

harv_soils <- mutate(harv_soils, elevation= elevs_by_soil$harv_dtmfull.tif)
View(harv_soils)
#mapping soils by elevation
ggplot()+
  geom_sf(data = harv_soils,mapping = aes(fill=elevation))+
  scale_fill_viridis_c()
