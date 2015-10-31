# 
# Exploratory Data Analysis - Course Project 2
# 
# Script: plot6.R
# Author: Lars Hermes
#
# As the subject of the course is exploratory data analysis, I have decided not
# to encapsulate the code in functions, but to write it as an exploratory 
# analysis will take place.

library(plyr)
# read data from file
NEI <- readRDS("summarySCC_PM25.rds")
# filter data: only regarding Baltimore City (fips == "24510") and Los Angeles (fips == "06037")
all_BC_LA <- subset(NEI,NEI$fips %in% c("24510","06037"))
# give fips values meaningful names
all_BC_LA$fips <- as.factor(all_BC_LA$fips)
levels(all_BC_LA$fips) <- c("Los Angeles City","Balitmore City")
# read data from file
SCC <- readRDS("Source_Classification_Code.rds")
# filter for only motor vehicle classification codes
vehicle <- grep('Vehicle', SCC$EI.Sector)
vehicle_SCC <- SCC[vehicle,]
# filter emissions for only motor vehicle classification codes
all_vehicle_BC_LA <- subset(all_BC_LA,all_BC_LA$SCC %in% vehicle_SCC$SCC)
# aggregate emissions by year for Balitmore City and Los Angeles City
sum_by_year <- aggregate(Emissions ~ year + fips, data = all_vehicle_BC_LA, sum)
# open png file for printing
png(filename="plot6.png", width=480, height=480, units="px")
# create ggplot graph
graph <- ggplot(sum_by_year,aes(year,Emissions))
# anotate graph with regression line and meaningful title
graph <- graph + geom_point() + geom_smooth(method="lm",se=FALSE) + labs(title="Motor vehicle emissions")
# divide the two cities in separate facets 
graph <- graph + facet_grid(.~fips)
# print graph to png
print(graph)
# close device
dev.off()
