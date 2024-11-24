# Exploratory Data Analysis - Project 2
# This script reproduces Plot2
#
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a
# plot answering this question.
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
plotFile <- "plot2.png"

files <- getData(sourceUrl, sourceFile, target)

NEI <- files[[1]]

emissions_by_year <- filter(NEI, fips == "24510") %>%
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
        main = "Total Baltimore pm2.5 Emissions by Year",
        xlab = "Year",
        ylab = "Total emissions (Kilotons)",
        las = 1)
text(x = 4.3, y = 3, cex = 0.8, str_wrap("Emissions have decreased over the measurement period", 20))

dev.off()
