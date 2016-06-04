##Download data
download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip")

##Read in data and view it
df <- read.csv("activity.csv")

##Remove rows with missing data. 
df.narm <- df[complete.cases(df), ]

summary(df.narm)
str(df.narm)
summary(df.narm$date)

##Install and Load ggplot2
install.packages(ggplot2)
library(ggplot2)

##Histogram of steps per day
sum.date <- aggregate(df.narm$steps, list(df.narm$date), sum)
names(sum.date) <- c("Date", "Sum")
print(xtable(sum.date, caption = "Table 1: Total Number of Steps per Day"), caption.placement = "top", type = "html", include.rownames = FALSE)

g1 <- ggplot(data = sum.date, aes(sum)) + 
      geom_histogram(binwidth = 500) +
      labs(title = "Histogram of Total Steps per Day (NAs Omitted)", x= "Total Steps per Day", y = "Count of Days") +
      coord_cartesian(ylim = c(0, 11)) 
g1   

##Mean and median of steps per day
mean(sum.date$Sum)
median(sum.date$Sum)

      #Misread text. Calculated wrong numbers below     
      #mean.date <- aggregate(df.narm$steps, list(df.narm$date), mean)
      #median.date <- aggregate(df.narm$steps, list(df.narm$date), median)
      #names(mean.date) <- c("date", "mean")
      #names(median.date) <- c("date", "median")
      #mean.date
      #median.date

##Time series plot of the average daily activty pattern
mean.interval <- aggregate(df.narm$steps, list(df.narm$interval), mean)
names(mean.interval) <- c("interval", "mean")
mean.interval

g2 <- ggplot(data = mean.interval, aes(interval, mean)) + 
      geom_line() +
      labs(title = "Times Series Plot of Average Number of Steps by Interval", y = "Mean Steps", x = "Interval")
g2

##The 5-minute interval that, on average, contains the maximum number of steps

max.interval<- mean.interval[mean.interval[,2]==max(mean.interval$mean),]
max.interval


##Impute
#Calculate total number of rows with missing values
nrow(df)-sum(complete.cases(df))

#Create copy of original dataframe for adding in imputed data
df.imp <- df

#Impute mean of each interval to missing data points 
for (i in mean.interval$interval) {
      isna <- is.na(df.imp$steps) & df.imp$interval==i
      df.imp$steps[which(isna)] <- mean.interval$mean[mean.interval$interval==i]
} 

##Histogram of total steps per day (With Imputed Data)
sum.date2 <- aggregate(df.imp$steps, list(df.imp$date), sum)
names(sum.date2) <- c("date", "sum")

g3 <- ggplot(data = sum.date2, aes(sum)) + 
      geom_histogram(binwidth = 500) +
      labs(title = "Histogram of Total Steps per Day (With Imputed Data)", x= "Total Steps per Day", y = "Count of Days") +
      coord_cartesian(ylim = c(0, 11))
g3



##Mean and median total number of steps taken per day (With Imputed Data)
mean.date2 <- aggregate(df.imp$steps, list(df.imp$date), mean)
median.date2 <- aggregate(df.imp$steps, list(df.imp$date), median)
names(mean.date2) <- c("date", "mean")
names(median.date2) <- c("date", "median")
mean.date2
median.date2

##Are there differences in activity patterns between weekdays and weekends?

df.imp$n.date <- as.POSIXlt(df.imp$date)
df.imp$day <- weekdays(df.imp$n.date)
View(df.imp)

df.imp$weekday <- rep(NA, 17568)
for(i in seq(df.imp$day)) {
      if (df.imp$day[i] == "Saturday" | df.imp$day[i] ==  "Sunday") {
            df.imp$weekday[i] <- "weekend"
      } else {df.imp$weekday[i] <- "weekday"
      }
}
View(df.imp)

df.imp$weekday <- factor(df.imp$weekday)

##Make a panel plot containing a time series plot (i.e. 𝚝𝚢𝚙𝚎 = "𝚕") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis).

df.wd <- df.imp[df.imp$weekday == "weekday",]
df.we <- df.imp[df.imp$weekday == "weekend",]
mean.int.wd <- aggregate(df.wd$steps, list(df.wd$interval), mean)
names(mean.int.wd) <- c("interval", "mean")
mean.int.we <- aggregate(df.we$steps, list(df.we$interval), mean)
names(mean.int.we) <- c("interval", "mean")
mean.int.wd$weekday <- "weekday" 
mean.int.we$weekday <- "weekend"
mean.interval2 <- rbind(mean.int.wd, mean.int.we)


g4 <- ggplot(data = mean.interval2, aes(interval, mean)) + 
      facet_grid(weekday ~ .) + 
      geom_line() +
      labs(title = "Time Series Plot of the Average Steps per Interval \n for Weekdays and Weekdays", x= "Interval", y = "Mean Steps")
g4





#model code for imputation
dft = data.frame(x = rep(1:5, 4), y = c(1:10,rep(NA,10)))
dft.na.rm <- dft[complete.cases(dft),] 
men <- aggregate(dft.na.rm$y, list(dft.na.rm$x), mean)

View(dft)
View(dft.na.rm)
View(men)

for (i in men$Group.1) {
      isna <- is.na(dft$y) & dft$x==i
      dft$y[which(isna)] <- men$x[men$Group.1==i]
}
