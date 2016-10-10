

library(shiny)

# Define UI for dataset viewer application
shinyUI(navbarPage("Weather Events Analysis",
                   tabPanel("Documentation",
                            fluidPage(
                              titlePanel("Application Overview"),
                              mainPanel(
                                h3("Introduction"),
                                p("This application provides an overview of the catastrophies
                                caused by major storms and weather events in the USA. They are divided into:"),
                                HTML("
                                       <ol>
                                            <li>
                                                  Casualities
                                                  <ol>
                                                    <li>
                                                       Fatalities
                                                    </li>
                                                    <li>
                                                      Injuries
                                                    </li>
                                                  </ol>
          
                                            </li>
                                            <li>
                                                  Damages
                                                  <ol>
                                                    <li>
                                                      Products Damages
                                                    </li>
                                                    <li>
                                                      Crops Damages
                                                    </li>
                                                  </ol>
                                            </li>
                                       </ol>
                                     "),
                                h3("Controls"),
                               
                                h4("Tabs"),
                                p("There are three clickable tabs in the application.
                                   The first is for the application's documentation.
                                   The second is for the casualities while the third
                                   is for cost of the damages."),
                                img(src="./tabs.png"),
                                
                                h4("Sliders"),
                                p("Sliders are used to control the range of the x-axis
                                  (and possibly the y-axis) for the graphs available in
                                  the application. They maintain lower and upper limits
                                  for each variable they control."),
                                img(src="./sliders.png"),
                                h3("Graphs"),
                                h4("Scatter Plots"),
                                p("They display top events with respect to two variables. Here
                                  is an example for the variables: Products Damage and Crops Damage"),
                                plotOutput("scatter"),
                                h4("Bar Charts"),
                                p("They display top events with respect to one variable. Here
                                  is an example for the variable: Fatalities"),
                                plotOutput("fatalities")
                            ))
                            ),
                   tabPanel("Casualities",
                            fluidPage(
                              
                              # Application title
                              titlePanel("Storm Casualities"),
                              
                              # Sidebar with controls to select a dataset and specify the
                              # number of observations to view
                              sidebarLayout(
                                sidebarPanel(
                                  h4('Fatalities'),
                                  sliderInput("Fatalities", "Range:",
                                              min = 0, max = 6000, value = c(0,6000)),
                                  h4('Injuries'),
                                  sliderInput("Injuries", "Range:",
                                              min = 0, max = 100000, value = c(0,100000))
                                ),
                                
                                # Show a summary of the dataset and an HTML table with the 
                                # requested number of observations
                                mainPanel(
                                  h4("Top Events with Respect to Fatalities and Injuries"),
                                  plotOutput("scatterfi"),
                                  h4("Top Events with Respect to Fatalities"),
                                  plotOutput("topFatalities"),
                                  h4("Top Events with Respect to Injuries"),
                                  plotOutput("topInjuries")
                                  
                                )
                              )
                            )),
                   tabPanel("Costs",
                            fluidPage(
                              
                              # Application title
                              titlePanel("Storm Damages"),
                              
                              # Sidebar with controls to select a dataset and specify the
                              # number of observations to view
                              sidebarLayout(
                                sidebarPanel(
                                  h4('Product Damage Costs'),
                                  sliderInput("ProductDamage", "Range:",
                                              min = 0, max = 150000000000, value = c(0,150000000000)),
                                  h4('Crop Damage Costs'),
                                  sliderInput("CropDamage", "Range:",
                                              min = 0, max = 5500000000, value = c(0,5500000000))
                                ),
                                
                                # Show a summary of the dataset and an HTML table with the 
                                # requested number of observations
                                mainPanel(
                                  h4("Top Events with Respect to Product and Crop Damages"),
                                  plotOutput("scatterpc"),
                                  h4("Top Events with Respect to Product Damages"),
                                  plotOutput("topProducts"),
                                  h4("Top Events with Respect to Crop damages"),
                                  plotOutput("topCrops")
                                )
                              )
                            ))
  
))
