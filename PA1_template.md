# Reproducible Research, Project 1
Robert Schwartz  
May 29, 2016  



###Abstract
This report is the first project for the Reproducible Research course offered on Coursera by Johns Hopkins Univeristy. The assignment makes use of data from a personal activity monitoring device. This device collects data at 5 minute intervals through out the day. The data consists of two months of data from an anonymous individual collected during the months of October and November, 2012 and include the number of steps taken in 5 minute intervals each day. The report uses descriptive statistics to analyse the frequency of steps, with and without data imputation,at different intervals and days of the week.  


```r
#Read in data
df <- read.csv("activity.csv")
```

###What is the mean total number of steps taken per day?

For the first few questions, the instructions for the assignment said to "ignore the missing values in the dataset." I interpretted this to mean remove the missing values, and so rows with missing values are omitted for the first few calculations and plots.


```r
#Remove rows with missing data
df.narm <- df[complete.cases(df), ]
```

Table 1 shows the total number of steps taken per day.  


```r
#Load xtable
library(xtable)

#Calculate total number of steps taken per day
sum.date <- aggregate(df.narm$steps, list(df.narm$date), sum)
names(sum.date) <- c("Date", "Sum")
print(xtable(sum.date, caption = "Table 1: Total Number of Steps per Day"), caption.placement = "top", type = "html", include.rownames = FALSE)
```

<!-- html table generated in R 3.2.3 by xtable 1.8-2 package -->
<!-- Sun Jun 12 14:45:39 2016 -->
<table border=1>
<caption align="top"> Table 1: Total Number of Steps per Day </caption>
<tr> <th> Date </th> <th> Sum </th>  </tr>
  <tr> <td> 2012-10-02 </td> <td align="right"> 126 </td> </tr>
  <tr> <td> 2012-10-03 </td> <td align="right"> 11352 </td> </tr>
  <tr> <td> 2012-10-04 </td> <td align="right"> 12116 </td> </tr>
  <tr> <td> 2012-10-05 </td> <td align="right"> 13294 </td> </tr>
  <tr> <td> 2012-10-06 </td> <td align="right"> 15420 </td> </tr>
  <tr> <td> 2012-10-07 </td> <td align="right"> 11015 </td> </tr>
  <tr> <td> 2012-10-09 </td> <td align="right"> 12811 </td> </tr>
  <tr> <td> 2012-10-10 </td> <td align="right"> 9900 </td> </tr>
  <tr> <td> 2012-10-11 </td> <td align="right"> 10304 </td> </tr>
  <tr> <td> 2012-10-12 </td> <td align="right"> 17382 </td> </tr>
  <tr> <td> 2012-10-13 </td> <td align="right"> 12426 </td> </tr>
  <tr> <td> 2012-10-14 </td> <td align="right"> 15098 </td> </tr>
  <tr> <td> 2012-10-15 </td> <td align="right"> 10139 </td> </tr>
  <tr> <td> 2012-10-16 </td> <td align="right"> 15084 </td> </tr>
  <tr> <td> 2012-10-17 </td> <td align="right"> 13452 </td> </tr>
  <tr> <td> 2012-10-18 </td> <td align="right"> 10056 </td> </tr>
  <tr> <td> 2012-10-19 </td> <td align="right"> 11829 </td> </tr>
  <tr> <td> 2012-10-20 </td> <td align="right"> 10395 </td> </tr>
  <tr> <td> 2012-10-21 </td> <td align="right"> 8821 </td> </tr>
  <tr> <td> 2012-10-22 </td> <td align="right"> 13460 </td> </tr>
  <tr> <td> 2012-10-23 </td> <td align="right"> 8918 </td> </tr>
  <tr> <td> 2012-10-24 </td> <td align="right"> 8355 </td> </tr>
  <tr> <td> 2012-10-25 </td> <td align="right"> 2492 </td> </tr>
  <tr> <td> 2012-10-26 </td> <td align="right"> 6778 </td> </tr>
  <tr> <td> 2012-10-27 </td> <td align="right"> 10119 </td> </tr>
  <tr> <td> 2012-10-28 </td> <td align="right"> 11458 </td> </tr>
  <tr> <td> 2012-10-29 </td> <td align="right"> 5018 </td> </tr>
  <tr> <td> 2012-10-30 </td> <td align="right"> 9819 </td> </tr>
  <tr> <td> 2012-10-31 </td> <td align="right"> 15414 </td> </tr>
  <tr> <td> 2012-11-02 </td> <td align="right"> 10600 </td> </tr>
  <tr> <td> 2012-11-03 </td> <td align="right"> 10571 </td> </tr>
  <tr> <td> 2012-11-05 </td> <td align="right"> 10439 </td> </tr>
  <tr> <td> 2012-11-06 </td> <td align="right"> 8334 </td> </tr>
  <tr> <td> 2012-11-07 </td> <td align="right"> 12883 </td> </tr>
  <tr> <td> 2012-11-08 </td> <td align="right"> 3219 </td> </tr>
  <tr> <td> 2012-11-11 </td> <td align="right"> 12608 </td> </tr>
  <tr> <td> 2012-11-12 </td> <td align="right"> 10765 </td> </tr>
  <tr> <td> 2012-11-13 </td> <td align="right"> 7336 </td> </tr>
  <tr> <td> 2012-11-15 </td> <td align="right">  41 </td> </tr>
  <tr> <td> 2012-11-16 </td> <td align="right"> 5441 </td> </tr>
  <tr> <td> 2012-11-17 </td> <td align="right"> 14339 </td> </tr>
  <tr> <td> 2012-11-18 </td> <td align="right"> 15110 </td> </tr>
  <tr> <td> 2012-11-19 </td> <td align="right"> 8841 </td> </tr>
  <tr> <td> 2012-11-20 </td> <td align="right"> 4472 </td> </tr>
  <tr> <td> 2012-11-21 </td> <td align="right"> 12787 </td> </tr>
  <tr> <td> 2012-11-22 </td> <td align="right"> 20427 </td> </tr>
  <tr> <td> 2012-11-23 </td> <td align="right"> 21194 </td> </tr>
  <tr> <td> 2012-11-24 </td> <td align="right"> 14478 </td> </tr>
  <tr> <td> 2012-11-25 </td> <td align="right"> 11834 </td> </tr>
  <tr> <td> 2012-11-26 </td> <td align="right"> 11162 </td> </tr>
  <tr> <td> 2012-11-27 </td> <td align="right"> 13646 </td> </tr>
  <tr> <td> 2012-11-28 </td> <td align="right"> 10183 </td> </tr>
  <tr> <td> 2012-11-29 </td> <td align="right"> 7047 </td> </tr>
   </table>
  
Figure 1 shows the frequency of days in which a given number of total steps occurred. Each bar counts a range of 500 steps.


```r
#Load ggplot2
library(ggplot2)

#Make a histogram of the total number of steps taken each day
g1 <- ggplot(data = sum.date, aes(Sum)) + 
      geom_histogram(binwidth = 500) +
      labs(title = "Figure 1: Histogram of Total Steps per Day (NAs Omitted)", x= "Total Steps per Day", y = "Count of Days") +
      coord_cartesian(ylim = c(0, 11)) 
g1       
```

![](PA1_template_files/figure-html/unnamed-chunk-4-1.png)

```r
#Calculate and report the mean and median of the total number of steps taken per day
mean.date <- mean(sum.date$Sum)
median.date <- median(sum.date$Sum)
```

The mean and median of the total number of steps taken per day are 10766.19 and 10765, respectively.

###What is the average daily activity pattern?

Figure 2 is a time series plot displaying the average number of steps taken during each 5-minute interval across all days. A typical day goes like this: the subject wakes up a little after interval 500 (~50 steps per interval); the peak activity of the day is between intervals 800 and 950 (100-200 steps per interval); between interval 950 and 1900, the number of steps zigzags between 25 to 100; after interval 1900, steps begin falling and reach zero at interval 2500. 


```r
##Time series plot of the average daily activty pattern
mean.interval <- aggregate(df.narm$steps, list(df.narm$interval), mean)
names(mean.interval) <- c("interval", "mean")

g2 <- ggplot(data = mean.interval, aes(interval, mean)) + 
      geom_line() +
      labs(title = "Figure 2: Times Series Plot of Average Number of Steps by Interval", y = "Mean Steps", x = "Interval")
g2
```

![](PA1_template_files/figure-html/unnamed-chunk-5-1.png)

```r
##The 5-minute interval that, on average, contains the maximum number of steps

max.interval<- mean.interval[mean.interval[,2]==max(mean.interval$mean),]
```

Interval 835 has the greatest number of steps on average across all the days in the dataset: 206.

###Imputing missing values

All the previous analyses were run on the dataset with observations with missing values removed. Now values will be imputed to NAs in the dataset.


```r
#Calculate total number of rows with missing values
na.num <- nrow(df)-sum(complete.cases(df))
```

The total number of rows with missing values in the dataset is 2304.

Missing values of step counts are filled with the mean of the corresponding 5-minute interval across all days.


```r
#Create copy of original dataframe for adding in imputed data
df.imp <- df

#Impute mean of each interval to missing data points 
for (i in mean.interval$interval) {
      isna <- is.na(df.imp$steps) & df.imp$interval==i
      df.imp$steps[which(isna)] <- mean.interval$mean[mean.interval$interval==i]
} 
```

Figure 3 is a histogram of the total number of steps taken each day. Each bar counts a range of 500 steps.


```r
##Histogram of total steps per day (With Imputed Data)
sum.date2 <- aggregate(df.imp$steps, list(df.imp$date), sum)
names(sum.date2) <- c("date", "sum")

g3 <- ggplot(data = sum.date2, aes(sum)) + 
      geom_histogram(binwidth = 500) +
      labs(title = "Figure 3: Histogram of Total Steps per Day (With Imputed Data)", x= "Total Steps per Day", y = "Count of Days") +
      coord_cartesian(ylim = c(0, 11))
g3
```

![](PA1_template_files/figure-html/unnamed-chunk-8-1.png)

```r
#Mean and median total number of steps taken per day (With Imputed Data)
mean.date2 <- mean(sum.date2$sum)
median.date2 <- median(sum.date2$sum)
```

The mean and median of the total number of steps taken per day are 10766.19 and 10766.19, respectively.

The estimates of the median and mean number of steps per day are nearly identical between the dataset with NAs removed and the dataset with imputed data. The data imputation process added 2304 means of 5-minute intervals to the dataset. This can be seen by comparing the two histograms of total steps per day: 8 days were added to the bar containing the days with imputed (Days either had complete data or they were missing all data, so the new days had exactly the same data and means.). It is not surprising that adding means to the data had the effect of keeping the mean steps per day the same (10766.19) and moved the median so that it became equal to the mean (10765 to 10766.19). 

###Are there differences in activity patterns between weekdays and weekends?

Figure 4 is a time series plot showing the average number of steps taken for each 5-minute interval for weekdays and weekends separately. Weekdays have more activity early in the day, whereas weekends have more activity later in the day.


```r
#Create a new factor variable in the dataset with two levels – “weekday” and “weekend” indicating whether a given date is a weekday or weekend day.

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
df.imp$weekday <- factor(df.imp$weekday)

#Make a panel plot containing a time series plot of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). 

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
      labs(title = "Figure 4: Time Series Plot of the Average Steps per Interval \n for Weekdays and Weekdays", x= "Interval", y = "Mean Steps")
g4
```

![](PA1_template_files/figure-html/unnamed-chunk-9-1.png)
