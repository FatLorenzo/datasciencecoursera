# 
# Exploratory Data Analysis - Course Project 2
# 
# Script: plot5.R
# Author: Lars Hermes
#
# As the subject of the course is exploratory data analysis, I have decided not
# to encapsulate the code in functions, but to write it as an exploratory 
# analysis will take place.

library(plyr)
# read data from file
NEI <- readRDS("summarySCC_PM25.rds")
# filter data: only regarding Baltimore City (fips == "24510")
all_BC <- subset(NEI,NEI$fips == "24510")
# read data from file
SCC <- readRDS("Source_Classification_Code.rds")
# filter for only motor vehicle classification codes
vehicle <- grep('Vehicle', SCC$EI.Sector)
vehicle_SCC <- SCC[vehicle,]
# filter emissions for only motor vehicle classification codes
all_vehicle_BC <- subset(all_BC,all_BC$SCC %in% vehicle_SCC$SCC)
# aggregate emissions by year for Balitmore City
sum_by_year <- aggregate(Emissions ~ year, data = all_vehicle_BC, sum)
# open png file for printing
png(filename="plot5.png", width=480, height=480, units="px")
# create ggplot graph
graph <- ggplot(sum_by_year,aes(year,Emissions))
# anotate graph with regression line and meaningful title
graph <- graph + geom_point() + geom_smooth(method="lm",se=FALSE) + labs(title="Motor vehicle emissions in Baltimore City")
# print graph to png
print(graph)
# close device
dev.off()