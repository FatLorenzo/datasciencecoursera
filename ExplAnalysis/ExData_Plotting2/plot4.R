# 
# Exploratory Data Analysis - Course Project 2
# 
# Script: plot4.R
# Author: Lars Hermes
#
# As the subject of the course is exploratory data analysis, I have decided not
# to encapsulate the code in functions, but to write it as an exploratory 
# analysis will take place.

library(plyr)
# read data from file
NEI <- readRDS("summarySCC_PM25.rds")
# read data from file
SCC <- readRDS("Source_Classification_Code.rds")
# filter for only coal combustion classification codes
coal <- grep('Coal', SCC$EI.Sector)
coal_SCC <- SCC[coal,]
# filter emissions for only coal combustion classification codes
all_coal <- subset(NEI,NEI$SCC %in% coal_SCC$SCC)
# aggregate emissions by year for the U.S.
sum_by_year <- aggregate(Emissions ~ year, data = all_coal, sum)
# open png file for printing
png(filename="plot4.png", width=480, height=480, units="px")
# create ggplot graph
graph <- ggplot(sum_by_year,aes(year,Emissions))
# anotate graph with regression line and meaningful title
graph <- graph + geom_point() + geom_smooth(method="lm",se=FALSE) + labs(title="Coal combustion emissions in the U.S.")
# print graph to png
print(graph)
# close device
dev.off()