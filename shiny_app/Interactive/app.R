#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
# 
#
library(tidyverse)
library(shiny)
df <- read_csv("genderscore.csv") %>% 
  pivot_longer(cols = female.total.score:male.total.score, names_to = "gender", values_to = "score")

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Gender Scores"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(
        "gender",
        "Select groups",
        unique(df$gender),
        selected = unique(df$gender)[1]
      )
    ),
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("scatterPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$scatterPlot <- renderPlot({
    # show data for  input$group from ui.R
    df %>%
      filter(gender %in% input$gender) %>% 
      ggplot(aes(y = year, x = score, color = gender)) +
      geom_point(position = "dodge")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
