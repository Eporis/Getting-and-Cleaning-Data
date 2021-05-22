GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, 
and any other relevant information.

finalData.txt Description:
180 observations of 88 variables

Each row represents summary data for a single activity for a single subject
There are 30 subjects x 6 activities each
The first two columns identify the subject and activity
The next 86 columns are all features from the original datset that contained mean or standard deviation data, with the values for each observation representing the mean 
  of that feature for each subject and activity.

run_analysis.R script performs data preparation and summarization on the UCI HAR Dataset following the 5 steps as outlined in the Course Project criteria.

1) Set wd to root directory of unzipped UCI HAR Dataset folder

2) Assign the relevant data to variables
  - activities<-activities.txt - 6 obs of 2 variables; 'Code' is number that corresponds to 'Activity'
  - features<-features.txt - 561 obs of 2 variables; 'n' is a number 1:561, 'Feature' lists all features, in order, contained in the data files
  - sub_test<-subject_test.txt - 2947 obs of 1 variable; 'Subject' contains subject number for each trial in x_test
  - x_test<-X_test.txt - 2947 obs of 561 variables; each column corresponds to the the features listed in 'features', in the same order. Rows have trial data for these features
  - y_test<-y_test.txt - 2947 obs of 1 variable; 'Code' contains activity code for each trial in x_test
  - sub_train<-subject_train.txt - 7352 obs of 1 variable;  same as sub_test but for training data
  - x_train<-X_train.txt - 7352 obs of 561 variable; same as x_test but for training data
  - y_train<-y_train.txt - 7352 obs of 1 variable; same as y_test but for training data

3) Merges the training and the test sets to create one data set.
  - sub: 10299 obs of 1 variable; created by merging sub_test and sub_train, in that order, using rbind()
  - x: 10299 obs of 561 variables; created by merging x_test and x_train, in that order, using rbind()
  - y: 10299 obs of 1 variable; created by merging y_test and y_train, in that order, using rbind()
  - merged.data: 10299 obs of 563 variables; created by merging sub, y and x, in that order, using cbind()
 
4) Extracts only the measurements on the mean and standard deviation for each measurement. 
  - meanstd.data: 10299 obs of 88 variables; created by subsetting merged.data to select 'Subject','Code' and all columns with mean or standard deviation data

5) Uses descriptive activity names to name the activities in the data set
  - tidy.data: 10299 obs of 88 variables; a new version of meanstd.data that contains activity names instead of code number. Created by adding activity names based on 'Code' 
      to meanstd.data, then subsetting meanstd.data to include all columns EXCEPT 'Code'
 
6) Appropriately labels the data set with descriptive variable names. 
  - Make column names in tidy.data more descriptive and readable using gsub() function  
    - "Acc" -> "Acceleration"
    - "Gyro" -> "Gyroscope"
    - "Mag" -> "Magnitude
    - "std" -> "STD"
    - "BodyBody" -> "Body"
    - "mean" -> "Mean"
    - "gravity -> "Gravity"
    - "angle" -> "Angle"
    - "f" at the start of column name -> "Frequency"
    - "t" at the start of column name -> "Time"
  - Replace "\_" with "." in activity names
     
7) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  - final.data: 180 obs of 88 variables; contains means of each variable in tidy.data from (6) for each subject and activity
    - Created using dplyr to group tidy.data by Subject and Activity and then summarise columns into means

8) Export dataset created in (7) to root of wd as file named "finalData.txt"
