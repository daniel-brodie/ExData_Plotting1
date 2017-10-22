

if (!exists("allData")) {
  allData<-read.table("household_power_consumption.txt",sep=";",na.strings="?", header=TRUE)
}
if (!exists("mydata")) {
  mydata<-subset(allData,allData$Date=="1/2/2007"|allData$Date=="2/2/2007")
}
hist(mydata$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")

dev.copy(png,"plot1.png")
dev.off()
