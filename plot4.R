# Read in the file, and subset to the relevant data 
df <- read.csv(unz("exdata_data_household_power_consumption.zip", "household_power_consumption.txt"), sep=';')
df1 <- transform(df, dt = strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))
df2 <- df1[df1[, 'dt'] >= strptime('2007-02-01', '%Y-%m-%d') & df1[, 'dt'] < strptime('2007-02-03', '%Y-%m-%d') & !is.na(df1[, 'dt']), ]

# Plot the required panel of graphs
dt <- df2[, 'dt']
png(file = 'plot4.png')
par(mfrow = c(2, 2))
# Plot 1
gap <- as.numeric(levels(df2[, 'Global_active_power']))[df2[, 'Global_active_power']]
plot(dt, gap, type = 'l', xlab = '', ylab = 'Global Active Power')
# Plot 2
v <- as.numeric(levels(df2[, 'Voltage']))[df2[, 'Voltage']]
plot(dt, v, type = 'l', xlab = 'datetime', ylab = 'Voltage')
# Plot 3
sm1 <- as.numeric(levels(df2[, 'Sub_metering_1']))[df2[, 'Sub_metering_1']]
sm2 <- as.numeric(levels(df2[, 'Sub_metering_2']))[df2[, 'Sub_metering_2']]
sm3 <- df2[, 'Sub_metering_3']
plot(dt, sm1, type = 'l', xlab = '', ylab = 'Energy sub metering', ylim = range(min(sm1, sm2, sm3), max(sm1, sm2, sm3)))
par(new = TRUE)
plot(dt, sm2, type = 'l', col = 'red', axes = FALSE, xlab = '', ylab = '', ylim = range(min(sm1, sm2, sm3), max(sm1, sm2, sm3)))
par(new = TRUE)
plot(dt, sm3, type = 'l', col = 'blue', axes = FALSE, xlab = '', ylab = '', ylim = range(min(sm1, sm2, sm3), max(sm1, sm2, sm3)))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), lwd = c(2, 2, 2), col = c("black", "red", "blue"))
# Plot 4
grp <- as.numeric(levels(df2[, 'Global_reactive_power']))[df2[, 'Global_reactive_power']]
plot(dt, grp, type = 'l', xlab = 'datetime', ylab = 'Global_reactive_power')
dev.off()