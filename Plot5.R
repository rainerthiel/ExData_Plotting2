# Exploratory Data Analysis - Project 2
# This script reproduces Plot5
#
# How have emissions from motor vehicle sources changed from 1999–2008 in
# Baltimore City?
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
plotFile <- "plot5.png"
sectorFilter <- c("Mobile - On-Road Diesel Heavy Duty Vehicles",
                  "Mobile - On-Road Diesel Light Duty Vehicles",
                  "Mobile - On-Road Gasoline Heavy Duty Vehicles",
                  "Mobile - On-Road Gasoline Light Duty Vehicles")

files <- getData(sourceUrl, sourceFile, target)

NEI <- files[[1]]
SCC <- files[[2]]


sccFilter <- filter(SCC, EI.Sector %in% sectorFilter)$SCC

emissions_by_year <- inner_join(x = filter(NEI,
                                           SCC %in% sccFilter& fips == "24510"),
                                y = SCC,
                                join_by(SCC)) %>%
    group_by(year, EI.Sector) %>%
    summarize(pm25sum = sum(Emissions)) # tons
#
# Generate the plot and save it as a png file in the working directory
#

png(filename = plotFile,
    height = 960, width = 1440,
    res = 144)

par(mfrow=c(1,1), mar = c(6,6,4,4))

p <- ggplot(data = emissions_by_year,
            aes(year, pm25sum,
                group = EI.Sector,
                colour = EI.Sector))
p + 
    geom_line(linewidth = 1) +
    theme(plot.title = element_text(hjust = 0.5), # center
          plot.subtitle = element_text(hjust = 0.5), # center
          plot.caption = element_text(size = 8)) + # font
    labs(title = "Total Baltimore pm2.5 Emissions by Year",
         subtitle = "Motor vehicle related sources",
         caption = str_wrap("All emissions have decreased over the measurement period",
                            width = 48)) +
    xlab("Year") + ylab("Total emissions (Tons)")

dev.off()
