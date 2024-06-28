library(stars)
library(ggplot2)
#reading data
dtm_harv <- read_stars('E:/LEARN/R/GEOSPATIAL IN R/neon-geospatial-data/harv/harv_dtmcrop.tif')
dtm_harv

ggplot() + 
  geom_stars(data = dtm_harv) + #plotting raster data
  scale_fill_viridis_c()#mapping along certain color ramp
