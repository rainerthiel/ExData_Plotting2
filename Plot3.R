# Exploratory Data Analysis - Project 2
# This script reproduces Plot3
#
#  Of the four types of sources indicated by the type (point, nonpoint,
#  onroad, nonroad) variable, which of these four sources have seen decreases in
#  emissions from 1999–2008 for Baltimore City? Which have seen increases in
#  emissions from 1999–2008? Use the ggplot2 plotting system to make a plot
#  answer this question.
#
# Synopsis
#
# - Load and prepare the working data (helper function getData())
# - Generate the plot and write it out as a png file
#

library(dplyr)
library(data.table)
library(ggplot2)
source("Helpers.R")

#
# Load and prepare data
#

sourceUrl <- "https://d396qusza40orc.cloudfront.net"
sourceFile <- "exdata%2Fdata%2FNEI_data.zip"
target <- "data.zip"
plotFile <- "plot3.png"

files <- getData(sourceUrl, sourceFile, target)

NEI <- files[[1]]

emissions_by_year <- NEI %>%
    group_by(year, type) %>%
    summarize(pm25sum = sum(Emissions) / 10^3) # kilotons
#
# Generate the plot and save it as a png file in the working directory
#

png(filename = plotFile) # height/width defaults are 480px

par(mfrow=c(1,1), mar = c(6,6,4,4))

p <- ggplot(data = emissions_by_year,
            aes(year, pm25sum,
            group = type,
            colour = type))
p + 
    geom_line() +
    ggtitle("pm2.5 Emissions by Year", "Totals by source type") +
    xlab("Year") + ylab("Total emissions (Kilotons)") +
    annotate("text", x = 2007, y = 5000, size = 2,
             label = wrap_strings(width = 24,
                                  "All emission types show a decrease over the measurement period"))


dev.off()
