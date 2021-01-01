#grab first year's worth of data
minutes_in_a_year <- 60*24*365

#define classes of variables while reading in 
data <- read.table(colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),file="./data/household_power_consumption.txt",header=T,sep=";",na.strings="?",nrows=minutes_in_a_year)

#merge Date and Time fields
library(dplyr)
data <- mutate(data,DateTime = paste(Date,Time,sep=" "))

#convert Date/Time field to Date type
data$DateTime <- strptime(data$DateTime,"%d/%m/%Y %H:%M:%S")

#extract desired days
two_days <- subset(data,DateTime>=strptime("2007-02-01","%Y-%m-%d") & DateTime<strptime("2007-02-03","%Y-%m-%d"))

#build graph
with(two_days,plot(DateTime,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=""))
with(two_days,lines(DateTime,Sub_metering_2,col="red"))
with(two_days,lines(DateTime,Sub_metering_3,col="blue"))
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1)

#create the png file
dev.copy(png,"plot3.png",width=480,height=480)

#save it and close device
dev.off()
