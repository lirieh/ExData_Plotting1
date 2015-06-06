#read entire file
alldata<-read.csv("./household_power_consumption.txt",sep=";",na.strings="?")

#Convert date  to date format using strptime
alldata$Date<-strptime(alldata$Date,format="%d/%m/%Y")

#Convert the time to time format using strptime and only extract the time component
alldata$Time<-sub(".* ","",strptime(alldata$Time,format="%H:%M:%S"))

#Subset the data and extract only for 1st and 2nd Feb
alldata<-alldata[(alldata$Date>="2007-02-01" & alldata$Date <= "2007-02-02"),]

subdata<-data.frame()
#Combine date and time into 1 column and set it to Date class
alldata$Date<-paste(alldata$Date,alldata$Time,sep=" ")
alldata<-alldata[,!(colnames(alldata) %in% ("Time"))]
alldata$Date<-strptime(alldata$Date,format="%Y-%m-%d %H:%M:%S")

#Plot graph of global active power and time  and save to file
png("plot2.png",width=480,height=480)
plot(alldata$Date,alldata$Global_active_power,main=" ",xlab=" ",
     ylab="Global Active Power (kilowatts)", type="l")
dev.off()
