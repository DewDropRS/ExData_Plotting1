##******************************************************************************
## 		Script name:	plot1.R
## 		Course:				Exporatory Data Analysis
##		Assignment: 	Course Project
## 		Author: 			Rocio Ana-Sofia Segura
##		R-version: 		3.1.2
## 		Packages: 		data.table, dplyr, chron
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
  mutate(dateandtime= paste(Date, Time, sep=' '), TimeSampled = as.POSIXct(dateandtime, format = '%d/%m/%Y %H:%M:%S')) 

head(hpc_pro)

## Plot 1
with(hpc_pro, hist(Global_active_power, main = "Global Active Power", col = "red" , xlab = "Global Active Power (kilowatts)"))
dev.copy(png, file = "plot1.png")
dev.off()

