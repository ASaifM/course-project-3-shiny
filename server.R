library(shiny)
library(ggplot2)

casualities <- read.csv("casualities.csv",sep=",",header = TRUE)
cost <- read.csv("cost.csv",sep=",",header = TRUE)

# Define server logic required to summarize and view the selected
# dataset
shinyServer(function(input, output) {
  
  output$scatter <- renderPlot({
    ggplot(cost[1:20,],
           aes(x=prod.actual,y=crop.actual,group=EVTYPE,color=EVTYPE))+
      geom_point()+
      geom_text(aes(label=EVTYPE),vjust=-2)+
      xlab("Products damage")+
      ylab("Crop damages")
  })
 
  

  output$fatalities <- renderPlot({
    fatalities <- casualities[with(casualities, order(-FATALITIES)), ]
    ggplot(fatalities[1:20,], aes(x = reorder(EVTYPE,-FATALITIES), y=FATALITIES))+
      geom_bar(stat='identity')+
      theme(axis.text.x = element_text(angle = 45, hjust = 1))+
      xlab("Event Type")
  })
  
  output$scatterfi <- renderPlot({
    min.Fatalities <- input$Fatalities[1]
    max.Fatalities <- input$Fatalities[2]
    min.Injuries <- input$Injuries[1]
    max.Injuries <- input$Injuries[2]
    casualities.plot <- casualities[casualities$FATALITIES >= min.Fatalities & 
                                      casualities$FATALITIES <= max.Fatalities &
                                      casualities$INJURIES >= min.Injuries &
                                      casualities$INJURIES <= max.Injuries,]
    
    ggplot(casualities.plot[1:20,],
           aes(x=FATALITIES ,y=INJURIES,group=EVTYPE,color=EVTYPE))+
      geom_point()+
      geom_text(aes(label=EVTYPE),vjust=-1.5)+xlab("Fatalities")+
      ylab("Injuries")
    
  
    
  })
  
  output$topFatalities <- renderPlot({
    min.Fatalities <- input$Fatalities[1]
    max.Fatalities <- input$Fatalities[2]
    casualities.plot <- casualities[casualities$FATALITIES >= min.Fatalities & 
                                      casualities$FATALITIES <= max.Fatalities,]
  
    fatalities <- casualities.plot[with(casualities.plot, order(-FATALITIES)), ]
    ggplot(fatalities[1:20,], aes(x = reorder(EVTYPE,-FATALITIES), y=FATALITIES))+
      geom_bar(stat='identity')+
      theme(axis.text.x = element_text(angle = 45, hjust = 1))+
      xlab("Event Type")
  })
  
  output$topInjuries <- renderPlot({
    min.Injuries <- input$Injuries[1]
    max.Injuries <- input$Injuries[2]
    casualities.plot <- casualities[casualities$INJURIES >= min.Injuries &
                                      casualities$INJURIES <= max.Injuries,]
    
    injuries <- casualities.plot[with(casualities.plot, order(-INJURIES)), ]
    ggplot(injuries[1:20,], aes(x = reorder(EVTYPE,-INJURIES), y=INJURIES))+
      geom_bar(stat='identity')+
      theme(axis.text.x = element_text(angle = 45, hjust = 1))+
      xlab("Event Type")
  })
  
  output$scatterpc <- renderPlot({
    min.Product <- input$ProductDamage[1]
    max.Product <- input$ProductDamage[2]
    min.Crop <- input$CropDamage[1]
    max.Crop <- input$CropDamage[2]
    cost.plot <- cost[cost$prod.actual >= min.Product & 
                        cost$prod.actual <= max.Product &
                        cost$crop.actual >= min.Crop &
                        cost$crop.actual <= max.Crop,]
    
    ggplot(cost.plot[1:20,],
           aes(x=prod.actual,y=crop.actual,group=EVTYPE,color=EVTYPE))+
      geom_point()+
      geom_text(aes(label=EVTYPE),vjust=-2)+
      xlab("Products damage")+
      ylab("Crop damages")
  })
  
  
  output$topProducts <- renderPlot({
    min.Product <- input$ProductDamage[1]
    max.Product <- input$ProductDamage[2]
    cost.plot <- cost[cost$prod.actual >= min.Product & 
                        cost$prod.actual <= max.Product,]
  
    prod_damage <- cost.plot[with(cost.plot, order(-prod.actual)), ]
    
    ggplot(prod_damage[1:20,], aes(x = reorder(EVTYPE,-prod.actual), y=prod.actual))+ 
      geom_bar(stat='identity')+
      theme(axis.text.x = element_text(angle = 45, hjust = 1))+
      xlab("Event type")+
      ylab("Products damage cost")
    
  })
  
  output$topCrops <- renderPlot({
    min.Crop <- input$CropDamage[1]
    max.Crop <- input$CropDamage[2]
    cost.plot <- cost[cost$crop.actual >= min.Crop &
                        cost$crop.actual <= max.Crop,]
    
    crop_damage <- cost.plot[with(cost.plot, order(-crop.actual)), ]
    
    ggplot(crop_damage[1:20,], aes(x = reorder(EVTYPE,-crop.actual), y=crop.actual))+ 
      geom_bar(stat='identity')+
      theme(axis.text.x = element_text(angle = 45, hjust = 1))+
      xlab("Event Type")+
      ylab("Crops Damage Cost")
  })
    
 

})
