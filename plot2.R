#This is the script to construct Plot 2 for the 1st Course Project in the Exploratory Data Analysis course

#Download the zip file from the url put it into a tempfile, unzip and load the data then remove the temp file
tempfile <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", tempfile)
unzippedfile <- unz(tempfile, "household_power_consumption.txt")
data <- read.table(unzippedfile,
                   sep = ";",
                   header = TRUE,
                   na.strings = "?",
                   colClasses = c(rep("character", 2), rep("numeric",7)))
unlink(tempfile)

#Convert date and time fields then subset data for given days
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
subdata <- subset(data, data$Date >= "2007-02-01" & data$Date <= "2007-02-02")
subdata <- transform(subdata, DateTime = as.POSIXct(paste(subdata$Date, subdata$Time)), "%d/%m/%Y %H:%M:%S")

#Creates chart on the screen
plot(subdata$Global_active_power ~ subdata$DateTime,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

#Sends chart to PNG and closes graphic device
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()