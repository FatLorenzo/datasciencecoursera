# 
# Exploratory Data Analysis - Course Project 2
# 
# Script: plot1.R
# Author: Lars Hermes
#
# As the subject of the course is exploratory data analysis, I have decided not
# to encapsulate the code in functions, but to write it as an exploratory 
# analysis will take place.

library(plyr)
# read data from file
NEI <- readRDS("summarySCC_PM25.rds")
# aggregate emissions by year
sum_by_year <- aggregate(Emissions ~ year, data = NEI, sum)
# open png file for printing
png(filename="plot1.png", width=480, height=480, units="px")
# plot emissions by year
with(sum_by_year,plot(year,Emissions,pch = 19))
# add a meaningful title
title(main = "Total Emissions in U.S.")
# add a regression line to show the tendency
abline(lm(Emissions ~ year, data = sum_by_year), col="blue")
# close device
dev.off()