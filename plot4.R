# Exploratory Data Analysis - Course Project 1
# Plot 4

# read in data files

# Initialize variables

library("data.table")
rm(list = ls())

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileArchiveName <- 'household_power_consumption.zip'
fileName <- 'household_power_consumption.txt'

# Download the dataset

# Checking if archive already exists.
if(!file.exists(fileArchiveName)) {
        # If the file does not exist download it
        download.file(fileURL, fileArchiveName, method="curl")
}
# Unzip the file
unzip(fileArchiveName)

#Reads in data from file then subsets data for specified dates
data <- data.table::fread(input = fileName, na.strings="?")

# Prevents Scientific Notation
data[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

#Subset the data
dataSubset <- data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# Plot 4-1
plot(dataSubset[, dateTime], dataSubset[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 4-2
plot(dataSubset[, dateTime],dataSubset[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 4-3
plot(dataSubset[, dateTime], dataSubset[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(dataSubset[, dateTime], dataSubset[, Sub_metering_2], col="red")
lines(dataSubset[, dateTime], dataSubset[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "), lty=c(1,1), bty="n", cex=0.9) 

# Plot 4-4
plot(dataSubset[, dateTime], dataSubset[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()