#The Data file is assumed to be in the parent directory of this file.
fileLoc <- "../household_power_consumption.txt"
#Read only the first line, just to get the header information
headData <- read.table(fileLoc, sep = ";", nrows = 1, header = TRUE)
#Read the relevant lines from the file.
#They have been determined with grep to (dramatically) decrease loading times.
realData <- read.table(fileLoc, sep = ";", skip = 66637, nrows = 2880, header = FALSE)
#Assign the variable names to the real data
names(realData) <- names(headData)
#Create Date objects from first two columns
dates <- strptime(paste(realData[,1], realData[,2]), format = "%d/%m/%Y %H:%M:%S")

#Create a 'png' graphics device, specifying the filename and image dimensions
png(filename = "plot4.png", width = 480, height = 480)
#Setup the device to accept 4 plots in a two by two matrix, filling rows first.
par(mfrow = c(2, 2))

#Draw the first plot, analogues to plot2.R
plot(dates, realData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

#Draw the second plot, similar to plot2.R but with a different variable
plot(dates, realData$Voltage, type = "l", xlab = "", ylab = "Voltage")

#Draw the third plot, analogues to plot3.R
plot(dates, realData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(dates, realData$Sub_metering_2, col = "red")
lines(dates, realData$Sub_metering_3, col = "blue")
legend("topright",
       col = c("black", "red", "blue"),
       lty = c(1,1,1),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

#Draw the fourth plot, similar to plot2.R but with a different variable
plot(dates, realData$Global_reactive_power, type = "l", xlab = "", ylab = "Global_reactive_power")

#Close the file device
dev.off()
