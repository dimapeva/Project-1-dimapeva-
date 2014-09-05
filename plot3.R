# Reading data (with some modifications from Rene Shiou-Ling Wang suggestion)

hpc<-file("household_power_consumption.txt","r");
consum<-read.table(text = grep("^[1,2]/2/2007",readLines(hpc),value=TRUE), sep = ";",dec = ".", na.strings='?')
colnames(consum)<-c('Date','Time','Global_active_power','Global_reactive_power','Voltage','Global_intensity','Sub_metering_1','Sub_metering_2','Sub_metering_3' )
head(consum)

# Converting the Date and Time variables to Date/Time classes 

datetime<-strptime(paste(consum$Date, consum$Time), format = "%d/%m/%Y %H:%M:%S")
Sys.setlocale("LC_TIME", "English") # setting local time zone

# plot3

png(filename = "plot3.png", width = 480, height = 480, units = "px") ## Copy my plot to a PNG file
with(consum,plot(datetime,Sub_metering_1,ylab='Energy sub metering',col=1,type='l',xlab=''))
with(consum,lines(datetime,Sub_metering_2,ylab='',col=2,type='l'))
with(consum,lines(datetime,Sub_metering_3,ylab='',col=4,type='l'))
legend('topright',names(consum[,7:9]),col=c(1,2,4),lty=1)
dev.off()