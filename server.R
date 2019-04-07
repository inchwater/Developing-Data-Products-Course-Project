#
#
library(dplyr)
library(plyr)
library(xlsx)
library(boot)
library(ggplot2)

setwd("C:/Users/Siddharth/Documents/Careers/Siddharth/DataScienceSpecialization/Developing Data Products/Week 4/Course Project/Data")

##Read public data for the year 2014
public_14 <- read.xlsx("./2014/wcms1p-152899 (2014 Public).xlsx", sheetIndex = 1)

public_14 <- public_14 %>% dplyr::rename(propertytype = Primary.Property.Type...Self.Selected, barea = Floor.Area..Buildings...Parking...ftÂ².)

public_14 <- public_14 %>% dplyr::rename(totalGHC = Total.GHG.Emissions..Metric.Tons.CO2e., siteEUI = Site.EUI..kBtu.ftÂ²., sourceEUI = Source.EUI..kBtu.ftÂ².)

public_14 <- public_14 %>% dplyr::rename(wnsiteEUI = Weather.Normalized.Site.EUI..kBtu.ftÂ²., wnsourceEUI = Weather.Normalized.Source.EUI..kBtu.ftÂ².)

##Removing NA columns from public_14
public_14 <- public_14[,-c(14:15)]

##Adding variables for parking area and water use so that we end up with the same number of columns as public_15 & public_16 for building a combined public data frame
public_14$wateruse <- NA
public_14$parea <- NA

public_14_a <- select(public_14,1:7)
public_14_b <- select(public_14, 8:15)
public_14 <- cbind(public_14_a, public_14$parea, public_14_b)
public_14 <- public_14[,-16]

public_14 <- public_14 %>% dplyr::rename(parea = `public_14$parea`)
public_14$year <- "2014"


##Read public data for the year 2015
public_15 <- read.xlsx("./2015/wcmsp-185933 (2015 Public).xlsx", sheetIndex = 1)

public_15 <- public_15 %>% dplyr::rename(propertytype = Primary.Property.Type, barea = Floor.Area..Buildings...ftÂ²., parea = Floor.Area..Parking...ftÂ².)

public_15 <- public_15 %>% dplyr::rename(totalGHC = Total.GHG.Emissions..Metric.Tons.CO2e., siteEUI = Site.EUI..kBtu.ftÂ²., sourceEUI = Source.EUI..kBtu.ftÂ².)

public_15 <- public_15 %>% dplyr::rename(wnsiteEUI = Weather.Normalized.Site.EUI..kBtu.ftÂ²., wnsourceEUI = Weather.Normalized.Source.EUI..kBtu.ftÂ².)

public_15 <- public_15 %>% dplyr::rename(wateruse = Water.Use..kgal.)

public_15$year <- "2015"

##Read public data for the year 2016
public_16 <- read.xlsx("./2016/wcmsp-213780 (2016 Public).xlsx", sheetIndex = 1)

public_16 <- public_16 %>% dplyr::rename(propertytype = Primary.Property.Type, barea = Floor.Area..Buildings...ftÂ²., parea = Floor.Area..Parking...ftÂ².)

public_16 <- public_16 %>% dplyr::rename(totalGHC = Total.GHG.Emissions..Metric.Tons.CO2e., siteEUI = Site.EUI..kBtu.ftÂ²., sourceEUI = Source.EUI..kBtu.ftÂ².)

public_16 <- public_16 %>% dplyr::rename(wnsiteEUI = Weather.Normalized.Site.EUI..kBtu.ftÂ²., wnsourceEUI = Weather.Normalized.Source.EUI..kBtu.ftÂ².)

public_16 <- public_16 %>% dplyr::rename(wateruse = Water.Use..kgal.)

public_16$year <- "2016"

##Read public data for 2017
public_17 <- read.xlsx("./2017/wcmsp-214687 (2017 Public).xlsx", sheetIndex = 1)

public_17 <- public_17 %>% dplyr::rename(propertytype = Primary.Property.Type, barea = Floor.Area..Buildings...ftÂ²., parea = Floor.Area..Parking...ftÂ².)

public_17 <- public_17 %>% dplyr::rename(siteEUI = Site.EUI..kBtu..ftÂ²., sourceEUI = Source.EUI..kBtu.ftÂ².)

public_17 <- public_17 %>% dplyr::rename(wnsiteEUI = Weather.Normalized.Site.EUI..kBtu.ftÂ²., wnsourceEUI = Weather.Normalized.Source.EUI..kBtu.ftÂ².)

public_17 <- public_17 %>% dplyr::rename(wateruse = Water.Use..kgal.)

##Read private data for 2015
private_15 <- read.xlsx("./2015/wcmsp-185935 (2015 Private).xlsx", sheetIndex = 1)

private_15 <- private_15 %>% dplyr::rename(propertytype = Primary.Property.Type, barea = Floor.Area..Building...ftÂ²., parea = Floor.Area..Parking...ftÂ².)

private_15 <- private_15 %>% dplyr::rename(siteEUI = Site.EUI..kBtu.ftÂ²., sourceEUI = Source.EUI..kBtu.ftÂ².)

private_15 <- private_15 %>% dplyr::rename(wnsiteEUI = Weather.Normalized.Site.EUI..kBtu.ftÂ²., wnsourceEUI = Weather.Normalized.Source.EUI..kBtu.ftÂ².)

private_15 <- private_15 %>% dplyr::rename(wateruse = Water.Use..kgal.)

private_15$year <- "2015"

##Read private data for 2016
private_16 <- read.xlsx("./2016/wcmsp-204776 (2016 Private).xlsx", sheetIndex = 1)

private_16 <- private_16 %>% dplyr::rename(propertytype = Primary.Property.Type, barea = Floor.Area..Building...ftÂ²., parea = Floor.Area..Parking...ftÂ².)

private_16 <- private_16 %>% dplyr::rename(siteEUI = Site.EUI..kBtu.ftÂ²., sourceEUI = Source.EUI..kBtu.ftÂ².)

private_16 <- private_16 %>% dplyr::rename(wnsiteEUI = Weather.Normalized.Site.EUI..kBtu.ftÂ²., wnsourceEUI = Weather.Normalized.Source.EUI..kBtu.ftÂ².)

private_16 <- private_16 %>% dplyr::rename(wateruse = Water.Use..kgal.)

private_16$year <- "2016"

##Read private data for 2017
private_17 <- read.xlsx("./2017/wcmsp-213782 (2017 Private).xlsx", sheetIndex = 1)

private_17 <- private_17 %>% dplyr::rename(propertytype = Primary.Property.Type, barea = Floor.Area..Buildings...ftÂ²., parea = Floor.Area..Parking...ftÂ².)

private_17 <- private_17 %>% dplyr::rename(siteEUI = Site.EUI..kBtu.ftÂ²., sourceEUI = Source.EUI..kBtu.ftÂ².)

private_17 <- private_17 %>% dplyr::rename(wnsiteEUI = Weather.Normalized.Site.EUI..kBtu.ftÂ²., wnsourceEUI = Weather.Normalized.Source.EUI..kBtu.ftÂ².)

private_17 <- private_17 %>% dplyr::rename(wateruse = Water.Use..kgal.)

##Merge the data for public buildings for 2014, 2015 and 2016

public_141516 <- rbind(public_14, public_15, public_16)

##Remove last two columns of private_16 since we don't need them
private_16 <- private_16[,-c(14,15)]
private_1516 <-  rbind(private_15, private_16)

##Filter the property types where the number of instances available is greater than 10 so we have a reasonable number of data points to build a model.
##Note that there may be property addresses that could be repeated if they have data available for 2014, 2015 and 2016
fpublic_141516 <- filter(public_141516, propertytype == "Parking" | propertytype == "Other - Entertainment/Public Assembly" | 
                                 propertytype == "Office" | propertytype == "K-12 School")
mean_public <- ddply(fpublic_141516, .(propertytype,year), summarise, meanEUI = mean(wnsiteEUI))

mean_school <- filter(mean_public, propertytype == "K-12 School")
mean_office <- filter(mean_public, propertytype == "Office")
mean_park <- filter(mean_public, propertytype == "Parking")
mean_passembly <- filter(mean_public, propertytype == "Other - Entertainment/Public Assembly")

##Filter the property types where the number of instances available is greater than 10 so we have a reasonable number of data points to build a model.
##Note that there may be property addresses that could be repeated if they have data available for 2014, 2015 and 2016
count <- plyr::count(private_1516$propertytype)
ptype_25more <- count[count$freq > 25,]
fprivate_1516 <- private_1516 %>% filter(propertytype == "Hotel" | propertytype == "Mixed Use Property" | propertytype == "Office" | 
                                                 propertytype == "Parking")

mean_private <- ddply(fprivate_1516, .(propertytype,year), summarise, meanEUI = mean(wnsiteEUI))

mean_hotel <- filter(mean_private, propertytype == "Hotel")
mean_muse <- filter(mean_private, propertytype == "Mixed Use Property")
mean_poffice <- filter(mean_private, propertytype == "Office")
mean_ppark <- filter(mean_private, propertytype == "Parking")


library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        plotcat <- reactive({
                if (input$ptype == "public" & input$btype == "school"){
                        mean_school
                }
                else if (input$ptype == "public" & input$btype == "office"){
                        mean_office
                }
                else if (input$ptype == "public" & input$btype == "park"){
                        mean_park
                }
                else if (input$ptype == "public" & input$btype == "Other - Entertainment/Public Assembly"){
                        mean_passembly
                }
                else if (input$ptype == "private" & input$btype == "hotel"){
                        mean_hotel
                }
                else if (input$ptype == "private" & input$btype == "muse"){
                        mean_muse
                }
                else if (input$ptype == "private" & input$btype == "park"){
                        mean_ppark
                }
                else if (input$ptype == "private" & input$btype == "office"){
                        mean_poffice
                }
        })
        
        output$plot <- renderPlot({
                ggplot(plotcat(), aes(x = year, y = meanEUI, group = propertytype)) + geom_point() + geom_line()
            })
        }
       

                
             
        )
        
        
#shinyApp(ui = ui, server = server)
