download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "consumption.zip")
unzip("consumption.zip")
cons=read.csv("household_power_consumption.txt",h=T,sep = ";")
#
library(lubridate)
#how household energy usage varies over a 2-day period in February, 2007
#select feb 2007
feb2007<-cons[month(as.Date(cons$Date,format="%d/%m/%Y"))==2&year(as.Date(cons$Date,format="%d/%m/%Y"))==2007,]
#We will only be using data from the dates 2007-02-01 and 2007-02-02. 
firsttwodays<-feb2007[day(as.Date(feb2007$Date,format="%d/%m/%Y"))==1|day(as.Date(feb2007$Date,format="%d/%m/%Y"))==2,]

#Now global active power versus time during those two days

submet=cbind(as_datetime(paste(firsttwodays$Date,firsttwodays$Time),format = "%d/%m/%Y %H:%M:%S"),levels(firsttwodays$Sub_metering_1)[firsttwodays$Sub_metering_1],levels(firsttwodays$Sub_metering_2)[firsttwodays$Sub_metering_2],firsttwodays$Sub_metering_3)
gpa=cbind(submet,levels(firsttwodays$Global_active_power)[firsttwodays$Global_active_power],levels(firsttwodays$Global_reactive_power)[firsttwodays$Global_reactive_power])
voltage=cbind(gpa,levels(firsttwodays$Voltage)[firsttwodays$Voltage])

png(filename  = "plot4.png")
#voltage is time, submets 1, 2,3, global activate power, global reactivate, voltage
par(mfrow=c(2,2))
plot(voltage[,1],voltage[,5],t="l",ylab = "Global Active Power",xaxt="n",xlab = "")
axis(1,at=c(submet[1,1],submet[1441,1],submet[2880,1]),labels=c("Thu","Fri","Sat"))
plot(voltage[,1],voltage[,7],t="l",ylab = "Voltage",xaxt="n",xlab="datetime")
axis(1,at=c(submet[1,1],submet[1441,1],submet[2880,1]),labels=c("Thu","Fri","Sat"))
plot(voltage[,1],voltage[,2],t="l",ylab = "Energy sub metering",xaxt="n",xlab = "")
lines(voltage[,1],voltage[,3],t="l",col="red")
lines(voltage[,1],voltage[,4],t="l",col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lty = 1, lwd = 1,bty="n")
axis(1,at=c(submet[1,1],submet[1441,1],submet[2880,1]),labels=c("Thu","Fri","Sat"))
plot(voltage[,1],voltage[,6],t="l",ylab = "Global_reactive_power" ,xaxt="n",xlab="datetime")
axis(1,at=c(submet[1,1],submet[1441,1],submet[2880,1]),labels=c("Thu","Fri","Sat"))
dev.off()