library(shiny) 

shinyUI(pageWithSidebar(
  headerPanel("Exercise Mistake Prediction - please allow 30 seconds for data to load..."),
  sidebarPanel(
    h4('Select exercise reading from the Readings panel on the right'),
    selectInput("problem_id", label = h3("Problem ID"), 
                choices = list("1" = 1, "2" = 2, "3" = 3,
                               "4" = 4, "5" = 5, "6" = 6,
                               "7" = 7, "8" = 8, "3" = 9,
                               "10" = 10, "11" = 11, "12" = 12,
                               "13" = 13, "14" = 14, "15" = 15,
                               "16" = 16, "17" = 17, "18" = 18,
                               "19" = 19, "20" = 20), selected = 1)
    #submitButton('Submit')
  ),
  
  mainPanel(
    h3('Accelerometer readings:'),
    tabsetPanel(
      tabPanel('Overview',
               p("This program is a simple UI extension to the class project from the
                  the Machine Learning class.  For analysis and code details,
                  please see"), a("http://akrylove.github.io/machine-learning/"),
               p("Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now
                  possible to collect a large amount of data about personal activity 
                  relatively inexpensively. One thing that people
                  regularly do is quantify how much of a particular activity they do, but
                  they rarely quantify how well they do it. This program attempts to 
                  predict whether an exercise was done correctly (outcome A) and, if not,
                  what type of mistake was made (outcomes B, C, D, E)"),
                p("More information is available from the 
                  website here:"), a("http://groupware.les.inf.puc-rio.br/har"), br(), br(),
                div(strong("Instructions")),
                div("1. Click on the Readings tab and note the problem ID for which you would like to predict the outcome"),
                div("2. Select the problem id from the drop-down on the left"),
                div("3. Select the Prediction tab to see the results"),
                div("4. Select various problem id's from the drop-down on the left to see how the prediction changes"),
                div("5. Select the Graph tab to see the model graph")
      ),
      tabPanel('Readings', dataTableOutput("mytable")),
      tabPanel('Prediction',
                verbatimTextOutput("prediction"),
                p("based on the model with the following attributes "),
                p(verbatimTextOutput("mod"))
      ),
      tabPanel('Model graph', plotOutput("graph"))
    )
  )
))