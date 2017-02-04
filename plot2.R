library(dplyr)

energy <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = "character")

##Select relevant columns, filter out unnecessary rows, and eliminate missing observations
energy <- energy %>% select(Date, Time, Global_active_power) %>% filter(Date == "1/2/2007" | Date == "2/2/2007")

##Create date/time column and format colclasses
energy$Global_active_power <- as.numeric(energy$Global_active_power)
energy <- energy %>% mutate(datetime = paste0(Date, " ", Time) )
energy$datetime <- strptime(energy$datetime, "%d/%m/%Y %H:%M:%S")

#Open png graphics device
png(file = "plot2.png", width = 480, height = 480, units = "px")

#Create plot (on screen device for grading)
with(energy, plot(energy$datetime, energy$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

#Close png graphics device
dev.off()