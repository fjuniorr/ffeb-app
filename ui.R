library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
    titlePanel(em("Núcleo de Previsão de Receitas - FFEB")),
    
    sidebarLayout(
        sidebarPanel(h2("Parametrização"),
                    #fileInput("file", label = "Carregue sua série temporal"),
                               
                    selectInput("selectState", label = "Selecione um estado",
                                
                    choices = list("RJ" = "rj",
                    "SP" = "sp",
                    "ES" = "es",
                    "MG" = "mg",
                    "RR" = "rr",
                    "AP" = "ap")),
                               
                    checkboxGroupInput("selectTransformation", label = "Selecione as transformacões que serão aplicadas na série original",
                    choices = list("Tranformação logaritma" = "ln")),
                    #,"Primeira diferença" = "diff",
                    #"Dessazonalização" = "dessa",
                    #"Detrend" = "detrend")),
                               
                    selectInput("selectMethod", label = "Selecione um método de previsão",
                    choices = list("Nenhum" = 1,
                    "Passeio Aleatório" = 2,
                    "Alisamento Exponencial" = 3,
                    "ARIMA" = 4)),
                               
                    numericInput("selectForecast", label = "Número de passos a frente da previsão", value = 12, min = 1),
                               
                    #helpText("Selecione um método de previsão e o número de passos a frente para realizar previsões de receita"),
                    br(),
                    br(),
                    br(),
                    img(src = "ffeb-logo.bmp")),
                  
                  mainPanel(tabsetPanel(
                                tabPanel("Análise Exploratória",plotOutput("plot")),
                                tabPanel("Resíduos", plotOutput("residuos")),
                                tabPanel("Estatísticas", verbatimTextOutput("stats"))
                                
                                )
                           
                            )
    
        )

))
