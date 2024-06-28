library(stars)
library(sf)
library(ggplot2)

dtm_harv <- read_stars('E:/LEARN/R/GEOSPATIAL IN R/neon-geospatial-data/harv/harv_dtmcrop.tif')
plots_harv <- st_read('E:/LEARN/R/GEOSPATIAL IN R/neon-geospatial-data/harv/harv_plots.shp')

ggplot()+
  geom_stars(data=dtm_harv)+
  geom_sf(data=plots_harv)  #projection not okay
#projecting the data
st_crs(dtm_harv) #checking the projection
st_crs(plots_harv)

dtm_harv_latlong <- st_transform(dtm_harv,4326)#projecting raster data
st_crs(dtm_harv_latlong)

plots_harv_utm <- st_transform(plots_harv,st_crs(dtm_harv))#matching data for raster then transform to same crs to vector data
#plotting again
ggplot()+
  geom_stars(data=dtm_harv)+
  geom_sf(data=  plots_harv_utm)
