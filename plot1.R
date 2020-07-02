#set workdirectory

setwd("~/Desktop/data/HPC")

#Downloadfile 
# Download data to  /HPC directory
if (dir.exists("./data/HPC") == TRUE){
  if (!file.exists("household_power_consumption.txt")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "hpc.zip")
    unzip(zipfile="./Dataset.zip", exdir="./data/hpc")
  }
} else {
  dir.create("./data/HPC")
  if (!file.exists("household_power_consumption.txt")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "hpc.zip")
  }
}

#Read Labraries
library(data.table)
library(dplyr)
#Read DATA
hpc <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", dec = ".")

#As date
hpc$Date <- as.Date(hpc$Date, '%d/%m/%Y')
#filter 01/02/2007 - 02/02/2007
hpc1 <- filter(hpc, Date == "2007-02-01" | Date == "2007-02-02")

#print Graph to PNG
png(filename = "plot1.png")
hist(hpc1$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power(kilowatts)")
dev.off()
