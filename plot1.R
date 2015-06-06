#read entire file
alldata<-read.csv("./household_power_consumption.txt",sep=";",na.strings="?")

#Convert date  to date format using strptime
alldata$Date<-strptime(alldata$Date,format="%d/%m/%Y")

#Convert the time to time format using strptime and only extract the time component
alldata$Time<-sub(".* ","",strptime(alldata$Time,format="%H:%M:%S"))

#Subset the data and extract only for 1st and 2nd Feb
alldata<-alldata[(alldata$Date>="2007-02-01" & alldata$Date <= "2007-02-02"),]

#Plot histogram of global active power and save to file
png("plot1.png",width=480,height=480)
hist(alldata$Global_active_power,main="Global Active Power",xlab="Global Active Power(kilowatts)",ylab="Frequency",col="orangered")
dev.off()
