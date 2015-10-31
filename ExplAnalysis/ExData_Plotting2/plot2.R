# 
# Exploratory Data Analysis - Course Project 2
# 
# Script: plot2.R
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
sum_by_year_BC <- aggregate(Emissions ~ year, data = all_BC, sum)
# open png file for printing
png(filename="plot2.png", width=480, height=480, units="px")
# plot emissions by year
with(sum_by_year_BC,plot(year,Emissions,pch = 19))
# add a meaningful title
title(main = "Total Emissions in Baltimore City")
# add a regression line to show the tendency
abline(lm(Emissions ~ year, data = sum_by_year_BC), col = "blue")
# close device
dev.off()