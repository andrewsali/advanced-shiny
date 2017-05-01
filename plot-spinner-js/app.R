library(shiny)

#' Add a spinner that shows when an output is recalculating
#' @param ui_element A UI element that should be wrapped with a spinner when the corresponding output is being calculated.
withSpinner <- function(ui_element) {
  tagList(
    shiny::singleton(
      tags$head(tags$link(rel="stylesheet",href="spinner.css"))
    ),
    shiny::singleton(
      tags$script(src="spinner.js")
    ),
    div(class="shiny-spinner-output-container",
        div(class="shiny-spinner-spinner-container",
            tags$img(
              class="shiny-spinner-loading-spinner",
              src="spinner.gif")
            
        ),
        ui_element
    )
  )
}

ui <- fluidPage(
  tags$b("This example shows the loading spinner whilst the plot is loading and hides the spinner when the plot is not shown. You can use it to wrap any kind of output."),
  checkboxInput("show_plot","Show plot",value=FALSE),
  actionButton("redraw_plot","Re-draw plot"),
  h3("With spinner"),
  withSpinner(plotOutput("example")), #if you have tidyverse loaded, you could do plotOutput("example") %>% withSpinner()
  h3("Without spinner"),
  plotOutput("example_nospinner")
)

server <- function(input, output,session) {
  output$example_nospinner <- output$example <- renderPlot({
    validate(need(input$show_plot,"Show plot is unchecked. Check to see plot."))
    input$redraw_plot
    Sys.sleep(5) # just for demo so you can enjoy the animation
    plot(
      x = runif(1e4), y = runif(1e4)
    )
  })
  outputOptions(output,"example",priority=1)
}

shinyApp(ui = ui, server = server)
