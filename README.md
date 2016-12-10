Final assignment for Getting and Cleaning Data Coursera course 

The code in analysis.R uses data downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.  It assumes that the data has been downloaded and the zipped file is in the working directory. Further details about the original data are available in the README.txt and features_info.txt files that come in the original zip file. 

analysis.R does the following:

1) Unzips and reads in all the relevant files
2) Labels the variables (columns) in the testing and training datasets using the "features" data
3) For both the testing and training dataset, combines measurement data with subject and activity data
4) Combines the testing and training data into one dataset for all subjects
5) Labels the activity and subject columns
6) Extracts only column names for subject, activity, and measurements of mean and standard deviation, excluding the the "meanFreq" variables
7) Saves a new dataset with only the columns identified in the above step
8) Cleans up the variable names by removing uneccesary symbols. (While the assignment calls for descriptive variable names, I kept the abbreviations because otherwise the variable names would have been extremely long, and I thought the abbreviations were sufficiently descriptive.)
9) Replaces the numbers in the activity column with descriptive names
10) Moves the subject and activity columns to the first columns
11) Saves a new dataset with the mean of each measurement for each subject and activity
12) Exports the dataset 
