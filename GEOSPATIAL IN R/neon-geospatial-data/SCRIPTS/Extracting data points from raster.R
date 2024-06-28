library(stars)
library(sf)
library(ggplot2)
library(dplyr)
#fetching data
dtm_harv <- read_stars('E:/LEARN/R/GEOSPATIAL IN R/neon-geospatial-data/harv/harv_dtmcrop.tif')
plots_harv <- st_read('E:/LEARN/R/GEOSPATIAL IN R/neon-geospatial-data/harv/harv_plots.shp')
#reprojecting data to similar projection
plots_harv_utm <- st_transform(plots_harv,st_crs(dtm_harv))
#extracting data points for elevation from raster dtm
plot_elevation <- aggregate(dtm_harv,plots_harv_utm, mean,as_points = FALSE)#getting mean elevation
#adding elevations column to the vector data
mutate(plots_harv_utm, elevations=plot_elevation$harv_dtmcrop.tif)
