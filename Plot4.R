# Exploratory Data Analysis - Project 2
# This script reproduces Plot4
#
# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999–2008?
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
plotFile <- "plot4.png"
sectorFilter <- c("Fuel Comb - Electric Generation - Coal",
                  "Fuel Comb - Comm/Institutional - Coal",
                  "Fuel Comb - Industrial Boilers, ICEs - Coal")

files <- getData(sourceUrl, sourceFile, target)

NEI <- files[[1]]
SCC <- files[[2]]


sccFilter <- filter(SCC, EI.Sector %in% sectorFilter)$SCC

emissions_by_year <- inner_join(x = filter(NEI,
                                           SCC %in% sccFilter),
                                y = SCC,
                                join_by(SCC)) %>%
                                group_by(year, EI.Sector) %>%
                                summarize(pm25sum = sum(Emissions) / 10^3) # kilotons
#
# Generate the plot and save it as a png file in the working directory
#

png(filename = plotFile, # height/width defaults are 480px
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
          labs(title = "Total pm2.5 Emissions by Year",
               subtitle = "Coal combustion-related sources",
               caption = str_wrap("Note: Industrial boiler emissions have increased over the measurement period",
                                  width = 48)) +
    scale_y_continuous(breaks = seq(0, 600, by = 100)) +
    xlab("Year") + ylab("Total emissions (Kilotons)")

dev.off()
