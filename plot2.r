# Load required package
library(sqldf)

# Read only 1st and 2nd Feb 2007 data
df <- read.csv.sql("household_power_consumption.txt",
                   sql = "SELECT * FROM file WHERE Date = '1/2/2007' OR Date = '2/2/2007'",
                   sep = ";", header = TRUE)

# Convert to POSIXct
df$DateTime <- as.POSIXct(paste(df$Date, df$Time),
                          format="%d/%m/%Y %H:%M:%S")

# Prepare x-axis ticks using as.POSIXct only
tick_times <- as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03"))

# Plot Global Active Power vs DateTime
png("plot2.png", width=800, height=600)

plot(df$DateTime, df$Global_active_power, type="l", col="black",
     xlab="", ylab="Global Active Power (kilowatts)", xaxt="n")

# Add custom weekday x-axis
axis(1, at = tick_times, labels = format(tick_times, "%a"))
title(xlab = "Day")

dev.off()
