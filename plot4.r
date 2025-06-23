# Load required package
library(sqldf)

# Read only 1st and 2nd Feb 2007 data
df <- read.csv.sql("household_power_consumption.txt",
                   sql = "SELECT * FROM file WHERE Date = '1/2/2007' OR Date = '2/2/2007'",
                   sep = ";", header = TRUE)

# Create POSIX datetime
df$DateTime <- as.POSIXct(paste(df$Date, df$Time),
                          format="%d/%m/%Y %H:%M:%S")

# Start PNG device
png("plot_combined.png", width=960, height=960)

# Set 2x2 plot layout
par(mfrow = c(2, 2))

# (1,1) Global Active Power
plot(df$DateTime, df$Global_active_power, type="l", col="black",
     xlab="", ylab="Global Active Power (kilowatts)", xaxt="n")
days <- seq(as.POSIXct("2007-02-01"), as.POSIXct("2007-02-03"), by="days")
axis(1, at=days, labels=format(days, "%a"))

# (1,2) Voltage
plot(df$DateTime, df$Voltage, type="l", col="black",
     xlab="DateTime", ylab="Voltage (volt)", xaxt="n")
axis(1, at=days, labels=format(days, "%a"))

# (2,1) Energy Sub-Metering
plot(df$DateTime, df$Sub_metering_1, type="l", col="black",
     xlab="", ylab="Energy sub metering", xaxt="n")
lines(df$DateTime, df$Sub_metering_2, col="red")
lines(df$DateTime, df$Sub_metering_3, col="blue")
legend("topright", legend = c("Kitchen", "Laundry", "Water Heater/AC"),
       col = c("black", "red", "blue"), lty = 1, bty = "n")
axis(1, at=days, labels=format(days, "%a"))

# (2,2) Global Reactive Power
plot(df$DateTime, df$Global_reactive_power, type="l", col="black",
     xlab="DateTime", ylab="Global Reactive Power (kilowatts)", xaxt="n")
axis(1, at=days, labels=format(days, "%a"))

# Save and close
dev.off()
