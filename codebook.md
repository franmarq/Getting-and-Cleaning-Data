## The purpose of this project is to prepare tidy data that can be used for later analysis. 
## the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 
## also include a README.md in the repo with your scripts. This repo explains how all of the
## scripts work and how they are connected.  

## One of the most exciting areas in all of data science right now is wearable computing. Companies like 
## Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
## The data linked to from the course website represent data collected from the accelerometers from the 
## Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Here are the data for the project: 
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## You should create one R script called run_analysis.R that does the following: 
## 1.- Merges the training and the test sets to create one data set.
## 2.- Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3.- Uses descriptive activity names to name the activities in the data set
## 4.- Appropriately labels the data set with descriptive variable names. 
## 5.- From the data set in step 4, creates a second, independent tidy data set with the average 
## of each variable for each activity and each subject.


## First, get the data 

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

## Unzip the file
unzip(zipfile="./data/Dataset.zip",exdir="./data")

## List of unzipped files are in /UCI HAR Dataset folder.
ruta <- file.path("./data" , "UCI HAR Dataset")
archivos<-list.files(ruta, recursive=TRUE)
archivos

## Read data from the files into the variables. there area three types of target files: Activity, subjects and features   

## Activity files
datActTest  <- read.table(file.path(ruta, "test" , "Y_test.txt" ),header = FALSE)
datActTrain <- read.table(file.path(ruta, "train", "Y_train.txt"),header = FALSE)
## Subject files
datSubTrain <- read.table(file.path(ruta, "train", "subject_train.txt"),header = FALSE)
datSubTest  <- read.table(file.path(ruta, "test" , "subject_test.txt"),header = FALSE)
## Features files
datFeaTest  <- read.table(file.path(ruta, "test" , "X_test.txt" ),header = FALSE)
datFeaTrain <- read.table(file.path(ruta, "train", "X_train.txt"),header = FALSE)


## 1.- Merges the training and the test sets to create one data set
##-----------------------------------------------------------------

## Concatenate the data tables by rows
datSub <- rbind(datSubTrain, datSubTest)
datAct <- rbind(datActTrain, datActTest)
datFea <- rbind(datFeaTrain, datFeaTest)

## Set names to variables
names(datSub) <- c("subject")
names(datAct) <- c("activity")
datFeaNames <- read.table(file.path(ruta, "features.txt"),head=FALSE)
names(datFea) <- datFeaNames$V2

## 2.- Merge columns to get the data frame Data for all data
##------------------------------------------------------

datComb <- cbind(datSub, datAct)
Data <- cbind(datFea, datComb)


## 3.- Extracts only the measurements on the mean and standard deviation for each measurement
##---------------------------------------------------------------------------------------

## Subset Name of Features by measurements on the mean and standard deviation
## i.e taken Names of Features with “mean()” or “std()”

subdatFeaNames <- datFeaNames$V2[grep("mean\\(\\)|std\\(\\)", datFeaNames$V2)]

## Subset the data frame Data by seleted names of Features
selectedNames <- c(as.character(subdatFeaNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)
## checking the result
head(Data,3)



## 4.- Uses descriptive activity names to name the activities in the data set
##-----------------------------------------------------------------------

## Read descriptive activity names from “activity_labels.txt”
actLabels <- read.table(file.path(ruta, "activity_labels.txt"),header = FALSE)

## Replaces the values in the Varibale Activity with the values in the file activity_labels.txt
activity.ID = 1
for (actLab in actLabels$V2) {
    Data$activity <- gsub(activity.ID, actLab, Data$activity)
    activity.ID <- activity.ID + 1
}
#check
head(Data)
tail(Data)
## check
head(Data$activity,40)


## 4.- Appropriately labels the data set with descriptive variable names
##----------------------------------------------------------------------

##prefix t is replaced by time
##prefix Acc is replaced by Accelerometer
##Gyro is replaced by Gyroscope
##prefix f is replaced by frequency
##Mag is replaced by Magnitude
##BodyBody is replaced by Body

names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))


## 5.- Creates a second, independent tidy data set with the average of each variable for each activity 
## and each subject. 
##----------------------------------------------------------------------------------------------------

dataAve <- aggregate(x=Data, by=list(activities=Data$activity, subj=Data$subject), FUN=mean)
dataAve <- dataAve[, !(colnames(dataAve) %in% c("subj", "activity"))]
str(dataAve)
write.table(dataAve, './data/dataAve.txt', row.names = F)

## Make a codeBook
install.packages("knitr")
library("knitr")
knit2html("codebook.Rmd")
knit("makeCodebook.Rmd", output = "codebook.md", encoding = "ISO8859-1", quiet = TRUE)

