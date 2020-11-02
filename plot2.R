# Exploratory Data Analysis - Course Project 1
# Plot 2

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

#Plot 2
dataSubset$datetime <- as.POSIXct(dataSubset$datetime)
attach(dataSubset)
plot(Global_active_power ~ datetime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")

# export the plot to a png file
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()
detach(dataSubset)