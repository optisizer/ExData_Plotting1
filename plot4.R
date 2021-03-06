# Download and zip to file
if (!file.exists("data"))  {dir.create("data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("./data/assign2.csv"))  {
    download.file(fileURL, destfile="./data/assign2.zip")
}
zipfile <- "./data/assign2.zip"
unzip(zipfile, exdir="./Data/zipped")
# Read and subset
assign <- read.table("./data/zipped/household_power_consumption.txt",
                     sep=";", na.strings="?", header=TRUE)
assign <- subset(assign, Date=="1/2/2007" | Date=="2/2/2007")
# Format date and time
assign$datetime <- paste(assign$Date, assign$Time, sep = " ")
assign$datetime <- strptime(assign$datetime, format="%d/%m/%Y %H:%M:%S")
# Check all is ok
head(assign)
tail(assign)
summary(assign)
str(assign)

# plot 4
png("./data/plot4.png", width = 480, height = 480)
par(mfcol=c(2, 2))

with(assign, plot(datetime, Global_active_power, 
                  type="l", col="black", ann=FALSE))
title(ylab = "Global Active Power")

with(assign, {
    plot(datetime, Sub_metering_1, type="l", col="black", ann=FALSE)
    lines(datetime, Sub_metering_2, type="l", col="red")
    lines(datetime, Sub_metering_3, type="l", col="blue")
    legend("topright", lty="solid",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           col=c("black", "red", "blue"), bty="n", cex=0.9)
})
title(ylab = "Energy sub metering")

with(assign, plot(datetime, Voltage, type="l", col="black"))

with(assign, plot(datetime, Global_reactive_power, type="l", col="black"))
par(mfcol=c(1, 1))
dev.off()

