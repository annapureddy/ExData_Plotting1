# Read in the file, and subset to the relevant data 
df <- read.csv(unz("exdata_data_household_power_consumption.zip", "household_power_consumption.txt"), sep=';')
df1 <- transform(df, dt = strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))
df2 <- df1[df1[, 'dt'] >= strptime('2007-02-01', '%Y-%m-%d') & df1[, 'dt'] < strptime('2007-02-03', '%Y-%m-%d') & !is.na(df1[, 'dt']), ]

# Plot the required graph
df3 <- df2[, 'Global_active_power']
df4 <- as.numeric(levels(df3))[df3]
plot(df2[, 'dt'], df4, type = 'l', ylab = 'Global Active Power (kilowatts)', xlab = '')

# Store as a png file
dev.copy(png, 'plot2.png')
dev.off()
