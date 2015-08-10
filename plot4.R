localPath <- 'C:\\Users\\support\\Documents\\4 Exploratory Data Analysis\\Course Project 1\\'
setwd(localPath)
dsFilePath = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dsZipFile = "household_power_consumption.zip"
dsFile = "household_power_consumption.txt"
#
# Download File & Unzip
#
 # download.file(dsFilePath,dsZipFile)
 # unzip(dsZipFile,dsFile)
#
# load Data
#
dsHouseHold <-   read.table(dsFile, dec = ".", sep = ";", na.strings= "?", header = FALSE, skip = 1,col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dim(dsHouseHold)
dsHouseHold$fDate <- as.Date(dsHouseHold$Date, "%d/%m/%Y")
head(dsHouseHold)
dsHouseHold <- subset(dsHouseHold, dsHouseHold$fDate == "2007-02-01" | dsHouseHold$fDate == "2007-02-02")
dsHouseHold <- dsHouseHold[,1:9]
dim(dsHouseHold)
dsHouseHold$TimeStamp <- strptime(paste(dsHouseHold$Date, dsHouseHold$Time, sep="-"), "%d/%m/%Y-%H:%M:%S")
dim(dsHouseHold)
head(dsHouseHold)
#
# here is the graph
#
png(file = "plot4.png", bg = "transparent", width = 480, height = 480, units = "px", pointsize = 12)
par(mfrow = c(2,2))
with (dsHouseHold,{
  plot(TimeStamp, Global_active_power, type = "l", xlab="", ylab="Global Active Power")
  plot(TimeStamp, Voltage, type = "l", xlab="datetime", ylab="Voltage")
  plot(dsHouseHold$TimeStamp, dsHouseHold$Sub_metering_1, col="black", type = "l", xlab="", ylab="Energy sub metering (kilowatts)")
    points(dsHouseHold$TimeStamp, dsHouseHold$Sub_metering_2, col="red", type = "l")
    points(dsHouseHold$TimeStamp, dsHouseHold$Sub_metering_3, col="blue", type = "l")
   legend("topright", bty = "n" ,lty=1, col=c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(TimeStamp, Global_reactive_power, type = "l", xlab="datetime", ylab="Global_reactive_power")
})
dev.off()
