#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

library(wordcloud)
library(wordcloud2)
library(memoise)

cog1 <- read.csv(file = "cogC1.csv", header = TRUE, sep=",")
cog2 <- read.csv(file = "cogC2.csv", header = TRUE, sep=",")
cog3 <- read.csv(file = "cogC3.csv", header = TRUE, sep=",")
cog4 <- read.csv(file = "cogC4.csv", header = TRUE, sep=",")
cog5 <- read.csv(file = "cogC5.csv", header = TRUE, sep=",")
cog6 <- read.csv(file = "cogC6.csv", header = TRUE, sep=",")
cog7 <- read.csv(file = "cogC7.csv", header = TRUE, sep=",")
cog8 <- read.csv(file = "cogC8.csv", header = TRUE, sep=",")
cog9 <- read.csv(file = "cogC9.csv", header = TRUE, sep=",")
cog10 <- read.csv(file = "cogC10.csv", header = TRUE, sep=",")
cog11 <- read.csv(file = "cogC11.csv", header = TRUE, sep=",")
cog12 <- read.csv(file = "cogC12.csv", header = TRUE, sep=",")
cog13 <- read.csv(file = "cogC13.csv", header = TRUE, sep=",")
cog14 <- read.csv(file = "cogC14.csv", header = TRUE, sep=",")
cog15 <- read.csv(file = "cogC15.csv", header = TRUE, sep=",")
cog16 <- read.csv(file = "cogC16.csv", header = TRUE, sep=",")
cog17 <- read.csv(file = "cogC17.csv", header = TRUE, sep=",")
cog18 <- read.csv(file = "cogC18.csv", header = TRUE, sep=",")


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("106 College's professor profession by CEEC 18 school group"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("freqFrame", "Choice CEEC 18 school group:",
                  choices = c(
                    "1.資訊學群",
                    "2.工程學群",
                    "3.數理化學群",
                    "4.醫藥衛生學群",
                    "5.生命科學學群",
                    "6.生物資源學群",
                    "7.地球與環境學群",
                    "8.建築與設計學群",
                    "9.藝術學群",
                    "10.社會與心理學群",
                    "11.大眾傳播學群",
                    "12.外語學群",
                    "13.文史哲學群",
                    "14.教育學群",
                    "15.法政學群",
                    "16.管理學群",
                    "17.財經學群",
                    "18.遊憩與運動學群")), 
      
      actionButton("update", "Update View"),
      hr(),
      sliderInput("freq",
                  "Minimum Frequency:",
                  min = 1,  max = 100, value = 20),
      sliderInput("max",
                  "Maximum Number of Words:",
                  min = 1,  max = 1000,  value = 200)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)




# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  datasetInput <- eventReactive(input$update, {
    switch(input$freqFrame,
           "1.資訊學群" = cog1,
           "2.工程學群" = cog2,
           "3.數理化學群" = cog3,
           "4.醫藥衛生學群" = cog4,
           "5.生命科學學群" = cog5,
           "6.生物資源學群" = cog6,
           "7.地球與環境學群" = cog7,
           "8.建築與設計學群" = cog8,
           "9.藝術學群" = cog9,
           "10.社會與心理學群" = cog10,
           "11.大眾傳播學群" = cog11,
           "12.外語學群" = cog12,
           "13.文史哲學群" = cog13,
           "14.教育學群" = cog14,
           "15.法政學群" = cog15,
           "16.管理學群" = cog16,
           "17.財經學群" = cog17,
           "18.遊憩與運動學群" = cog18)
  }, ignoreNULL = FALSE)
  
  wordcloud_rep <- repeatable(wordcloud)

  output$distPlot <- renderPlot({
    freqFrame <- datasetInput() 
    
    # generate bins based on input$bins from ui.R
    wordcloud_rep(freqFrame$Var1,freqFrame$Freq, scale=c(5,0.1),
                  min.freq = input$freq, max.words=input$max,
                  random.order = FALSE,colors=palette())
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

