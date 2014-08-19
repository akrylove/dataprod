library(shiny)
load("pml-model.Rdata")
file <- "pml-testing.csv"
data <- read.csv(file)
dataCopy <- data
accel <- grep("accel", colnames(data), ignore.case = FALSE, fixed=TRUE)
keep_cols <- c(160, accel); data <- data[keep_cols]
remove <- grep("^var", colnames(data)); data <- data[,-remove] 
dtab <- data[,c(1,2,6,10,14)]

predictMistake <- function(accelId) {
  reading <- dataCopy[accelId,]
  result <- as.character(predict(model,reading))
  return(result)
}

shinyServer(
  function(input, output) {
    output$mytable <- renderDataTable({dtab})
    problem_id <- reactive({as.numeric(input$problem_id)}) 
    output$prediction <- renderText({paste("Predicted mistake type is", predictMistake(input$problem_id))})
    output$graph <- renderPlot({plot(model, type="l", main="Random Forest Error Rate")})
    output$mod <- renderPrint({model})
  }
)
