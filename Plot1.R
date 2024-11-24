# Exploratory Data Analysis - Project 2
# This script reproduces Plot1
#
# Have total emissions from PM2.5 decreased in the United States from 1999 to
# 2008? Using the base plotting system, make a plot showing the total PM2.5
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.
#
# Synopsis
#
# - Load and prepare the working data (helper function getData())
# - Generate the plot and write it out as a png file
#

library(dplyr)
library(data.table)
source("Helpers.R")

#
# Load and prepare data
#

sourceUrl <- "https://d396qusza40orc.cloudfront.net"
sourceFile <- "exdata%2Fdata%2FNEI_data.zip"
target <- "data.zip"
plotFile <- "plot1.png"

files <- getData(sourceUrl, sourceFile, target)

NEI <- files[[1]]
emissions_by_year <- NEI %>%
                     group_by(year) %>%
                     summarize(pm25sum = sum(Emissions) / 10^3) # kilotons
#
# Generate the plot and save it as a png file in the working directory
#

png(filename = plotFile,
    height = 960, width = 960,
    res = 144)

par(mfrow=c(1,1), mar = c(6,6,4,4))
barplot(data = emissions_by_year,
        pm25sum ~ year,
        cex.axis = 0.8,
        cex.names = 0.8,
        col = c(2:5),
        main = "Total US pm2.5 Emissions by Year",
        xlab = "Year",
        ylab = "Total emissions (Kilotons)",
        las = 1)
text(x = 4.3, y = 7000, cex = 0.8, str_wrap("Emissions have decreased over the measurement period", 20))

dev.off()
