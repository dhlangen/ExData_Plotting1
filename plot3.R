library(dplyr)

energy <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = "character")

##Select relevant columns, filter out unnecessary rows, and eliminate missing observations
energy <- energy %>% select(Date, Time, Sub_metering_1, Sub_metering_2, Sub_metering_3) %>% filter(Date == "1/2/2007" | Date == "2/2/2007")

##Create date/time column and format colclasses
energy$Sub_metering_1 <- as.numeric(energy$Sub_metering_1)
energy$Sub_metering_2 <- as.numeric(energy$Sub_metering_2)
energy$Sub_metering_3 <- as.numeric(energy$Sub_metering_3)
energy <- energy %>% mutate(datetime = paste0(Date, " ", Time) )
energy$datetime <- strptime(energy$datetime, "%d/%m/%Y %H:%M:%S")

#Open png graphics device
png(file = "plot3.png", width = 480, height = 480, units = "px")

#Create line plot (on screen device for grading)
with(energy, plot(datetime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
with(energy, lines(datetime, Sub_metering_2, col = "red"))
with(energy, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Close png graphics device
dev.off()