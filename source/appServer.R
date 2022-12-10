library(dplyr)
library(ggplot2)
library(hrbrthemes)
library(lubridate)
library(plotly)
library(shiny)

df_1 <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
#View(df_1)

country_2021_most_co2 <- df_1 %>%
  filter(year == max(year)) %>%
  filter(co2 != "NA") %>%
  filter(iso_code != "") %>%
  filter(co2 == max(co2)) %>%
  pull(country)

country_2021_most_co2_per_capita <- df_1 %>%
  filter(year == max(year)) %>%
  filter(co2_per_capita != "NA") %>%
  filter(iso_code != "") %>%
  filter(co2_per_capita == max(co2_per_capita)) %>%
  pull(country)

year_most_emissions <- df_1 %>%
  filter(co2 != "NA") %>%
  group_by(year) %>%
  summarize(co2 = sum(co2)) %>%
  filter(co2 == max(co2)) %>%
  pull(year)

country_2021_most_co2_growth <- df_1 %>%
  filter(year == max(year)) %>%
  filter(co2_growth_prct != "NA") %>%
  filter(iso_code != "") %>%
  filter(co2_growth_prct == max(co2_growth_prct)) %>%
  pull(country)



server <- function(input,output) {
  output$line <- renderPlotly({
    ggplotly(ggplot(country_data_years <- df_1 %>%
                      filter(country %in% input$country) %>% #%in%
                      filter(input$data != "NA") %>%
                      select(year, input$data),
                    aes(x=year, y=country_data_years[[input$data]]))+
               geom_line(color="#000000", size=1, alpha=0.9, linetype=1, group = 1) +
               theme_ipsum() +
               ggtitle(paste("Increase in", input$data, "emissions over time")) + xlab("Year") + ylab(input$data) + labs(caption = "Choose what emission to show in the graph and see the trend over the years."))
  })
  output$growth <- renderText({country_2021_most_co2_growth})
  output$mostco2 <-  renderText({country_2021_most_co2})
  output$mostco2pc <-  renderText({country_2021_most_co2_per_capita})
  output$yearmost <-  renderText({year_most_emissions})
}