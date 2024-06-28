library(stars)

dtm_harv <- read_stars('E:/LEARN/R/GEOSPATIAL IN R/neon-geospatial-data/harv/harv_dtmcrop.tif')
dsm_harv <- read_stars('E:/LEARN/R/GEOSPATIAL IN R/neon-geospatial-data/harv/harv_dsmcrop.tif')
chm_harv <- dsm_harv-dtm_harv

ggplot() +
  geom_stars(data = chm_harv)
