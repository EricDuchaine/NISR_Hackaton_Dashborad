# Load the necessary packages
if (!require("shiny")) install.packages("shiny")
if (!require("shinydashboard")) install.packages("shinydashboard")
if (!require("readxl")) install.packages("readxl")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("tidyr")) install.packages("tidyr")
if (!require("zoo")) install.packages("zoo")
if (!require("forecast")) install.packages("forecast")
if (!require("lubridate")) install.packages("lubridate")
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("skimr")) install.packages("skimr")
if (!require("reshape2")) install.packages("reshape2")
if (!require("plotly")) install.packages("plotly")

library(shinydashboard)
library(plotly)
library(reshape2)
library(shiny)
library(readxl)
library(ggplot2)
library(tidyr)
library(zoo)
library(forecast)
library(lubridate)
library(tidyverse)
library(skimr)

# Install and load the readxl package
install.packages("readxl")
library(readxl)

# Replace 'your_file.xlsx' with the actual path to your Excel file 
excel_file <- "C:/Users/ERIC/Downloads/labor force data.xlsx"

# Define the sheet names you want to import (A to J)
sheet_names <- c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J")

# Create an empty list to store the imported data frames
data_frames <- list()

# Loop through the sheet names and import the data into the list
for (sheet_name in sheet_names) {
  data <- read_excel(excel_file, sheet = sheet_name)
  data_frames[[sheet_name]] <- data
}

# Define the UI
# Define the UI
ui <- dashboardPage(
  dashboardHeader(title = "Labor Force Survey Dashboard"),
  dashboardSidebar(),
  dashboardBody(
    tabsetPanel(
      tabPanel("Employed Population by Educational Group", plotlyOutput("chart_b")),
      tabPanel("Monthly Income by Education Level & Gender", plotlyOutput("chart_c")),
      tabPanel("Employment Status by Type of Disability", plotlyOutput("chart_d")),
      tabPanel("Number of Male employed in various industries in Rwanda", plotlyOutput("chart_e")),
      tabPanel("Number of Female employed in various industries in Rwanda", plotlyOutput("chart_f")),
      tabPanel("Labour Force Participation Rate by Province in 2022", plotlyOutput("chart_g")),
      tabPanel("Employed and Unemployed Population by Province in 2022", plotlyOutput("chart_h"))
    )
  )
)

# Define the server
server <- function(input, output) {
  
  # Access and view sheet "A" from the list
  sheet_A <- data_frames[["A"]]
  
  # Chart B - Interactive
  output$chart_b <- renderPlotly({
    data <- data.frame(
      Occupation_group = c("None", "Primary", "Lower secondary", "Upper secondary", "University"),
      Male = c(898982, 638339, 119840, 174268, 146275),
      Female = c(714724, 514690, 99497, 141419, 98318)
    )
    
    data_long <- melt(data, id.vars = "Occupation_group")
    
    p <- ggplot(data_long, aes(x = Occupation_group, y = value, fill = variable)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(
        title = "Employed Population by Occupation Group and Gender",
        x = "Occupation Group",
        y = "Total Employed Population"
      ) +
      scale_fill_manual(values = c("Male" = "blue", "Female" = "red")) +
      theme_minimal()
    
    ggplotly(p)
  })
  
  # Access and view sheet "I" from the list
  sheet_I <- data_frames[["I"]]
  
  # Chart C - Interactive
  output$chart_c <- renderPlotly({
    data <- data.frame(
      Education_level = c("None", "Primary", "Lower secondary", "Upper secondary", "University"),
      Male = c(34680, 49262, 67488, 105285, 345156),
      Female = c(22402, 24564, 32550, 77327, 239719)
    )
    
    data_long <- melt(data, id.vars = "Education_level")
    
    p <- ggplot(data_long, aes(x = Education_level, y = value, fill = variable)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(
        title = "Monthly Income by Education Level and Gender",
        x = "Education Level",
        y = "Values"
      ) +
      scale_fill_manual(values = c("Male" = "blue", "Female" = "pink")) +
      theme_minimal()
    
    ggplotly(p)
  })
  
  # Access and view sheet "I" from the list
  sheet_H <- data_frames[["H"]]
  
  # Chart C - Interactive
  output$chart_d <- renderPlotly({
    data <- data.frame(
      "Type_of_disability" = c("Seeing", "Hearing", "Walking", "Remembering", "Washing, dressing", "Communicating"),
      "Employed" = c(6962, 8338, 12198, 3533, 1210, 1738),
      "Unemployed" = c(1337, 674, 1985, 1292, 0, 0)
    )
    data_long <- melt(data, id.vars = "Type_of_disability")
    
    p <- ggplot(data, aes(x = Type_of_disability)) +
      geom_bar(aes(y = Employed, fill = "Employed"), position = "dodge", stat = "identity") +
      geom_bar(aes(y = Unemployed, fill = "Unemployed"), position = "dodge", stat = "identity") +
      labs(
        title = "Employment Status by Type of Disability",
        x = "Type of Disability",
        y = "Count",
        fill = "Employment Status"
      ) +
      theme_minimal() +
      scale_fill_manual(values = c("Employed" = "yellow", "Unemployed" = "red"))
    
    ggplotly(p)
  })
  
  # Access and view sheet "I" from the list
  sheet_D <- data_frames[["D"]]
  
  # Chart D - Interactive
  output$chart_e <- renderPlotly({
    p <- ggplot(data = sheet_D, aes(x = Male, y = Activities)) +
      geom_point() +
      geom_rug(col = "blue", alpha = 0.5, size = 3)
    
    ggplotly(p)
  })
  
  # Access and view sheet "I" from the list
  sheet_D <- data_frames[["D"]]
  
  # Chart D - Interactive
  output$chart_f <- renderPlotly({
    p <- ggplot(data = sheet_D, aes(x = Female, y = Activities)) +
      geom_point() +
      geom_rug(col = "red", alpha = 0.5, size = 3)
    
    ggplotly(p)
  })
  
  # Access and view sheet "B" from the list
  sheet_B <- data_frames[["B"]]
  
  # Chart B - Interactive
  output$chart_g <- renderPlotly({
    p <- ggplot(data = sheet_B, aes(x = Province, y = Labour_force_participation_rate, size = Employed)) +
      geom_point(aes(color = Province), alpha = 0.6) +
      scale_size_continuous(range = c(3, 15)) +
      labs(
        title = "Bubble Chart of Labour Force Participation Rate by Province",
        x = "Province",
        y = "Labour Force Participation Rate",
        size = "Employed",
        color = "Province"
      ) +
      theme_minimal()
    
    ggplotly(p)
  })
  
  # Access and view sheet "B" from the list
  sheet_B <- data_frames[["B"]]
  
  # Chart B - Interactive
  output$chart_h <- renderPlotly({
    p <- ggplot(data = sheet_B, aes(x = Province, y = Employed)) +
      geom_segment(aes(xend = Province, yend = 0), color = "blue", size = 2.5) +
      geom_point(aes(x = Province, y = Employed, color = "Employed"), size = 5) +
      geom_point(aes(x = Province, y = Unemployed, color = "Unemployed"), size = 5) +
      scale_color_manual(values = c(Employed = "blue", Unemployed = "red")) +
      labs(
        title = "Employed and Unemployed Population by Province",
        x = "Province",
        y = "Population",
        color = "Category"
      ) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) # Close this line with a closing parenthesis
    
    ggplotly(p) # Close this line with a closing parenthesis
  })
}

# Run the Shiny app
shinyApp(ui, server)