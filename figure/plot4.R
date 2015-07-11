library(dplyr)

#Retreive Tables from working directory
WD <- getwd()

if(!file.exists(paste(WD,"/household_power_consumption.txt",sep=""))) 
    stop("household_power_consumption.txt is not available in your working directory. Please download the file") 

setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

data <- read.table("household_power_consumption.txt",stringsAsFactors = FALSE, colClasses= c(Date = 'myDate'),header=TRUE, sep=";")
DF <- filter(data, Date == "2007-02-01" | Date == "2007-02-02")
DF <- mutate(DF, DateTime = paste(Date,Time,sep=" "))


dateTime = strptime(DF$DateTime, format = "%Y-%m-%d %H:%M:%S")

GAP = as.numeric(DF$Global_active_power)
y1 = as.numeric(DF$Sub_metering_1)
y2 = as.numeric(DF$Sub_metering_2)
y3 = as.numeric(DF$Sub_metering_3)
Voltage = as.numeric(DF$Voltage)
GRP = as.numeric(DF$Global_reactive_power)

png(file = "plot4.png", width = 480, height = 480)
par(mfcol = c(2,2))
plot(dateTime,GAP,type='n',ylab="Global Active Power (kilowatts)")
lines(dateTime,GAP)

plot(dateTime,y,type="n", ylim = c(0,40), ylab="Global Active Power (kilowatts)")
lines(dateTime,y1)
lines(dateTime,y2, col = "red")
lines(dateTime,y3, col = "blue")
legend("topright", lwd=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(dateTime,Voltage,type='n')
lines(dateTime,Voltage)

plot(dateTime,GRP,type='n',ylab="Global_reactive_power" )
lines(dateTime,GRP)

dev.off()