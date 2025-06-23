# Load required package
library(sqldf)

# Read only 1st and 2nd Feb 2007 data
df <- read.csv.sql("household_power_consumption.txt",
                   sql = "SELECT * FROM file WHERE Date = '1/2/2007' OR Date = '2/2/2007'",
                   sep = ";", header = TRUE)

# Calculate range
min_val <- min(df$Global_active_power, na.rm = TRUE)
max_val <- max(df$Global_active_power, na.rm = TRUE)
range_kW <- max_val - min_val

# 2 bins per kilowatt
num_bins <- ceiling(range_kW * 2)

# Plot histogram
png("plot1.png", width=800, height=600)

hist(df$Global_active_power, breaks=num_bins, col="red",
     main="Histogram of Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency")

dev.off()
