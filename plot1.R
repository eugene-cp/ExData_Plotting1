library(sqldf)
library(dplyr)

dataFile <- "./data/household_power_consumption.txt"
sourceFile <- "./data/exdata_data_household_power_consumption.zip"

if(!file.exists(dataFile))
{
  unzip(sourceFile, exdir="./data")
}

consumption <- read.csv.sql(dataFile, sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007'", sep=";")

consumption$Date=as.Date(consumption$Date)
consumption$Time=strptime(consumption$Time, format="%H:%M:%S")

#Plot 1
png(filename="plot1.png", width=480, height=480)
hist(consumption$Global_active_power, col="Red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
#dev.print(device=png, file="plot1.png", width=480, height=480)