# By default, the file size limit is 5MB. It can be changed by
# setting this option. Here we'll raise limit to 9MB.
options(shiny.maxRequestSize = 9*1024^2)

shinyServer(function(input, output) {
  output$contents <- renderPlot({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.

    infiles <- input$infiles

    if (is.null(infiles) || nrow(infiles) < 1) return(NULL)
    
    trees <- infiles$datapath[grep("\\.t$", infiles$name)]
    logs <- infiles$datapath[grep("\\.p$", infiles$name)]
    
    chains <- load.trees(trees, format = "mb", logfile = logs, skip = 0, gens.per.tree = 100)
    test.output <- analyze.rwty(chains, window.num=4, treespace.points=4, autocorr.intervals = 4, burnin=0)
    test.output
  })
})
