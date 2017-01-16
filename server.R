library(leaflet)
library(maps)
library(ggplot2)

# Load auxiliar functions
source("helpers.R")

rest_data = load_data()

shinyServer(function(input, output, session) {
  output$hist = renderPlot({
    ggplot(data=rest_data, aes(x=Stars)) + 
      geom_histogram(fill="lightblue", bins=10)
  })
  
  output$summary = renderPrint({
    summary(rest_data)
  })
  
  output$map = renderLeaflet({
    # Build out a leaflet object
    leaflet() %>% 
      addTiles() %>% 
      addTiles(urlTemplate = "http://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png")  %>%  
      mapOptions(zoomToLimits="always") %>%             
      addMarkers(lat=rest_data$Latitude, lng=rest_data$Longitude,
                 clusterOptions=markerClusterOptions(), 
                 popup=paste("<b>", rest_data$Name,"</b><br>",
                             starsHTML(rest_data$Stars), "<br>",
                             gsub(", ", " <br/> ", rest_data$Address)
                 ))
  })
  
  output$table <- DT::renderDataTable({
    DT::datatable(subset(rest_data, select=c(Name, Address, Stars)))
  })
  
})