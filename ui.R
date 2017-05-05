# ui function for  daily student alcohol consumption

library(shiny)
shinyUI(fluidPage(
  titlePanel("Daily Alcohol Consumption And Grades/Gender"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Exploring student alcohol Consumption"),
      
      selectInput("var", 
                  label = "Choose a Grade to display G1,G2,G3",
                  choices = c("G1", "G2",
                              "G3"),
                  selected = "G3"),
      
      sliderInput("bins", 
                  label = "Binwidth",
                  min = 0, max = 10, value = 5),
      selectInput("gender",
                  label="Choose a Gender",
                  choices=c("Male","Female"),
                  selected="Female"),
      selectInput("higher",
                  label="Higher Education",
                  choices = c("Yes","No"),
                  selected="Yes"),
      radioButtons("health", label = h3("Health Level"),
                   choices = list("1" = 1, "2" = 2,
                                  "3" = 3,"4"=4,"5"=5),selected = 1),
      selectInput("nursery", 
                         label = h3("Nursery"), 
                         choices = list("Yes" = 1, 
                                        "No" = 2),
                         selected = 1),
      radioButtons("romantic", label = h3("Romantic Relationship"),
                   choices = list("Yes" = 1, "No" = 2
                                  ),selected = 1)
      
      ),
    
    mainPanel(plotOutput("plot"))
    
  )
))