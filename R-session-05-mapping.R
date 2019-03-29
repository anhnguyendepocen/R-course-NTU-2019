
## ----libraries, message= FALSE, warning=FALSE----------------------------

library("readxl") # Import the data from Excel file
library("dplyr")  # filter and reformat data frames

library("ggplot2") # graphics
library("sf") # simple features
library("rnaturalearth") 
library("rnaturalearthdata")


## ------------------------------------------------------------------------
world <- rnaturalearth::ne_countries(scale = "medium", returnclass = "sf")

## ------------------------------------------------------------------------
colnames(world)

## ------------------------------------------------------------------------
world$geometry[1]


# Set the black and white theme
theme_set(theme_bw())

ggplot(data = world) +
    geom_sf() 

## ----

ggplot(data = world) +
    geom_sf() +
    coord_sf(expand = FALSE)



## ----
ggplot(data = world) +
    geom_sf(color="white", fill="blue")+
    coord_sf(expand = FALSE) 


## ----
ggplot(data = world) +
    geom_sf(aes(fill= pop_est))+
    coord_sf(expand = FALSE)


## ----
ggplot(data = world) +
    geom_sf(aes(fill= pop_est)) +
    coord_sf(expand = FALSE) +
    scale_fill_viridis_c(trans = "log10")


## ----
ggplot(data = world) +
    geom_sf() +
    coord_sf(expand = FALSE,
             crs = "+proj=laea +lat_0=90 +lon_0=0 ")


## ------------------------------
ggplot(data = world) +
    geom_sf() +
    coord_sf(xlim=c(90,110), 
             ylim=c(-10,10))


## ----------------------------------------------------------
world_centroids<- st_coordinates(st_centroid(world$geometry))

## ----------------------------------------------------------
world_centroids <- cbind(world, world_centroids)


## ------------------------------
ggplot(data = world_centroids) +
    geom_sf() +
    coord_sf(xlim=c(70,130), 
             ylim=c(-20,20)) +
    geom_text(aes(x = X, y=Y, label=name), 
              size=5) +
    xlab("Longitude") +
    ylab("Latitude")


## ------------------------------------------------------------------------
bolido <- readxl::read_excel("data/bolido.xlsx")

## --------------------------------------------------
  my_kable(bolido)


## ------------------------------
ggplot(data = world) +
    geom_sf()+
    coord_sf(expand = FALSE) +
    geom_point(data=filter(bolido, 
                           bolido_pct >0), 
               aes(x=longitude, 
                   y=latitude), 
               size=3)


## ------------------------------
ggplot(data = world) +
    geom_sf()+
    coord_sf(expand = FALSE) +
    geom_point(data=filter(bolido, 
                           bolido_pct >0), 
               aes(x=longitude, 
                   y=latitude, 
                   size=bolido_pct),
               color="blue")


## ------------------------------
ggplot(data = world) +
    geom_sf()+
    coord_sf(expand = FALSE) +
    geom_point(data=filter(bolido, 
                           bolido_pct >0,
                           stringr::str_detect(species_dominant, "Triparma")), 
               aes(x=longitude, 
                   y=latitude,
                   color=species_dominant),
               size = 4) +
   scale_colour_viridis_d() +
   theme(legend.position="bottom") +
   guides(color=guide_legend(nrow=2,
                             byrow=TRUE))




## ------------------------------------------------------------------------
library("leaflet") 

## ------------------------------
leaflet(width = 750, height = 500)



## ------------------------------
leaflet(width = 750, height = 500)%>%
  addTiles()



## ------------------------------
leaflet(width = 750, height = 500)%>%
  addTiles() %>%
  setView(lng=0, lat=0, zoom=2)



## ------------------------------
leaflet(width = 750, height = 500)%>%
  addTiles() %>%
  setView(lng=0, lat=0, zoom=2) %>% 
  addCircleMarkers(data = bolido, 
                   lat = ~ latitude, 
                   lng = ~ longitude,
               radius = 5,
         label = ~ station_id,
         labelOptions = labelOptions(textsize = "10px", 
                                     noHide = T),
         clusterOptions = markerClusterOptions())




## ------------------------------
leaflet(width = 750, height = 500)%>%
  addTiles() %>%
  setView(lng=0, lat=0, zoom=2) %>% 
  addCircleMarkers(data = bolido, 
                   lat = ~ latitude, 
                   lng = ~ longitude,
               radius = 5,
         label = ~ station_id,
         labelOptions = labelOptions(textsize = "10px", noHide = T),
         clusterOptions = markerClusterOptions()) %>% 
  addProviderTiles(providers$Esri.OceanBasemap)




