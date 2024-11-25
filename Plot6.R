# Exploratory Data Analysis - Project 2
# This script reproduces Plot6
#
# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips ==
# "06037"). Which city has seen greater changes over time in motor vehicle
# emissions?
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
plotFile <- "plot6.png"
sectorFilter <- c("Mobile - On-Road Diesel Heavy Duty Vehicles",
                  "Mobile - On-Road Diesel Light Duty Vehicles",
                  "Mobile - On-Road Gasoline Heavy Duty Vehicles",
                  "Mobile - On-Road Gasoline Light Duty Vehicles")
fipsFilter <- c("24510", "06037")

files <- getData(sourceUrl, sourceFile, target)

NEI <- files[[1]]
SCC <- files[[2]]


sccFilter <- filter(SCC, EI.Sector %in% sectorFilter)$SCC

pm25_by_year <- inner_join(x = filter(NEI,
                                           SCC %in% sccFilter & 
                                           fips %in% fipsFilter),
                                y = SCC,
                                join_by(SCC)) %>%
    group_by(year, fips) %>%
    summarize(pm25sum = sum(Emissions) / 10^3) # kilotons
    la1999sum <- round(subset(pm25_by_year, fips == "06037" & year == 1999)$pm25sum)
    ba1999sum <- round(subset(pm25_by_year, fips == "24510" & year == 1999)$pm25sum)
    la2008sum <- round(subset(pm25_by_year, fips == "06037" & year == 2008)$pm25sum)
    ba2008sum <- round(subset(pm25_by_year, fips == "24510" & year == 2008)$pm25sum)
    
    baChg <- round((ba1999sum - ba2008sum) / ba1999sum, digits = 2) * 100
    laChg <- round((la2008sum - la1999sum) / la2008sum, digits = 2) * 100
    #
# Generate the plot and save it as a png file in the working directory
#

png(filename = plotFile,
    height = 960, width = 1440,
    res = 144)

par(mfrow=c(1,1), mar = c(6,6,4,4))

p <- ggplot(pm25_by_year, aes(fill=fips, y=pm25sum, x=year)) 
p +
    geom_bar(position=position_dodge2(), stat='identity') +
    theme(plot.title = element_text(hjust = 0.5),
          plot.subtitle = element_text(hjust = 0.5),
          plot.caption = element_text(size = 8)) +
    labs(title = "Total pm2.5 Emission Changes by Year",
         subtitle = "Motor vehicle related sources in Baltimore and Los Angeles",
         caption = str_wrap("Baltimore emissions have seen the greater changes(decrease) over the measurement period",
                            width = 48)) +
    guides(fill = guide_legend(title = "City")) +
    geom_label(x = 2007.67, y = 4300, size = 3, fill = "white",
               label = paste(laChg, "% up", sep= "")) +
    geom_label(x = 2008.67, y =  300, size = 3, fill = "white",
               label = paste(baChg, "% down", sep= "")) +
    scale_fill_hue(labels = c("Los Angeles","Baltimore")) +
    scale_x_continuous(breaks = seq(1999, 2008, by = 3)) +
    xlab("Year") + ylab("Total emissions - log10(Tons)")




dev.off()
