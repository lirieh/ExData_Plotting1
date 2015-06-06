#read entire file
alldata<-read.csv("./household_power_consumption.txt",sep=";",na.strings="?")

#Convert date  to date format using strptime
alldata$Date<-strptime(alldata$Date,format="%d/%m/%Y")

#Convert the time to time format using strptime and only extract the time component
alldata$Time<-sub(".* ","",strptime(alldata$Time,format="%H:%M:%S"))

#Subset the data and extract only for 1st and 2nd Feb
alldata<-alldata[(alldata$Date>="2007-02-01" & alldata$Date <= "2007-02-02"),]

#Combine date and time into 1 column and set it to Date class
alldata$Date<-paste(alldata$Date,alldata$Time,sep=" ")
alldata<-alldata[,!(colnames(alldata) %in% ("Time"))]
alldata$Date<-strptime(alldata$Date,format="%Y-%m-%d %H:%M:%S")



#Plot graph of global active power and time  and save to file
png("plot4.png",width=480,height=480)
par(mfcol=c(2,2))

#Plot first graph
plot(alldata$Date,alldata$Global_active_power,main=" ",xlab=" ",
     ylab="Global Active Power (kilowatts)", type="l")

#Plot second graph
plot(alldata$Date,alldata$Sub_metering_1,main=" ",xlab=" ",
     ylab="Energy sub metering", type="l")
points(alldata$Date,alldata$Sub_metering_2,type="l",col="orangered")
points(alldata$Date,alldata$Sub_metering_3,type="l",col="blue")
legend(x="topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","orangered","blue"),lty=c(1,1,1),lwd=c(2,2,2),bty="n")

#Plot third graph
plot(alldata$Date,alldata$Voltage,main=" ",xlab="datetime", ylab="Voltage", type="l")


#Plot fourth graph
plot(alldata$Date,alldata$Global_reactive_power,main=" ",xlab="datetime", ylab="Global_reactive_power", type="l",yaxp=c(0.0,0.5,5))

dev.off()
