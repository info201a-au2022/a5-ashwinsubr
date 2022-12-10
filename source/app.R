library(shiny)

source("appServer.R")
source("appUI.R")

shinyApp(ui = ui, server = server)
