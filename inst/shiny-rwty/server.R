# By default, the file size limit is 5MB. It can be changed by
# setting this option. Here we'll raise limit to 9MB.
options(shiny.maxRequestSize = 9 * 1024 ^ 2)

shinyServer(function(input, output) {
  output$plots <- renderUI({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    infiles <- input$infiles
    
    if (is.null(infiles) || nrow(infiles) < 1)
      return(NULL)
    
    trees <- infiles$datapath[grep("\\.t$", infiles$name)]
    logs <- infiles$datapath[grep("\\.p$", infiles$name)]
    
    chains <- load.trees(trees, format = "mb", logfile = logs)
    all_plots <- makeplot.all.params(chains, strip = 1)
    print("done")
    plot_output_list <- lapply(1:length(all_plots), function(i) {
      plotname <- paste0("plot", i)
      plotOutput(plotname, height = 280, width = 250)
    })
    for (i in length(all_plots)) {
      local({
        my_i <- i
        plotname <- paste0("plot", my_i)
        output[[plotname]] <- renderPlot({
          print(all_plots[[my_i]])
        })
      })
    }
    do.call(tagList, plot_output_list)
  })
  
  
})
