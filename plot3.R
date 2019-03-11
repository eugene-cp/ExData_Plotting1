library(sqldf)
library(dplyr)

dataFile <- "./data/household_power_consumption.txt"
sourceFile <- "./data/exdata_data_household_power_consumption.zip"

if(!file.exists(dataFile))
{
  unzip(sourceFile, exdir="./data")
}

consumption <- read.csv.sql(dataFile, sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007'", sep=";")

consumption$DateTime=strptime(paste(consumption$Date, consumption$Time), format="%d/%m/%Y %H:%M:%S")
consumption$Date=as.Date(consumption$Date)
consumption$Time=strptime(consumption$Time, format="%H:%M:%S")

#Plot 3
png(filename="plot3.png", width=480, height=480)
plot(consumption$DateTime, consumption$Sub_metering_1, type='n', ylab="Energy sub metering", xlab="")
points(consumption$DateTime, consumption$Sub_metering_1, col='black', type='l')
points(consumption$DateTime, consumption$Sub_metering_2, col='red', type='l')
points(consumption$DateTime, consumption$Sub_metering_3, col='blue', type='l')
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=1)
dev.off()