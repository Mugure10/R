library(sf)
library(ggplot2)

plots_harv <- st_read('E:/LEARN/R/GEOSPATIAL IN R/neon-geospatial-data/harv/harv_plots.shp')
boundary_harv <- st_read('E:/LEARN/R/GEOSPATIAL IN R/neon-geospatial-data/harv/harv_boundary.shp')

ggplot() +
  geom_sf(data=boundary_harv)+ 
  geom_sf(data=plots_harv, mapping = aes(color=plot_type))
  
