# ExData_Plotting2 - helper functions
#
# o getData(dataSource)
#   Retrieve the data from source into the working direcory
#   Prepare the data for processing
#
# o str_wrap()
#   Wrap text data added to the plots into a neat paragraph
#

getData <- function(sourceUrl, sourceFile, target) {

    print(paste("> getData() (download/read/prepare) at", date(), "."))

    wDir <- getwd()
    dataDir <- paste(wDir, "Data", sep='/')
    localFile_NEI <- "summarySCC_PM25.rds"
    localFile_SCC <- "Source_Classification_Code.rds"
    
    if (!dir.exists(dataDir)) dir.create(dataDir)
    setwd(dataDir)
    if(!file.exists(target)) {
        print(paste(">>> Downloading original dataset at", date(), "..."))
        download.file(paste(sourceUrl, sourceFile, sep = "/"),
                      destfile=target , mode='wb')
    }
    print(paste(">>> Reading data into data frames at", date(), ". Please be patient..."))
    unzip(target) 
    NEI <- readRDS(localFile_NEI)
    SCC <- readRDS(localFile_SCC)
     
    setwd(wDir)

    # free unused memory
    gc()
 
    # return the dataframes as a list
    return(list(NEI, SCC))
}
#
# str_wrap()
# - https://stackoverflow.com/questions/7367138/text-wrap-for-plot-titles
#
str_wrap  <- function(vector_of_strings, width) {
    as.character(sapply(
        vector_of_strings,
        FUN = function(x) {
            paste(strwrap(x, width = width), collapse = "\n")
        }
    ))
}