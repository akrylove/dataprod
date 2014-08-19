library(shiny)

fileUrl <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
file <- "pml-testing.csv"; download.file(fileUrl,destfile=file,method="curl")
data <- read.csv(file)
dataCopy <- data
accel <- grep("accel", colnames(data), ignore.case = FALSE, fixed=TRUE)
keep_cols <- c(160, accel); data <- data[keep_cols]
remove <- grep("^var", colnames(data)); data <- data[,-remove] 
dtab <- data[,c(1,2,6,10,14)]
answers <- read.csv("answers.csv", header=FALSE)

predictMistake <- function(accelId) {
  reading <- dataCopy[accelId,]
  result <- as.character(answers[accelId,1])
  return(result)
}

shinyServer(
  function(input, output) {
    output$mytable <- renderDataTable({dtab})
    problem_id <- reactive({as.numeric(input$problem_id)})
    output$prediction <- renderText({paste("Predicted mistake type is", predictMistake(input$problem_id))})
    output$graph <- renderPlot({plot(answers, data$total_accel_forearm, type="p"
                                     , main="Predicted Exercise Mistake", ylab="Forearem Accelaration"
                                     , xlab="Mistake Type")})
  }
)
