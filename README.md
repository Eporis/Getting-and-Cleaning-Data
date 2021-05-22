# Getting-and-Cleaning-Data
Final project for "Getting and Cleaning Data" Coursera course


run_analysis.R description:
- Script goes through 5 steps of course project as described in the review criteria on Coursera.
- Before going through the steps, script sets wd to the root of the UCI  data folder. As long as the UCI folder in not altered and the wd is set to its root, the script should
    work.
- The script then loads the relevant data from the folder: features and activity_labels from the root, and the subject, x and y datasets from both the test and training folders.
- Once the data is loaded, the script goes through the 5 aforementioned steps as described below.
- After step 5, saves final dataset to wd.


1) Merge Test and Training Datasets to create a single dataset
    - first use row-bind to create three datasets with both test and training data for each of x, y and subject
    - Use column-bind to create a single dataset with the three datasets from the previous step


2) Extract only measurements on mean and standard deviation for each measurement
    - Create a new dataset with a select query on the dataset created in step 1 to select subject #, activity #, and any column that contains the strings "mean" OR "std"


3) Uses descriptive activity names to name the activities in the data set
    - First replace "_" with "." in activities table
    - Then, make a new column in dataset from step 2 with activity names based on values in "code" column
    - Make a new table "tidy.data" that has everything in table from last step EXCEPT for code

4) Appropriately label the data set with descriptive variable names. 
    - Change column names for tidy.data from step 3 so they're more descriptive (eg "Acc" to "Acceleration")

5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    - Use Dplyr to get mean of each column grouped by Subject # and Activity

