library(sf)
harv_plots <- st_read('E:/LEARN/R/GEOSPATIAL IN R/neon-geospatial-data/harv/harv_plots.csv',
                      options=c("X_POSSIBLE_NAMES=longitude",
                                "Y_POSSIBLE_NAMES=latitude"),#telling read function where to extract data for longitude and latitude
                      crs=4326)# specifying reference system
#saving it as shapefile
st_write(harv_plots,"harv_plots_new.shp")

