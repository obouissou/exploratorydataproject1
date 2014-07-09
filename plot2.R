# Reads data and filter out all except two dates
init <- read.csv("household_power_consumption.txt", header=TRUE, as.is=TRUE, sep=";", na.strings="?")
epc <- init[as.Date(init$Date, format="%d/%m/%Y")=="2007-02-01" | as.Date(init$Date, format="%d/%m/%Y")=="2007-02-02",]
remove(init)
# Aggregates the two first columns into DateTime column and remove the two first columns
epc <- cbind(DateTime=strptime(paste(epc$Date,epc$Time),"%d/%m/%Y %H:%M:%S"),epc[,-1:-2])
# Set the localisation for datetime to us otherwise daynames are in local language, not in english
Sys.setlocale("LC_TIME", "us")     
with(epc,plot(DateTime,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))


dev.copy(png, file = "plot2.png", width = 480, height = 480) 
dev.off()
