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
png(filename ="plot3.png")
plot(submet[,1],submet[,2],t="l",xaxt="n",xlab = "",ylab = "Energy sub metering")
lines(submet[,1],submet[,3],t="l",col="red")
lines(submet[,1],submet[,4],t="l",col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lty = 1, lwd = 1)
axis(1,at=c(submet[1,1],submet[1441,1],submet[2880,1]),labels=c("Thu","Fri","Sat"))
dev.off()