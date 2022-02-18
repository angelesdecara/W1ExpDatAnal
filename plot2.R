download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "consumption.zip")
unzip("consumption.zip")
cons=read.table("household_power_consumption.txt",h=T,sep = ";")
#
library(lubridate)
#how household energy usage varies over a 2-day period in February, 2007
#select feb 2007
feb2007<-cons[month(as.Date(cons$Date,format="%d/%m/%Y"))==2&year(as.Date(cons$Date,format="%d/%m/%Y"))==2007,]
#We will only be using data from the dates 2007-02-01 and 2007-02-02. 
firsttwodays<-feb2007[day(as.Date(feb2007$Date,format="%d/%m/%Y"))==1|day(as.Date(feb2007$Date,format="%d/%m/%Y"))==2,]

#Now global active power versus time during those two days

gpa=cbind(as_datetime(paste(firsttwodays$Date,firsttwodays$Time),format = "%d/%m/%Y %H:%M:%S"),levels(firsttwodays$Global_active_power)[firsttwodays$Global_active_power])
png(file="plot2.png")
plot(gpa,type="l",ylab = "Global Active Power (kilowatts)",xaxt="n",xlab = "")
axis(2)
axis(1,at=c(gpa[1],gpa[1441],gpa[2880]),labels=c("Thu","Fri","Sat"))
box()
dev.off()