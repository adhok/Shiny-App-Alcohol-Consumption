# server function for  daily student alchohol consumption

library(ggplot2)
alc <- read.csv("student-por.csv",stringsAsFactors = F,header=T)
plot_function <- function(var,color,wbins,title_text)
{
  names(var)<- c("Sex","Nursery","Higher","romantic","Dalc","health","grade")
  var <- var[,c(-1,-2,-3,-4,-6)]
  var$Dalc <- as.factor(var$Dalc)
  g <- ggplot(var,aes(x=grade))+geom_histogram(binwidth = wbins,fill=color)+facet_grid(Dalc~.)+ggtitle(title_text)+theme(
    plot.title = element_text(hjust=0.4)
  )
  g
}
shinyServer(
  function(input, output) {
    output$plot <- renderPlot({
      data <- switch(input$var, 
                     "G1" = alc[,c(2,20,21,23,27,29,31)],
                     "G2" = alc[,c(2,20,21,23,27,29,32)],
                     "G3" = alc[,c(2,20,21,23,27,29,33)]
                     )
      
      color <- switch(input$var, 
                      "G1" = "darkgreen",
                      "G2" = "black",
                      "G3" = "darkorange"
                      )
      title <- switch(input$var,
                      "G1"="Daily Alcohol Consumption and Grade 1",
                      "G2"="Daily Alcohol Consumption and Grade 2",
                      "G3"="Daily Alcohol Consumption and Grade 3")
      data <- switch(input$gender,
                            "Male"=subset(data,sex=="M"),
                            "Female"=subset(data,sex=="F"))
      title <- switch(input$gender,
                      'Male'=paste(title,"for Male Students"),
                      "Female"=paste(title,"for female students"))
      data <- switch(input$higher,
                     "Yes"=subset(data,higher=="yes"),
                     "No"=subset(data,higher=="no"))
      title <- switch(input$higher,
                      "Yes"=paste(title,"who intend to study further"
                                  ),
                      "No"=paste(title,"who do not intend to study further"))
      data <- switch(input$health,
                     "1"=subset(data,health==1),
                     "2"=subset(data,health==2),
                     "3"=subset(data,health==3),
                     "4"=subset(data,health==4),
                     "5"=subset(data,health==5))
      title <- switch(input$health,
                      "1"=paste(title,"with health level 1"),
                      "2"=paste(title,"with health level 2"),
                      "3"=paste(title,"with health level 3"),
                      "4"=paste(title,"with health level 4"),
                      "5"=paste(title,"with health level 5"))
      data <- switch(input$nursery,
                     "1"=subset(data,nursery=="yes"),
                     "2"=subset(data,nursery=="no"))
      title <- switch(input$nursery,
                      "1"=paste(title,"who attended Nursery"),
                      "2"=paste(title,"who did not attend Nursery"))
      
      data <- switch(input$romantic,
                   "1"=subset(data,romantic=="yes"),
                   "2"=subset(data,romantic=="no"))
      title <- switch(input$romantic,
                    "1"=paste(title,"(In a romantic relationship)"),
                    "2"=paste(title,"(Not in a romantic relationship)"))
                      
      

      
      
      plot_function(var = data, 
                  color = color, 
                  wbins = input$bins,
                  title_text=title)
    })
  }
)