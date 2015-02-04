#Read data from file
# skip=66636,nrows=2880 indicate the start and count of rows for dates 01/02/2007 and 02/02/2007
# column names are specified because otherwise R uses the first row after "skip" to set column names
dfull<-read.csv("../household_power_consumption.txt",sep=";",skip=66636,nrows=2880,na.strings="?",stringsAsFactors=FALSE
                , col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# make an additional field: Date and time together; change types of fields "Date" and "Time"
dfull$DateTime<-strptime(paste(dfull$Date,dfull$Time),format="%d/%m/%Y %H:%M:%S")
dfull$Date<-as.Date(strptime(dfull$Date,format="%d/%m/%Y"))
dfull$Time<-strptime(dfull$Time,format="%H:%M:%S")

#open a png file for writing
png(filename="plot3.png", width=480, height=480, units="px")

# first make a scatter plot with only sub_metering_1; then add lines for _2 and _3; add legend
with(dfull, plot(DateTime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab=""))
with(dfull, lines(DateTime, Sub_metering_2, col="red"))
with(dfull, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lwd=1)

#close png file
dev.off()

#str(dfull)
