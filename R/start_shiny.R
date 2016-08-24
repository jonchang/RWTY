#' Start the RWTY Shiny web app
#'
#' Runs the RWTY Shiny web app, for interactive visualization of convergence.
#' 
#' @param ... arguments passed to \code{\link[shiny]{shiny::runApp}}
#' @export
#'
#' @examples
#' \dontrun{
#' run_shiny()
#' }
run_shiny <- function(...) {
  if (!requireNamespace("shiny", quietly = TRUE)) {
    stop("Shiny is not installed. Install the `shiny` package with:\n  install.packages('shiny')")
  }
  app <- system.file("shiny-rwty", package = "rwty")
  if (app == "") {
    stop("Could not find the shiny-app directory. Try re-installing `rwty`.", call. = FALSE)
  }
  
  shiny::runApp(app, display.mode = "normal", ...)
}