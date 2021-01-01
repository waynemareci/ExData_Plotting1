#grab first tow month's worth of data
minutes_in_60_days <- 60*24*60
data <- read.table(colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),file="./data/household_power_consumption.txt",header=T,sep=";",na.strings="?",nrows=minutes_in_60_days)

#merge Date and Time fields
library(dplyr)
data <- mutate(data,datetime = paste(Date,Time,sep=" "))

#convert Date/Time field to Date type
data$datetime <- strptime(data$datetime,"%d/%m/%Y %H:%M:%S")

#extract desired days
two_days <- subset(data,datetime>=strptime("2007-02-01","%Y-%m-%d") & datetime<strptime("2007-02-03","%Y-%m-%d"))

#setup graph display
par(mfrow=c(2,2),mar=c(4,4,3,1))

#top left graph
with(two_days,plot(datetime,Global_active_power,ylab="Global Active Power",xlab="",type="l"))

#top right graph
with(two_days,plot(datetime,Voltage,ylab="Voltage",type="l"))

#bottom left graph
with(two_days,plot(datetime,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=""))
with(two_days,lines(datetime,Sub_metering_2,col="red"))
with(two_days,lines(datetime,Sub_metering_3,col="blue"))
legend("topright",pt.cex=1,cex=.95,bty="n",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1)

#bottom right graph
with(two_days,plot(datetime,Global_reactive_power,type="l"))

#create the png file
dev.copy(png,"plot4.png",width=480,height=480)

#save it and close device
dev.off()
