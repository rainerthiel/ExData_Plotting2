# Exploratory Data Analysis - Project 2
# This script reproduces Plot1
#
# Synopsis
#
# - Load and prepare the working data (helper function getData())
# - Generate the plot and write it out as a png file
#

library(dplyr)
library(data.table)
library(lubridate)
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
SCC <- files[[2]]

#
# Generate the plot and save it as a png file in the working directory
#

png(filename = plotFile) # height/width defaults are 480px

hist(consumption$Global_active_power,
     main = 'Global Active Power',
     xlab = 'Global Active Power (kilowatts)',
     col = 'red')

dev.off()
