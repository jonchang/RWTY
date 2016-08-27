library(rwty)

# By default, the file size limit is 5MB. It can be changed by
# setting this option. Here we'll raise limit to 9MB.
options(shiny.maxRequestSize = 9 * 1024 ^ 2)

shinyServer(function(input, output, clientData, session) {
  sessionvars <- reactiveValues(L1_cur = NULL, L2_cur = NULL)
  
  dataset <- reactive({
    infiles <- input$infiles
    if (is.null(infiles) || nrow(infiles) < 1)
      return(NULL)
    
    trees <- infiles$datapath[grep("\\.t$", infiles$name)]
    logs <- infiles$datapath[grep("\\.p$", infiles$name)]
    
    chains <- load.trees(trees, format = "mb", logfile = logs)
    res <- analyze.rwty(chains, strip = 1)
    updateSelectInput(session, "plot_select", choices = names(res), selected = names(res[1]))
    print("done")
    res
  })
  
  output$plots <- renderPlot({
    plots <- dataset()
    if (is.null(plots)) return(NULL)
    print(names(plots))
    print(plots[[input$plot_select]])
    print(plots[[input$plot_select]][[1]])
  })
  
})
