# Read in the file, and subset to the relevant data 
df <- read.csv(unz("exdata_data_household_power_consumption.zip", "household_power_consumption.txt"), sep=';')
df1 <- transform(df, dt = strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))
df2 <- df1[df1[, 'dt'] >= strptime('2007-02-01', '%Y-%m-%d') & df1[, 'dt'] < strptime('2007-02-03', '%Y-%m-%d') & !is.na(df1[, 'dt']), ]

# Get the required sub-metering data
dt <- df2[, 'dt']
sm1 <- as.numeric(levels(df2[, 'Sub_metering_1']))[df2[, 'Sub_metering_1']]
sm2 <- as.numeric(levels(df2[, 'Sub_metering_2']))[df2[, 'Sub_metering_2']]
sm3 <- df2[, 'Sub_metering_3']

# Plot the required graph; directly storing to png file as legend gets cut-off with dev.copy
png(file = 'plot3.png')
plot(dt, sm1, type = 'l', xlab = '', ylab = 'Energy sub metering', ylim = range(min(sm1, sm2, sm3), max(sm1, sm2, sm3)))
par(new = TRUE)
plot(dt, sm2, type = 'l', col = 'red', axes = FALSE, xlab = '', ylab = '', ylim = range(min(sm1, sm2, sm3), max(sm1, sm2, sm3)))
par(new = TRUE)
plot(dt, sm3, type = 'l', col = 'blue', axes = FALSE, xlab = '', ylab = '', ylim = range(min(sm1, sm2, sm3), max(sm1, sm2, sm3)))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), lwd = c(2, 2, 2), col = c("black", "red", "blue"))
dev.off()
