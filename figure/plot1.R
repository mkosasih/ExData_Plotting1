library(dplyr)

#Retreive Tables from working directory
WD <- getwd()

if(!file.exists(paste(WD,"/household_power_consumption.txt",sep=""))) 
  stop("household_power_consumption.txt is not available in your working directory. Please download the file") 

setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

data <- read.table("household_power_consumption.txt",stringsAsFactors = FALSE, colClasses= c(Date = 'myDate'),header=TRUE, sep=";")
DF <- filter(data, Date == "2007-02-01" | Date == "2007-02-02")

png(file = "plot1.png", width = 480, height = 480)
hist(as.numeric(DF$Global_active_power), col="red", xlab="Global Active Power (killowatts)", main = "Global Active Power")
dev.off()