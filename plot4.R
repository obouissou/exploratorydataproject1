# Reads data and filter out all except two dates
init <- read.csv("household_power_consumption.txt", header=TRUE, as.is=TRUE, sep=";", na.strings="?")
epc <- init[as.Date(init$Date, format="%d/%m/%Y")=="2007-02-01" | as.Date(init$Date, format="%d/%m/%Y")=="2007-02-02",]
remove(init)
# Aggregates the two first columns into DateTime column and remove the two first columns
epc <- cbind(DateTime=strptime(paste(epc$Date,epc$Time),"%d/%m/%Y %H:%M:%S"),epc[,-1:-2])
# Set the localisation for datetime to us otherwise daynames are in local language, not in english
Sys.setlocale("LC_TIME", "us")


# 2 x 2 plots, ordered by columns
par(mfcol=c(2,2))


# plot 1
with(epc,plot(DateTime,Global_active_power,type="l",xlab="",ylab="Global Active Power"))


# Plot 2
with(epc,plot(DateTime,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering"))
# display 3 meterings
with(epc,lines(DateTime,Sub_metering_1,col="black"))
with(epc,lines(DateTime,Sub_metering_2,col="red"))
with(epc,lines(DateTime,Sub_metering_3,col="blue"))
# display legend
legend("topright",legend=c("Sub_metering_1     ","Sub_metering_2     ","Sub_metering_3     "),col=c("black","red","blue"), lty=1, cex=0.9)


# plot 3
with(epc,plot(DateTime,Voltage,type="l",xlab="datetime"))


# plot 4
with(epc,plot(DateTime,Global_reactive_power,type="l",xlab="datetime"))



dev.copy(png, file = "plot4.png", width = 480, height = 480) 
dev.off()
