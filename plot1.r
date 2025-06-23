library(sqldf)

df <- read.csv.sql("household_power_consumption.txt",
                   sql = "SELECT * FROM file WHERE Date = '1/2/2007' OR Date = '2/2/2007'",
                   sep = ";", header = TRUE)

min_val <- min(df$Global_active_power, na.rm = TRUE)
max_val <- max(df$Global_active_power, na.rm = TRUE)
range_kW <- max_val - min_val


num_bins <- ceiling(range_kW * 2)

png("plot1.png", width=800, height=600)

hist(df$Global_active_power, breaks=num_bins, col="red",
     main="Histogram of Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency")

dev.off()
