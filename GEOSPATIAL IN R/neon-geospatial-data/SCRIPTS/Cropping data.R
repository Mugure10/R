library(sf)
library(stars)
library(ggplot2)
#reading datasets
harv_boudary <- st_read('E:/LEARN/R/GEOSPATIAL IN R/neon-geospatial-data/harv/harv_boundary.shp')  
harv_dtm <- read_stars('E:/LEARN/R/GEOSPATIAL IN R/neon-geospatial-data/harv/harv_dtmfull.tif')
harv_soils <- st_read('E:/LEARN/R/GEOSPATIAL IN R/neon-geospatial-data/harv/harv_soils.shp')
#plotting the datasets
ggplot()+
  geom_stars(data = harv_dtm)+
  scale_fill_viridis_c()+
  geom_sf(data = harv_boudary, alpha=0)
#cropping using st_crop
harv_dtm_cropped <- st_crop(harv_dtm,harv_boudary)
harv_dtm_cropped
#plotting cropped data
ggplot()+
  geom_stars(data = harv_dtm_cropped)+
  scale_fill_viridis_c(na.value = 'transparent')+#setting null color to transparent
  geom_sf(data = harv_boudary, alpha=0)+
 coord_sf(datum = st_crs(harv_boudary))
#alternative way of cropping
#masking data by hiding null values instead of cropping
harv_dtm_cropped <- st_crop(harv_dtm,harv_boudary,crop = FALSE)

#Cropping to a bounding box
bbox <- st_bbox(c(xmin=731000,ymin=4713000,xmax=732000,ymax=4714000),
                crs=st_crs(dtm_harv))

harv_dtm_small <- st_crop(harv_dtm,bbox)
harv_soils_small <-st_crop(harv_soils,bbox)

ggplot()+
  geom_stars(data=harv_dtm_small)+
  scale_fill_viridis_c(na.value = 'transparent')+
  geom_sf(data = harv_soils_small,alpha=0.5)+
  coord_sf(datum = st_crs(harv_soils_small))  

#saving spatial data
write_stars(harv_dtm_cropped,"harv_dtm_cropped.tif")#saving raster cropped data
write_sf(harv_soils_small,"harv_soils_small_cropped.shp")
