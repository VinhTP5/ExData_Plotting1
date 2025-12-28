## plot2.R
## Global Active Power over time (2007-02-01 to 2007-02-02)

zipfile <- "household_power_consumption.zip"
txtfile <- "household_power_consumption.txt"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists(txtfile)) {
  if (!file.exists(zipfile)) download.file(url, destfile = zipfile, mode = "wb")
  unzip(zipfile)
}

data <- read.table(txtfile,
                   header = TRUE,
                   sep = ";",
                   na.strings = "?",
                   stringsAsFactors = FALSE,
                   colClasses = c("character", "character", rep("numeric", 7)))

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
sub <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
sub$Datetime <- as.POSIXct(paste(sub$Date, sub$Time))  # "YYYY-MM-DD HH:MM:SS"

png("plot2.png", width = 480, height = 480)
plot(sub$Datetime, sub$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()
