#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(tidyverse)
library(shiny)
df <- read_csv("incomegenderdata.csv") %>% 
  pivot_longer(cols = c(total.score, female.total.score, male.total.score), names_to = "gender", values_to = "score") %>%
  pivot_longer(cols = income.between.20.40k:income.more.than.100k, names_to = "income.bracket", values_to = "scores")

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Income Scores"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(
        "income.bracket",
        "Select bracket",
        unique(df$income.bracket),
        selected = unique(df$income.bracket)[1]
      ),
      checkboxGroupInput(
        "gender",
        "Select gender",
        unique(df$gender),
        selected = unique(df$gender)[2]
      )
    ),
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("incomePlot"),
      plotOutput("genderPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  income <- reactive({ df %>%
    filter(income.bracket %in% input$income.bracket) %>% 
    ggplot(aes(y = state.name, x = scores, color = income.bracket)) +
    geom_point(position = "dodge")
  })
  
  gender <- reactive({df %>%
      filter(gender %in% input$gender) %>% 
      ggplot(aes(y = state.name, x = score, color = gender)) +
      geom_point(position = "dodge")
  })
  
  output$incomePlot <- renderPlot({
      income() 
  })
  
  output$genderPlot <- renderPlot({
      gender() 
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
