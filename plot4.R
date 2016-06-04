##******************************************************************************
## 		Script name:	plot4.R
## 		Course:				Exploratory Data Analysis
##		Assignment: 	Course Project
## 		Author: 			Rocio Ana-Sofia Segura
##		R-version: 		3.1.2
## 		Packages: 		data.table, dplyr, chron, lubridate
## 		Description:

## For each plot you should
## Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
## Name each plot files as plot1.png, plot2.png, etc.
## Create a separate R code file plot1.R, plot2.R, etc.) that constructs the corresponding
## plot, i.e. code in plot1.R constructs plot1.png plot. Your code file should include code 
## for reading the data so that the plot can be fully reproduced. You must also include the 
## code that creates the PNG file.
## Add the PNG file and R code file to the top-level folder of your git repository (no need for separate sub-folders)
## When you are finished with the assignment, push your git repository to GitHub so that the 
## GitHub version of your repository is up to date. There should be four PNG files and four R 
## code files, a total of eight files in the top-level folder of the repo.
## 1. load libraries

library(data.table)
library(dplyr)
library(chron)
library(lubridate)



## 2. Set working directory
setwd("~/coursera/ExploratoryDataAnalysis/ExData_Plotting1")
getwd()

## 3. Import data and examine
## skip=grep(c("2007/02/01","2007/02/02"), readLines("File.txt")
hpc		      <- read.table("/Users/rociosegura/coursera/ExploratoryDataAnalysis/data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings="?")
head(hpc)
str(hpc)

## 4. Filter data and convert date factors to date types
hpc_pro <- hpc %>% 
  filter(Date %in% c("1/2/2007", "2/2/2007")) %>% 
  mutate(dateandtime= paste(Date, Time, sep=' '), DateSampled = as.Date(Date, format = '%d/%m/%Y'), datetime = as.POSIXct(dateandtime, format = '%d/%m/%Y %H:%M:%S'), wkofdy = wday(DateSampled, label=TRUE)) 
hpc_pro <- transform(hpc_pro, wkofdy = factor(wkofdy))
head(hpc_pro)


## Setup Multiple Base Plots
par(mfrow = (c(2,2)))

## Top Left
with(hpc_pro, {

  plot(datetime,Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

## Top Right

  plot(datetime,Voltage, type = "l")
})

## Bottom Left

with(hpc_pro, {
  plot(datetime, Sub_metering_1, main ="",ylab="Energy sub metering", xlab = "", type = "n")
  lines(datetime,Sub_metering_1, type = "l", col = "black")
  lines(datetime,Sub_metering_2, type = "l", col = "red")
  lines(datetime,Sub_metering_3, type = "l", col = "blue")
  legend("topright", col = c("black", "red", "blue"), lty=1, xpd = NA, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = .5, bty="n")
  
})

## Bottome Right

with(hpc_pro, {
  plot(datetime,Global_reactive_power, type = "l")
})

dev.copy(png, file = "plot4.png")
dev.off()



