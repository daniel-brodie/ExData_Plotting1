
require(dplyr)

if (!exists("allData")) {
  allData<-read.table("household_power_consumption.txt",sep=";",na.strings="?", header=TRUE)
}
if (!exists("mydata")) {
  mydata<-subset(allData,allData$Date=="1/2/2007"|allData$Date=="2/2/2007")
##  mydata<-mutate(mydata,newdate=as.Date.POSIXct(strptime(paste(mydata$Date,mydata$Time),format="%d/%m/%Y %H:%M:%S")))
  mydata<-mutate(mydata,newdate=as.POSIXct(strptime(paste(mydata$Date,mydata$Time),format="%d/%m/%Y %H:%M:%S")))
  mydata<-select(mydata,Date,Time,newdate,Global_active_power)
}
mydata<-tbl_df(mydata)
plot(mydata$newdate,mydata$Global_active_power,type="l",main = "", xlab="", ylab="Global Active Power (kilowatts")

dev.copy(png,"plot2.png")
dev.off()
