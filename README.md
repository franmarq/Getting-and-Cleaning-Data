# Getting-and-Cleaning-Data
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

## Unzip the file

## List of unzipped files are in /UCI HAR Dataset folder.

## Read data from the files into the variables. there area three types of target files: Activity, subjects and features   

## Activity files
## Subject files
## Features files


## 1.- Merges the training and the test sets to create one data set
##-----------------------------------------------------------------

## Concatenate the data tables by rows

## Set names to variables

## 2.- Merge columns to get the data frame Data for all data
##------------------------------------------------------


## 3.- Extracts only the measurements on the mean and standard deviation for each measurement
##---------------------------------------------------------------------------------------

## Subset Name of Features by measurements on the mean and standard deviation
## i.e taken Names of Features with “mean()” or “std()”


## Subset the data frame Data by seleted names of Features


## 4.- Uses descriptive activity names to name the activities in the data set
##-----------------------------------------------------------------------

## Read descriptive activity names from “activity_labels.txt”
## Replaces the values in the Varibale Activity with the values in the file activity_labels.txt


## Appropriately labels the data set with descriptive variable names
##----------------------------------------------------------------------

##prefix t is replaced by time
##prefix Acc is replaced by Accelerometer
##Gyro is replaced by Gyroscope
##prefix f is replaced by frequency
##Mag is replaced by Magnitude
##BodyBody is replaced by Body


## 5.- Creates a second, independent tidy data set with the average of each variable for each activity 
## and each subject. 
##----------------------------------------------------------------------------------------------------

