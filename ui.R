# This is an app that shows a plot of EUI for Minneapolis

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Weather Normalized Energy Use Intensity (EUI) for Minneapolis"),
  
  # Sidebar with a slider input for number of bins 
  sidebarPanel(
        radioButtons("ptype", "Property Type:", c("Public" = "public", "Private" = "private")),
        selectInput("btype", "Building Type:", c("Parking" = "park", "Other - Entertainment/Public Assembly" = "passembly", "Office" = "office", 
                                                 "K-12 School" = "school", "Hotel" = "hotel", "Mixed-use Property"="muse")),
        textOutput("ptype"),
        textOutput("btype")
        ),
    
   # Show a plot of the generated distribution
   mainPanel(
     plotOutput("plot")
    )
  )
)
