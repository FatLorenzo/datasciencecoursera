# 
# Exploratory Data Analysis - Course Project 2
# 
# Script: plot3.R
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
# aggregate emissions by year for Baltimore City
sum_by_year_BC <- aggregate(Emissions ~ year + type, data = all_BC, sum)
# open png file for printing
png(filename="plot3.png", width=480, height=480, units="px")
# create ggplot graph
graph <- ggplot(sum_by_year_BC,aes(year,Emissions))
# anotate graph with regression line and meaningful title
graph <- graph + geom_point() + geom_smooth(method="lm",se=FALSE) + labs(title="Total emissions in Baltimore City")
# divide type in separate facets 
graph <- graph + facet_grid(.~type)
# print graph to png
print(graph)
# close device
dev.off()
