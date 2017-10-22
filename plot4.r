
require(dplyr)

if (!exists("allData")) {
  allData<-read.table("household_power_consumption.txt",sep=";",na.strings="?", header=TRUE)
}
if (!exists("mydata")) {
  mydata<-subset(allData,allData$Date=="1/2/2007"|allData$Date=="2/2/2007")
##  mydata<-mutate(mydata,newdate=as.Date.POSIXct(strptime(paste(mydata$Date,mydata$Time),format="%d/%m/%Y %H:%M:%S")))
  mydata<-mutate(mydata,newdate=as.POSIXct(strptime(paste(mydata$Date,mydata$Time),format="%d/%m/%Y %H:%M:%S")))
  mydata<-select(mydata,Date,Time,newdate,Sub_metering_1,Sub_metering_2,Sub_metering_3,everything())
}
mydata<-tbl_df(mydata)


par(mfcol=c(2,2))

plot(mydata$newdate,mydata$Global_active_power,type="l",main = "", xlab="", ylab="Global Active Power")

plot(mydata$newdate,mydata$Sub_metering_1,col="black", type="l", ylab="Energy sub metering", xlab="", main="")
lines(mydata$newdate,mydata$Sub_metering_2,col="red")
lines(mydata$newdate,mydata$Sub_metering_3,col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1, bty="n")

plot(mydata$newdate,mydata$Voltage,main="",xlab="datetime",ylab="Voltage", type="l")
plot(mydata$newdate,mydata$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power", main="")

dev.copy(png,"plot4.png")
dev.off()
