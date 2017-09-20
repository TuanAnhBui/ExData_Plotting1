library(lubridate)
library(dplyr)
# Find the period of time between 1/2/2007 and 2/2/2007

period<-grep("^(1/2/2007|2/2/2007)",readLines("household_power_consumption.txt"))

# Extract the required information form the given data

dataset<-read.table("household_power_consumption.txt",skip=period[1]-1,
    nrows = length(period),sep = ";",na.strings = "?",stringsAsFactors = FALSE)

# Extract the variables

variables<-as.character(read.table("household_power_consumption.txt",nrows = 1,sep = ";",stringsAsFactors = FALSE)[1,])

# Names the column in data by variables
names(dataset)<-variables

# Add a new column called DateTime for joining a specific time line
dataset<-dataset%>%mutate(DateTime=dmy_hms(paste(Date,Time)))

# Plot the histogram and save to a png file named "plot1.png"
png("plot1.png",height=480,width=480)
hist(dataset$Global_active_power,col="red",main = "Global Active Power",xlab = "Global Active Power (killowatts)", ylab = "Frequency")
dev.off()