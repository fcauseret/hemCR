# Load Packages
library(shiny)
library(Seurat)
library(ggplot2)
library(MetBrewer)
library(cowplot)
library(RColorBrewer)
library(bslib)

setwd("/srv/shiny-server/mouse_hem")

# Load environment
load("./Environment_for_Hem_ShinyApp.RData", envir = .GlobalEnv)




##### Define UI #####
ui <- fluidPage(
  tags$head(includeHTML(("google-analytics.html"))),
 # Title and details about the App  
  #shinythemes::themeSelector(),
  theme = bs_theme(version = 4, bootswatch = "flatly"), #flatly, simplex or spacelab
    tags$h2("Transcriptional landscape around the early mouse hem"),
  tags$img(src = "header.png", height = 150),
  tags$br(),
  tags$p("This App allows to explore data from our study: ", style = "font-size:10pt"),
tags$p(tags$strong("Moreau MX, Saillour Y, Elorriaga V, Bouloudi B, Delberghe E, Deutsch Guerrero T, Ochandorena-Saa A, Maeso-Alonso L, Marques MM, Marin MC, Spassky N, Pierani A and Causeret F. "), 
         "(2023). Repurposing of the multiciliation gene regulatory network in fate specification of Cajal-Retzius neurons. ",
         tags$em("Developmental Cell "),
         "58(15):1365-1382 ",tags$a(href = "http://dx.doi.org/10.1016/j.devcel.2023.05.011",
         "[Click here to find the article]", target="_blank"), style = "font-size:8pt"), 
tags$p("Raw data and R codes used to generate the figures can be found ",
         tags$a(href = "https://fcauseret.github.io/hemCR/", "here", target="_blank"), style = "font-size:8pt"),
  
  
  tags$hr(),
  tags$h4("Browse the data"),  
  
 
  # Gene selection panel
  wellPanel(
    fluidRow(
    column(10, selectizeInput(inputId = "genes",
                             label = NULL,
                             choices = NULL,
                             width = "100%",
                             multiple = T,
                             options = list('plugins' = list('remove_button'), #maxOptions = 5, maxItems = 12,
                                            placeholder = 'Please select genes',
                                            'persist' = FALSE
                                            )
                             )
           ),
    column(2, actionButton("reset", "Clear")))),
  
  # Tabs to display the output plots
 tabsetPanel(
    tabPanel("Full dataset", 
             tags$em("As in Fig. S1B of the manuscript   "), tags$p(""), tags$img(src = "legend_spring.jpg", height = 30), tags$p(""),
             checkboxInput("order", "order = TRUE", value = T),
             checkboxInput("downsample.spring", "downsample (runs faster)", value = F),
             plotOutput("spring")),
    
    tabPanel("Custom signature", 
             tags$em("As in Fig. 2C of the manuscript   "), tags$p(""), tags$img(src = "legend_signature.jpg", height = 30),  tags$p(""),
             checkboxInput("downsample.signature", "downsample (runs faster)", value = T),
             plotOutput("signature")),
    
    tabPanel("Violin plot", 
             tags$em("As in Fig. 1B of the manuscript"),  tags$p(""),
             checkboxInput("vln.pt", "show points", value = F),
             plotOutput("violin")),
    
    tabPanel("Bubble plot", 
             tags$em("As in Fig. 1C of the manuscript"),  tags$p(""), 
             plotOutput("bubble")),
    
    tabPanel("Neuronal trajectories",
             tags$em("As in Fig. S1D of the manuscript   "), tags$p(""), tags$img(src = "legend_neuro_traj.jpg", height = 15), tags$p(""),
             checkboxInput("neuro.pt", "show points", value = T),
             checkboxInput("downsample.neuro", "downsample (runs faster)", value = T),
             plotOutput("neuro")),
    
    tabPanel("ChP trajectory",
             tags$em("As in Fig. 7B of the manuscript   "), tags$p(""), tags$img(src = "legend_chp_traj.jpg", height = 18),  tags$p(""),
             checkboxInput("chp.pt", "show points", value = T),
             checkboxInput("downsample.chp", "downsample (runs faster)", value = T),
             plotOutput("ChP"))
    )
    
)

##### Define server #####
server <- function(input, output, session){
  
 # bs_themer()
  
  updateSelectizeInput(session, "genes", choices = genes.Hem, selected = c("Foxg1", "Trp73", "Ttr"), server = TRUE)
  
  observeEvent(input$reset, {
    updateSelectizeInput(session, "genes", choices = genes.Hem, selected = NULL, server = TRUE)
  })  

 
  # Spring plot of the full dataset
  output$spring <- renderPlot({ if (is.null(input$genes)) return()
    ifelse(input$downsample.spring == T,
           p1 <- FeaturePlot(object = Hem_downsampled,
                       features = input$genes,
                       reduction = "spring",
                       cols = c("grey90",brewer.pal(9,"YlGnBu")),
                       order = input$order,
                       pt.size = 0.3,
                       ncol = 3) & theme(title = element_text(size = 12)) & NoLegend() & NoAxes(),
           
           p1 <- FeaturePlot(object = Hem,
                       features = input$genes,
                       reduction = "spring",
                       cols = c("grey90",brewer.pal(9,"YlGnBu")),
                       order = input$order,
                       pt.size = 0.3,
                       ncol = 3) & theme(title = element_text(size = 12)) & NoLegend() & NoAxes()
    )
   return(p1)
      }, width = 1000, height = reactive({350 * ceiling(length(input$genes)/3) +1 }) 
    )
    
  # Signature plot of the full dataset
  output$signature <- renderPlot({ if (is.null(input$genes)) return()
    ifelse(input$downsample.signature == T,
           p1 <- SignaturePlot(Dataset = Hem_downsampled, genes = input$genes) + ggtitle("Signature score")  + theme(title = element_text(size = 12)) & NoLegend() & NoAxes(),
           p1 <- SignaturePlot(Dataset = Hem, genes = input$genes) + ggtitle("Signature score")  + theme(title = element_text(size = 12)) & NoLegend() & NoAxes()
    )
    return(p1)
  }, width = 500, height = 500  )
  
  
  # Violin plot
    output$violin <- renderPlot({ if (is.null(input$genes)) return()
    VlnPlot(object = Hem,
                features = input$genes,
                cols = met.brewer("Renoir")[c(8, 7, 3, 5, 9:12)],
                ncol = 3,
                pt.size = ifelse(input$vln.pt == T, 0.1, 0)) & NoLegend() &
      scale_x_discrete(labels = c("DP prog.", "MP prog.","Cortical Plate" ,"Cajal-Retzius",   "Hem prog.", "ThE prog.", "ChP prog." ,"ChP"),
                       limits = c("Dorso-Medial_pallium", "Medial_pallium", "Pallial_neurons", "Cajal-Retzius_neurons", "Hem", "Thalamic_eminence", "ChP_progenitors", "ChP")) &
      theme(title = element_text(size = 12),
            axis.title.x=element_blank(),
            axis.ticks.x=element_blank() )
  }, width = 1000, height = reactive({250 * ceiling(length(input$genes)/3) +1 })  )
  
    # Bubble plot
      output$bubble <- renderPlot({ if (is.null(input$genes)) return()
    DotPlot(Hem,
            features = input$genes,
            dot.min = 0.05,
            col.max = 2,
            col.min = -1,
            dot.scale = 12) +
      RotatedAxis() +
      scale_y_discrete(limits=rev, labels = c("ChP", "ChP prog.", "ThE prog.", "Hem prog.", "MP prog.", "DP prog.", "Cortical Plate" ,"Cajal-Retzius" )) +
      scale_x_discrete(position = "top") +
      theme(axis.text.x = element_text(hjust=0),
            axis.title.x=element_blank(),
            axis.ticks.x=element_blank(),
            axis.title.y=element_blank(),
            axis.ticks.y=element_blank(),
            legend.margin=margin(0,0,0,0),
            legend.box.margin=margin(50,50,50,50)) +
      scale_color_gradientn(colors =  brewer.pal("RdPu", n=9))
      }, width = reactive({400 + 40 * length(input$genes) }), height = 350)

      # Gene expression along neuronal trajectories
        output$neuro <- renderPlot({ if (is.null(input$genes)) return()
    ifelse(input$downsample.neuro == T,
           Plot.genes.trend.neuro(Dataset = Neuro.traj_downsampled,
                                  genes = input$genes,
                                  show.pt = input$neuro.pt),
           
           Plot.genes.trend.neuro(Dataset = Neuro.traj,
                                  genes = input$genes,
                                  show.pt = input$neuro.pt)
    )
    }, width = 1000, height = reactive({200 * ceiling(length(input$genes)/3) +1 })
    )
    
        # Gene expression along choroid trajectory
          output$ChP <- renderPlot({ if (is.null(input$genes)) return()
      ifelse(input$downsample.chp == T,
             Plot.genes.trend.ChP(ChP.traj_downsampled, genes = input$genes, show.pt = input$chp.pt),
             Plot.genes.trend.ChP(ChP.traj, genes = input$genes, show.pt = input$chp.pt)
      )
      }, width = 1000, height = reactive({200 * ceiling(length(input$genes)/3) +1 })
      )
  
  
}

# Create shinyApp object
shinyApp(ui,server)
