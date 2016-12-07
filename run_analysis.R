#final assignment for getting and cleaning data class

#unzip the file
unzip("smartphone.zip", exdir = "./")
setwd("UCI HAR dataset")

#read in all the files
list.files() 
list.dirs()
labels <- read.table("activity_labels.txt")
labels
features <- read.table("features.txt")
setwd("test")
x_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
subject_test <- read.table("subject_test.txt")
setwd("..")
setwd("train")
x_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")
setwd("..")

#label columns
names(x_test) <- features$V2 
names(x_train) <- features$V2

#combine activity data with measurement data
test_xy <- cbind(x_test, y_test, subject_test)
table(test_xy$V1)
train_xy <- cbind(x_train, y_train, subject_train)
table(train_xy$V1)

#clean-up the workspace
rm(features,x_test, y_test, x_train, y_train, subject_test, subject_train) 

#combine test and train data
smartphone <- rbind(test_xy, train_xy)

#relabel the columns for activity and subject
colnames(smartphone)[563] <- "subject"
colnames(smartphone)[562] <- "activity"

#get column names for mean and std measurements
library(plyr)
library(dplyr)
mean_std_log <- grep("(mean|std|activity|subject)", names(smartphone)) 
mean_freq <- grep("meanFreq", names(smartphone)) #not including the "meanFreq" measurements
diff <- setdiff(mean_std_log, mean_freq)

#new dataframe with relevant columns 
smartphone_mean_std <- smartphone[, diff]

#clean up the variable names
names(smartphone_mean_std) <- gsub(x = names(smartphone_mean_std),
                        pattern = "-",
                        replacement = "")

names(smartphone_mean_std) <- gsub(x = names(smartphone_mean_std),
                               pattern = "\\()",
                               replacement = "")

#descriptive activity names 
smartphone_mean_std$activity[smartphone_mean_std$activity==1] <- "walking"
smartphone_mean_std$activity[smartphone_mean_std$activity==2] <- "walking_up"
smartphone_mean_std$activity[smartphone_mean_std$activity==3] <- "walking_down"
smartphone_mean_std$activity[smartphone_mean_std$activity==4] <- "sitting"
smartphone_mean_std$activity[smartphone_mean_std$activity==5] <- "standing"
smartphone_mean_std$activity[smartphone_mean_std$activity==6] <- "laying"

#move subject and activity to first columns 
smartphone_mean_std <- smartphone_mean_std %>%
        select(subject, activity, everything())

#create new dataset with mean for each subject and activity
smartphone_means <- ddply(smartphone_mean_std, .(subject, activity), colwise(mean))

#export dataset
write.table(smartphone_means, "smartphone_means.txt", row.names = F)
