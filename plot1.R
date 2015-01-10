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

# plot 1
png("./data/plot1.png", width = 480, height = 480)
with(assign, hist(Global_active_power, col="red", ann=FALSE))
title(main = "Global Active Power",
      xlab = "Global Active Power (kilowatts)",
      ylab = "Frequency")
dev.off()

