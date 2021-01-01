#grab first year's worth of data
minutes_in_a_year <- 60*24*365

#define classes of variables while reading in 
data <- read.table(colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),file="./data/household_power_consumption.txt",header=T,sep=";",na.strings="?",nrows=minutes_in_a_year)

#convert Date field to Date type
data$Date <- as.Date(data$Date,"%d/%m/%Y")

#extract desired days
two_days <- subset(data,Date==as.Date("2007-02-01","%Y-%m-%d") | Date==as.Date("2007-02-02","%Y-%m-%d"))

#build graph
with(two_days,hist(Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts"))

#create the png file
dev.copy(png,"plot1.png",width=480,height=480)

#save it and close device
dev.off()
