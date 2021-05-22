## Course Project for Coursera: Getting and Cleaning Data
#You should create one R script called run_analysis.R that does the following. 

#1 Merges the training and the test sets to create one data set.

#2 Extracts only the measurements on the mean and standard deviation for each measurement. 

#3 Uses descriptive activity names to name the activities in the data set

#4 Appropriately labels the data set with descriptive variable names. 

#5 From the data set in step 4, creates a second, independent tidy data set with the 
#    average of each variable for each activity and each subject.


library(dplyr)


## Load Data - change setwd to wherever main directory of dataset is for script to work
setwd(paste('C:/Users/Ethan/Documents/Ivey/T2/Getting and Cleaning Data/Course Project/',
            'getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset',sep=""))


##Activities Table
# Code is used in y datasets to represent activity
activities<-read.table('./activity_labels.txt',col.names=c('Code','Activity'))

##Features Table
#n is only used here, features are used as column names for x datasets
features<-read.table('./features.txt',col.names=c('n','Feature'))

## Participant Trial Tables
#sub datsets contain subject number, corresponds to subject number for each trial
#x datasets contain actual trial data for each of the 561 features; 
#y datasets contain activity code for each trial

#Test Data
sub_test<-read.table('./test/subject_test.txt',col.names=c('Subject'))
x_test<-read.table('./test/X_test.txt',col.names=features$Feature)
y_test<-read.table('./test/y_test.txt',col.names='Code')
#Training Data
sub_train<-read.table('./train/subject_train.txt',col.names=c('Subject'))
x_train<-read.table('./train/X_train.txt',col.names=features$Feature)
y_train<-read.table('./train/y_train.txt',col.names='Code')


##1 - Merge test and training datasets to create single datasets 
#ORDER - 2947 Test Trials THEN 7352 Train Trials; 
sub<-rbind(sub_test,sub_train)
x<-rbind(x_test,x_train)
y<-rbind(y_test,y_train)
merged.data<-cbind(sub,y,x)


##2 - Extract only measurements on mean and standard deviation for each measurement

meanstd.data<-select(merged.data,Subject,Code,contains("mean"),contains("std"))


##3 Uses descriptive activity names to name the activities in the data set
activities$Activitiy<-gsub(pattern="_",replacement=".",activities$Activity)
meanstd.data$Activity<-activities[meanstd.data$Code,2]
tidy.data<-meanstd.data %>% select(Subject,Activity,everything(),-Code) 
tidy.data


##4 Appropriately labels the data set with descriptive variable names. 
names(tidy.data)<-gsub(pattern="Acc",replacement="Acceleration",names(tidy.data))
names(tidy.data)<-gsub(pattern="Gyro",replacement="Gyroscope",names(tidy.data))
names(tidy.data)<-gsub(pattern="Mag",replacement="Magnitude",names(tidy.data))
names(tidy.data)<-gsub(pattern="std",replacement="STD",names(tidy.data))
names(tidy.data)<-gsub(pattern="BodyBody",replacement="Body",names(tidy.data))
names(tidy.data)<-gsub(pattern="mean",replacement="Mean",names(tidy.data))
names(tidy.data)<-gsub(pattern="gravity",replacement="Gravity",names(tidy.data))
names(tidy.data)<-gsub(pattern="angle",replacement="Angle",names(tidy.data))
names(tidy.data)<-gsub(pattern="^f",replacement="Frequency",names(tidy.data))
names(tidy.data)<-gsub(pattern="^t",replacement="Time",names(tidy.data))
tidy.data$Activity<-gsub(pattern="_",replacement="\\.",tidy.data$Activity)

names(tidy.data)


##5 From the data set in step 4, creates a second, independent tidy data set with the 
#    average of each variable for each activity and each subject.
final.data <-
  tidy.data %>%
  group_by(Subject, Activity) %>%
  summarise(across(everything(), list(mean)))

final.data


## Write table to text file for Github
write.table(final.data, file='finalData.txt', append = FALSE, 
            row.names = FALSE, col.names = TRUE)
?write.table

