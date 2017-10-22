
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

plot(mydata$newdate,mydata$Sub_metering_1,col="black", type="l", ylab="Energy sub metering", xlab="", main="")
lines(mydata$newdate,mydata$Sub_metering_2,col="red")
lines(mydata$newdate,mydata$Sub_metering_3,col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1)


dev.copy(png,"plot3.png")
dev.off()
