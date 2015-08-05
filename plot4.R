#This is the script to construct Plot 4 for the 1st Course Project in the Exploratory Data Analysis course

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

#Sets up the layout for the four charts
par(mfrow=c(2,2))

#Creates charts on the screen

#1
plot(subdata$Global_active_power ~ subdata$DateTime,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

#2
plot(subdata$Voltage ~ subdata$DateTime,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

#3
plot(subdata$Sub_metering_1 ~ subdata$DateTime,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
lines(subdata$Sub_metering_2 ~ subdata$DateTime, col = "red")
lines(subdata$Sub_metering_3 ~ subdata$DateTime, col = "blue")
legend("topright", lty = 1, lwd = 2,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#4
plot(subdata$Global_reactive_power ~ subdata$DateTime,
     type = "l",
     xlab = "datetime",
     ylab = "Global Reactive Power (kilowatts)")

#Sends chart to PNG and closes graphic device
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()