##check if already have dataset, if not, download and unzip
if(!file.exists("household_power_consumption.txt")){
        
        ##download and unzip files to local
        url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(url, "dataset.zip")
        unzip("dataset.zip")}

#read data and format Date and Time

data<-read.table("household_power_consumption.txt",header=T,sep=";")
library(lubridate)
data$new_time<-dmy_hms(paste(data$Date,data$Time))
data$Date<-dmy(data$Date)
data$Time<-hms(data$Time)

#subsetting only data from 2007-02-01 and 2007-02-01

data1<-subset(data, Date=="2007-02-01"|Date=="2007-02-02")

#converting factors variables into numeric variables while preserving decimal

data1[]<-lapply(data1,function(x){if(is.factor(x))as.numeric(as.character(x))else x})


#plot3
png(file="plot3.png")
plot(data1$new_time, data1$Sub_metering_1, ylim=range(data1$Sub_metering_1),type="l",xlab= "", ylab = "Energy sub metering", col="black")
lines(data1$new_time, data1$Sub_metering_2,col="red")
lines(data1$new_time, data1$Sub_metering_3,col="blue")
legend("topright",lty=c(1,1,1), col=c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

