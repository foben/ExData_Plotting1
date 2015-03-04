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
png(filename = "plot3.png", width = 480, height = 480)

#plot(dates, realData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
#lines(dates, realData$Sub_metering_2, col = "red")
#lines(dates, realData$Sub_metering_3, col = "blue")

#Plot the first data series to create the base plot, specifying the y-axis label.
#type = "l" plots lines instead of points
plot(dates, realData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")

#Add the two other data series as lines to the plot
lines(dates, realData$Sub_metering_2, col = "red")
lines(dates, realData$Sub_metering_3, col = "blue")

#Add the legend to the plot.
#col gives a vector of colors, lty a vector of line types for the legend entries.
legend("topright",
       col = c("black", "red", "blue"),
       lty = c(1,1,1),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       )

#Close the file device
dev.off()

