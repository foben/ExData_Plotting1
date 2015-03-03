##The Data file is assumed to be in the parent directory of this file.
fileLoc <- "../household_power_consumption.txt"
##Read only the first line, just to get the header information
headData <- read.table(fileLoc, sep = ";", nrows = 1, header = TRUE)
##Read the relevant lines from the file.
##They have been determined with grep to (dramatically) decrease loading times.
realData <- read.table(fileLoc, sep = ";", skip = 66637, nrows = 2880, header = FALSE)
##Assign the variable names to the real data
names(realData) <- names(headData)
## Create Date objects from first two columns
dates <- strptime(paste(realData[,1], realData[,2]), format = "%d/%m/%Y %H:%M:%S")

png(filename = "plot2.png", width = 480, height = 480)
plot(dates, realData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
