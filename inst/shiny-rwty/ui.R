shinyUI(fluidPage(
  titlePanel("Uploading Files"),
  sidebarLayout(
    sidebarPanel(
      fileInput('infiles', 'Choose file(s) to upload',
                multiple = TRUE,
                accept = c(
                  'text/plain',
                  '.tre',
                  '.trees',
                  '.t',
                  '.tree',
                  'text/csv',
                  'text/comma-separated-values',
                  'text/tab-separated-values',
                  'text/tsv',
                  '.p',
                  '.log',
                  '.csv',
                  '.tsv',
                  '.txt'
                )
      ),
      tags$hr(),
      selectInput("plot_select", label = "Parameter", choices = NULL)
    ),
    mainPanel(
      plotOutput('plots')
    )
  )
))
