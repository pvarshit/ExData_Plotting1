# Load required package
library(sqldf)

# Read only 1st and 2nd Feb 2007 data
df <- read.csv.sql("household_power_consumption.txt",
                   sql = "SELECT * FROM file WHERE Date = '1/2/2007' OR Date = '2/2/2007'",
                   sep = ";", header = TRUE)

# Combine Date and Time
df$DateTime <- as.POSIXct(paste(df$Date, df$Time), format="%d/%m/%Y %H:%M:%S")

# Plot sub-metering with weekday x-axis (using strptime)
png("plot3.png", width=800, height=600)

plot(df$DateTime, df$Sub_metering_1, type="l", col="black", 
     xlab="", ylab="Energy sub metering", xaxt="n")
lines(df$DateTime, df$Sub_metering_2, col="red")
lines(df$DateTime, df$Sub_metering_3, col="blue")

# Use strptime for tick marks
days <- strptime(c("2007-02-01", "2007-02-02", "2007-02-03"), format="%Y-%m-%d")
axis(1, at = as.POSIXct(days), labels = format(days, "%a"))
title(xlab = "Day")

legend("topright", legend = c("Kitchen", "Laundry", "Water Heater/AC"),
       col = c("black", "red", "blue"), lty = 1)

dev.off()
