library(sf)
library(stars)
library(ggplot2)
library(dplyr)

harv_soils <- st_read('E:/LEARN/R/GEOSPATIAL IN R/neon-geospatial-data/harv/harv_soils.shp')  
harv_dtm <- read_stars('E:/LEARN/R/GEOSPATIAL IN R/neon-geospatial-data/harv/harv_dtmfull.tif')
#checking projections
st_crs(harv_soils)
st_crs(harv_dtm)

ggplot()+
  geom_stars(data = harv_dtm)+
  geom_sf(data=harv_soils,alpha=0)+
  coord_sf(datum = st_crs(harv_soils)) #specify the crs 
