# Exploratory Data Analysis - Course Project 1
# Plot 1

# read in data files

# Initialize variables

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
rm(list = ls())
data <- read.table(fileName, header = T, sep = ";", na.strings = "?")


#convert the date variable to Date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

class(data$Date) # checks date is a date within R

#Subset the data
dataSubset <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

# visual check of data
View(dataSubset) 

dataSubset$Global_active_power <- as.numeric(as.character(dataSubset$Global_active_power))
class(dataSubset$Global_active_power)
View(dataSubset)

attach(dataSubset)
hist(dataSubset$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power", 
     cex.lab=0.9, cex.main=0.8, cex.axis=0.8)

# export the plot to a png file
dev.copy(png, file = "plot1.png", height = 480, width = 480) 
dev.off()
detach(dataSubset)