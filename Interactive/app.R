INTERACTIVE CODE SO FAR:
  #
  # This is a Shiny web application. You can run the application by clicking
  # the 'Run App' button above.
  #
  # Find out more about building applications with Shiny here:
  #
  #    http://shiny.rstudio.com/
  #
  
  # Load packages ----
library(shiny)
library(maps)
library(mapproj)

# Load data ----
income <- read.csv(here::here("dataset/schooldatacleaned.csv"))

# Source helper functions -----
source("helpers.R")

# User interface ----
ui <- fluidPage(
  titlePanel("Scores in States"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Create demographic maps with 
        information from the School Scores data."),
      
      selectInput("var", 
                  label = "Choose a variable to display",
                  choices = c("Income 20k or less", "Income between 20k and 40k",
                              "Income between 40k and 60k", "Income between 40k and 60k", 
                              "Income between 60k and 80k", "Income between 80k and 100k",
                              "Income 100k or more"),
                  selected = "Income 20k or less"),
      
      sliderInput("range", 
                  label = "Range of interest:",
                  min = 0, max = 100, value = c(0, 100))
    ),
    
    mainPanel(plotOutput("map"))
  )
)

# Server logic ----
server <- function(input, output) {
  output$map <- renderPlot({
    data <- switch(input$var,
                   "Income 20k or less" = income$income.less.than.20k , 
                   "Income between 20k and 40k" = income$income.between.20k.and.40k,
                   "Income between 40k and 60k" = income$income.between.40k.and.60k, 
                   "Income between 60k and 80k" = income$income.between.60k.and.80k, 
                   "Income between 80k and 100k" = income$income.between.80k.and.100k,
                   "Income 100k or more" = income$income.more.than.100k)
    
    color <- switch(input$var, 
                    "Income 20k or less" = "darkgreen", 
                    "Income between 20k and 40k" = "black" ,
                    "Income between 40k and 60k" = "darkblue" , 
                    "Income between 40k and 60k" = "darkorange" , 
                    "Income between 60k and 80k" = "red" , 
                    "Income between 80k and 100k" = "darkviolet",
                    "Income 100k or more" = "yellow")
    
    legend <- switch(input$var, 
                     "Income 20k or less" = "% 20k or less", 
                     "Income between 20k and 40k" = "% between 20k and 40k" ,
                     "Income between 40k and 60k" = "% between 40k and 60k" , 
                     "Income between 40k and 60k" = "% between 60 and 80k" , 
                     "Income between 60k and 80k" = "% between 80k and 100k" , 
                     "Income between 80k and 100k" = "% 100k or more")
    
    percent_map(data, color, legend, input$range[1], input$range[2])
  })
}

# Run app ----
shinyApp(ui, server)
