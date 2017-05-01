# Show a spinning "loading" animation while a plot is recalculating. Do not show spinner if plot is not displayed.

This example adds a bit of shiny JS event handling to the plot-spinner example to hide the spinner in cases when the plot is not displayed. Can be used for any kind of UI output and a simple wrapper function is given that you can 'pipe' your output into.

The idea is to listen for shiny::error / shiny::value event to hide the spinner when the plot is not shown / shown, whilst displaying the spinner when shiny::recalculating is triggered.


---

[![Demo](./plot-spinner.gif)](./plot-spinner.gif)