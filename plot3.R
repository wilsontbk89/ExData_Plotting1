## Estimate rough estimate of how much memory the dataset will require in memory 
## nrows*ncol * 8 bytes / 2^20 mb
est.mem<-2075259*9 * 8/ 2^20 ## in mb
## Computer has >> 3 times the required memory, hence it is fine to proceed.

## Getting full dataset
data_full <- read.csv("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

## Subsetting the data
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full) ## do not store full dataset

## Converting dates to the required format
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Plot 3
with(data, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Energy sub metering", xlab="")
  ## Add the other two plots on the same plot
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving to file in the required format/style
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()