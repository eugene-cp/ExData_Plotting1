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

#Plot 2
png(filename="plot2.png", width=480, height=480)
plot(consumption$DateTime, consumption$Global_active_power, type='l', ylab="Global Active Power (kilowatts)", xlab="")
#dev.print(device=png, file="plot2.png", width=480, height=480)
dev.off()