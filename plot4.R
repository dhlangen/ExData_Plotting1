library(dplyr)

energy <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = "character")

##Select relevant columns, filter out unnecessary rows, and eliminate missing observations
energy <- energy %>% filter(Date == "1/2/2007" | Date == "2/2/2007")

##Create date/time column and format colclasses
energy$Global_active_power <- as.numeric(energy$Global_active_power)
energy$Global_reactive_power <- as.numeric(energy$Global_reactive_power)
energy$Voltage <- as.numeric(energy$Voltage)
energy$Sub_metering_1 <- as.numeric(energy$Sub_metering_1)
energy$Sub_metering_2 <- as.numeric(energy$Sub_metering_2)
energy$Sub_metering_3 <- as.numeric(energy$Sub_metering_3)
energy <- energy %>% mutate(datetime = paste0(Date, " ", Time) )
energy$datetime <- strptime(energy$datetime, "%d/%m/%Y %H:%M:%S")

### Open png graphics device
png(file = "plot4.png", width = 480, height = 480, units = "px")

#Setup multiple lot format
par(mfrow = c(2, 2))

#Create plot1
with(energy, plot(energy$datetime, energy$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))

#Create plot2
with(energy, plot(energy$datetime, energy$Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

#Create plot3
with(energy, plot(datetime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
with(energy, lines(datetime, Sub_metering_2, col = "red"))
with(energy, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", bty = "n", lty = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Create plot4
with(energy, plot(energy$datetime, energy$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))

#Close png graphics device
dev.off()

#Reset single plot format
par(mfrow = c(1, 1))