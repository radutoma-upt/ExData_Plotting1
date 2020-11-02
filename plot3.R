# Exploratory Data Analysis - Course Project 1
# Plot 3

# read in data files

# Initialize variables
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

#load the data
data <- read.table(fileName, header = T, sep = ";", na.strings = "?")

#convert the date variable to Date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#Subset the data
dataSubset <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

#Convert dates and times
dataSubset$datetime <- strptime(paste(dataSubset$Date, dataSubset$Time), "%Y-%m-%d %H:%M:%S")

dataSubset$Sub_metering_1 <- as.numeric(as.character(dataSubset$Sub_metering_1))
dataSubset$Sub_metering_2 <- as.numeric(as.character(dataSubset$Sub_metering_2))
dataSubset$Sub_metering_3 <- as.numeric(as.character(dataSubset$Sub_metering_3))

#Plot 3
attach(dataSubset)
plot(dataSubset$datetime, dataSubset$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab="", cex.lab=0.9, cex.axis=0.8)
lines(dataSubset$datetime, dataSubset$Sub_metering_1, col = "black")
lines(dataSubset$datetime, dataSubset$Sub_metering_2, col = "red")
lines(dataSubset$datetime, dataSubset$Sub_metering_3, col = "blue")
legend("topright", cex=0.9,  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"),lty = c(1, 1, 1))

# export the plot to a png file
dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()
detach(dataSubset)