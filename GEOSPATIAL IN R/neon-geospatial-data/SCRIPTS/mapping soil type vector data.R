library(sf)
library(ggplot2)

harv_soils <- st_read('E:/LEARN/R/GEOSPATIAL IN R/neon-geospatial-data/harv/harv_soils.shp')
#mapping with dofferent color types for soils
ggplot()+
  geom_sf(data = harv_soils, mapping= aes(fill= TYPE_))+
  scale_fill_viridis_d()
#mapping individual views for different soil types
ggplot()+
  geom_sf(data = harv_soils)+
  facet_wrap(~TYPE_)
