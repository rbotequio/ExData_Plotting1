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
hpc$Date <- as.Date(hpc$Date, '%d/%m/%Y')
#selec range 01/02/2007 and 02/02/2007
hpc1 <- filter(hpc, Date == "2007-02-01" | Date == "2007-02-02")
# Add new collum datetime
hpc2 <- hpc1 %>% mutate(datetime = as.POSIXct(strptime(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S")))

#print Graph - X label in portuguese Qui = Thu, Sex = Fri, Sáb = Sat

png(file = "plot3.png", width = 480, height = 480, units = "px")
with(hpc2,
     plot(datetime,
          Sub_metering_1,
          type = "l",
          xlab = "Qui = Thu, Sex = Fri, Sáb = Sat",
          ylab = "Energy sub metering"))
with(hpc2,
     points(datetime,
            type = "l",
            Sub_metering_2,
            col = "red")
)
with(hpc2,
     points(datetime,
            type = "l",
            Sub_metering_3,
            col = "blue")
)
legend("topright", col = c("black", "blue", "red"),
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = 1)
dev.off()



