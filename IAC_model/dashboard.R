# Load necessary libraries
library(shiny)
library(ggplot2)
library(dplyr)

# Define UI
ui <- fluidPage(
  titlePanel("Activation Values of Nodes Over Iterations"),
  sidebarLayout(
    sidebarPanel(
      selectizeInput("selected_node", "Select a Node:", choices = node_names, multiple = FALSE)
    ),
    mainPanel(
      plotOutput("activationPlot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  output$activationPlot <- renderPlot({
    # Filter data based on selected node using dplyr
    filtered_data <- activation_data %>%
      filter(NodeName == input$selected_node)
    
    ggplot(filtered_data, aes(x = Iteration, y = ActivationValue, color = NodeName)) +
      geom_line() +
      geom_point() +
      labs(title = paste("Activation Values of Node", input$selected_node, "Over Iterations"),
           x = "Iteration",
           y = "Activation Value",
           color = "Node") +
      theme_minimal()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
