library(dplyr)
library(ggplot2)
library(hrbrthemes)
library(lubridate)
library(plotly)
library(shiny)

introPage <- tabPanel(
  "Introduction",
  img(src = "co2PIC.jpeg", width = 1000, height = 500, align = "center", alt = "Climate change image"),
  p("Climate change is real. The last decade, has been the hottest ever recorded in 125,000 years. In this app, I aim to point out some statistics on climate change - related to CO2 and other types of emissions. Hopefully seeing this can open some eyes, and lead to people push for action to be taken. This is our earth, lets protect it and do our bit."),
  h3("Variable 1: Year with the most CO2 emissions"),
  p("For my first variable, I decided to find out in what year the CO2 emissions were the maximum, and we find out that the year is:"),
  textOutput("yearmost"),
  p("2021 is also the most recent year whose data we have. This means that CO2 emissions are at an all time high, and we need to fix our ways and start looking after our earth."),
  h3("Variable 2: Country with most CO2 and CO2 per capita emissions in 2021"),
  p("Next, I decided to find out what country has the most CO2 emissions in 2021, and I found out that it was:"),
  textOutput("mostco2"),
  p("But then, another question popped up in my head. I wondered whether this was the scenario just because China has a very large population, and hence I decided to look at it from a per capita angle. The country with the most CO2 emissions per capita was: "),
  textOutput("mostco2pc"),
  p("This tells us that looking at the per capita emissions gives a more complete and accurate answer to where we're going wrong."),
  h3("Variable 3: Country with most CO2 growth percentage in 2021"),
  p("I decided to look into which country had the most CO2 emission growth percentage in 2021, and found out that it was:"),
  textOutput("growth"),
  p("This tells us that Libya needs to take care about the emissions coming from their country.")
)

visualizationPage <- tabPanel(
  "Visualization Page",
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput(inputId = "country", 
                  label = "Choose a Country:", 
                  choices = unique(df_1$country)),
      textInput(inputId = "data",
                label = "Choose data point:",
                placeholder = "Eg: co2, methane, nitrous_oxide, oil_co2, coal_co2")
    ),
    mainPanel(
      plotlyOutput("line"),
      p("From this line graph we can notice that almost all emissions have increased drastically over the years and we need to take action to save our earth!!")
    )
  )
)


ui <- fluidPage(
  "Emissions",
  tabsetPanel(
    introPage,
    visualizationPage
  )
)