library(sqldf)

df <- read.csv.sql("household_power_consumption.txt",
                   sql = "SELECT * FROM file WHERE Date = '1/2/2007' OR Date = '2/2/2007'",
                   sep = ";", header = TRUE)

df$DateTime <- as.POSIXct(paste(df$Date, df$Time),
                          format="%d/%m/%Y %H:%M:%S")

png("plot_combined.png", width=960, height=960)

par(mfrow = c(2, 2))

plot(df$DateTime, df$Global_active_power, type="l", col="black",
     xlab="", ylab="Global Active Power (kilowatts)", xaxt="n")
days <- seq(as.POSIXct("2007-02-01"), as.POSIXct("2007-02-03"), by="days")
axis(1, at=days, labels=format(days, "%a"))

plot(df$DateTime, df$Voltage, type="l", col="black",
     xlab="DateTime", ylab="Voltage (volt)", xaxt="n")
axis(1, at=days, labels=format(days, "%a"))

plot(df$DateTime, df$Sub_metering_1, type="l", col="black",
     xlab="", ylab="Energy sub metering", xaxt="n")
lines(df$DateTime, df$Sub_metering_2, col="red")
lines(df$DateTime, df$Sub_metering_3, col="blue")
legend("topright", legend = c("Kitchen", "Laundry", "Water Heater/AC"),
       col = c("black", "red", "blue"), lty = 1, bty = "n")
axis(1, at=days, labels=format(days, "%a"))

plot(df$DateTime, df$Global_reactive_power, type="l", col="black",
     xlab="DateTime", ylab="Global Reactive Power (kilowatts)", xaxt="n")
axis(1, at=days, labels=format(days, "%a"))

dev.off()
