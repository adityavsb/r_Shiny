library(leaflet)


shinyUI(navbarPage("Navbar!",
  tabPanel("Plot",
    sidebarLayout(
      sidebarPanel(
        plotOutput("hist")
      ),
      mainPanel(
        leafletOutput("map"),
        DT::dataTableOutput("table")
      )
    )
  ),
  tabPanel("Summary",
    verbatimTextOutput("summary")
  )
))