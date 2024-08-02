library(tidyverse) #for data clean-up
library(R.utils) #unzip data
library(httr) #fetching data from server
library(sf)
library(stars)
library(rayshader) #create spike maps
library(dplyr)
#loading data and 
pop_df <- sf::st_read("kontur_population_KE_20231101.gpkg")
boundary <- st_read("geoBoundaries-KEN-ADM0_simplified.shp")

#creating a bounding box to give min and max long and lat values for pixels beofre converting to raster
bb <- sf::st_bbox(pop_df)
#getting raster size of the kenyan map
get_raster_size <- function(){
  height <- sf::st_distance(
    st_point(c(bb[["xmin"]],bb[["ymin"]])),
    st_point(c(bb[["xmin"]],bb[["ymax"]]))
  )
  width <- sf::st_distance(
    st_point(c(bb[["xmin"]],bb[["ymin"]])),
    st_point(c(bb[["xmax"]],bb[["ymin"]]))
  )
  
  if (height > width){
    height_ratio <-1
    width_ratio <- width/height
  } else {
    width_ratio <-1
    height_ratio <- height/width
  }
  return(list(width_ratio,height_ratio))
}

width_ratio <-get_raster_size()[[1]]
height_ratio <- get_raster_size()[[2]]

size <- 3000 # resolution of height
width <- round((size*width_ratio),0)
height <- round((size*height_ratio),0)

#converting the sizes to raster
pop_rast <- st_rasterize(pop_df %>%
                           select(population,geom),
                         nx=width,ny=height)
#converting the raster into a matrix
pop_mat <- pop_rast %>%
  as("Raster")%>%
  rayshader::raster_to_matrix()

#defining our color choices
cols <- rev(c("#0b1354","#283680","#6853a9","#c863b3"))


#defining out texture
texture <- grDevices::colorRampPalette(cols)(256)

pop_mat %>%
  rayshader::height_shade(texture = texture) %>%
  rayshader::plot_3d( #create spikes depending on data
    heightmap = pop_mat,
    solid = TRUE, 
    soliddepth = 0,
    zscale = 100, #ratio btwn x,y and z, decreasing it exaggerates the spikes
    shadowdepth = 0, 
    shadow_darkness = .95, #what happens when you cast light
    shadow = TRUE,
    windowsize = c(800,800),#how big the map is
    phi = 30, #how much spike is filled with brightness, lower value, higher tilt
    zoom = .75, #how much you want to zoom, higher number zooms out
    theta = -35, #rotation
    background = "white",
    linewidth = 0.5
  )  
  

rayshader::render_highquality(
    filename= "kenyan_population_2019.png",
    preview = T,
    light = T,
    lightdirection = 225,
    lightaltitude = 60,
    lightintensity = 250,
    interactive  = F,
    width = width,height = height
  )

