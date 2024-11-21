---
editor_options: 
  markdown: 
    wrap: 72
---

## Introduction

(from the Course Project 2 Instructions)

> *Fine particulate matter (PM2.5) is an ambient air pollutant for which
> there is strong evidence that it is harmful to human health. In the
> United States, the Environmental Protection Agency (EPA) is tasked
> with setting national ambient air quality standards for fine PM and
> for tracking the emissions of this pollutant into the atmosphere.
> Approximately every 3 years, the EPA releases its database on
> emissions of PM2.5. This database is known as the National Emissions
> Inventory (NEI).*
>
> *You can read more information about the NEI at [EPA National
> Emissions Inventory
> Website.](https://www.epa.gov/air-emissions-inventories/national-emissions-inventory-nei)*

## Loading the data

Note the following considerations:

-   The download, file import and data cleaning code is common to all 4
    plotting scripts. It is located in the common helper script
    `Helpers.R` function `getData()`

## Making Plots

For each plot:

-   The plot is constructed and saved as a PNG file with a width of 480
    pixels and a height of 480 pixels.

-   The plot files are named `plot1.png`, `plot2.png`, `plot3.png` and
    `plot4.png`.

-   The plots are coded in a separate R code file named `Plot1.R`,
    `Plot2.R`, `Plot3.R` and `Plot4.R`. They construct the corresponding
    plot file and write it out using the png graphical device. The
    scripts all use a common helper function for reading the data.
