library(shiny)
library(forecast)
library(ffeb)

load("./data/rcl_estados.rda")

rcl <- ts(rcl_estados[, -(1:2)], start = c(2003, 1), frequency = 12)

rcl <- cbind(rcl, log(rcl[, "rj"]), diff(rcl[, "rj"]), diff(log(rcl[, "rj"])))

colnames(rcl)[7:9] <- c("ln_rj", "diff_rj", "ln_diff_rj")

# paste("rj", paste(c("ln", "diff"), collapse = "_"), sep = "_")


shinyServer(function(input, output) {
    
    output$plot <- renderPlot({
              
      plot(rcl_estados[, input$selectState])
      
#           par(mfrow=c(1,2))
#           plot(rcl_estados[, paste(input$selectState, paste(input$selectTransformation, collapse = "_"), sep = "_")], ylab = "RCL", xlab = "Mês")    
#           Acf(rcl_estados[, ], lag.max=36, main="")
            
        
        
        
    })    
    
    output$residuos <- renderPlot({
        
        if("log" %in% input$selectTransformation) {
            
            hist(log(rcl_estados[, input$selectState]), prob = TRUE)
            rug(log(rcl_estados[, input$selectState]))
            lines(density(log(rcl_estados[, input$selectState])))
                 
        } else {
            
            hist(rcl_estados[, input$selectState], prob = TRUE)
            rug(rcl_estados[, input$selectState])
            lines(density(rcl_estados[, input$selectState]))
            
        }
        
    })
        
        
    output$stats <- renderPrint({
        if("log" %in% input$selectTransformation) {
            x <- 1:length(log(rcl_estados[, input$selectState]))
            summary(lm(log(rcl_estados[, input$selectState]) ~ x))
            
        } else {
            x <- 1:length(rcl_estados[, input$selectState])
            summary(lm(rcl_estados[, input$selectState] ~ x))    
            
        }
    })    

})

