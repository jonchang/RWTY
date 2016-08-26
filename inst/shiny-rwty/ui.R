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
      checkboxInput('header', 'Header', TRUE),
      radioButtons('sep', 'Separator',
                   c(Comma=',',
                     Semicolon=';',
                     Tab='\t'),
                   ','),
      radioButtons('quote', 'Quote',
                   c(None='',
                     'Double Quote'='"',
                     'Single Quote'="'"),
                   '"'),
      tags$hr(),
      p('If you want a sample .csv or .tsv file to upload,',
        'you can first download the sample',
        a(href = 'mtcars.csv', 'mtcars.csv'), 'or',
        a(href = 'pressure.tsv', 'pressure.tsv'),
        'files, and then try uploading them.'
      )
    ),
    mainPanel(
      uiOutput('plots')
    )
  )
))
