#download the data
#Windows specific workaround
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile="file.zip", method="curl")

#extract the file in the working directory
unzip("file.zip",list=TRUE, exdir = temp, unzip="internal")

#read in common stuff
########################
#read in activity labels
activity_labels <- read.table("/Users/stefan/getting_and_cleaning_data/UCI HAR Dataset/activity_labels.txt")

#read in column names
features <- read.table("/Users/stefan/getting_and_cleaning_data/UCI HAR Dataset/features.txt")

#Read in Training-Stuff
#########################
#read in subjects
train_subjects <- read.table("/Users/stefan/getting_and_cleaning_data/UCI HAR Dataset/train/subject_test.txt")

#read in data
train <- read.table("/Users/stefan/getting_and_cleaning_data/UCI HAR Dataset/train/X_train.txt")

#read in results
train_results <- read.table("/Users/stefan/getting_and_cleaning_data/UCI HAR Dataset/train/y_train.txt")


#Read in Test-Stuff
#########################
#read in subjects
test_subjects <- read.table("/Users/stefan/getting_and_cleaning_data/UCI HAR Dataset/test/subject_test.txt")

#read in data
test <- read.table("/Users/stefan/getting_and_cleaning_data/UCI HAR Dataset/test/X_test.txt")

#read in results
test_results <- read.table("/Users/stefan/getting_and_cleaning_data/UCI HAR Dataset/test/y_test.txt")

#setting colnames of the data
colnames(test) <- features$V2
colnames(training) <- features$V2

#build up whole test dataset
test_frame <- data.frame(test_subjects, test, test_results)
train_frame <- data.frame(train_subjects, train, train_results)
frame <- data.frame(train_frame, test_frame)

#make up good column names
colnames(frame)[1] <- "subject"
colnames(frame)[ncol(frame)] <- "id"

#join real activity labels with activity numbers
library(plyr)
colnames(activity_labels) <- c("id","activity")
frame <- arrange(join(frame, activity_labels), id)
frame <- test_set[-563]

#just keep the std and mean columns
means <- grep("mean" ,colnames(frame),value=TRUE)
stds <- means <- grep("std" ,colnames(frame),value=TRUE)
variable_filter <- c(means,stds)

#I have to filter the combined test and training dataset on those variables
keeped <- frame[,(names(frame) %in% variable_filter)]

#clean the colum names
names(keeped) <- gsub("\\.","", names(keeped),)
names(keeped) <- gsub("Acc","Accelerometer-", names(keeped),)
names(keeped) <- gsub("Gyro","Gyroscope-", names(keeped),)
names(keeped) <- gsub("X$","-X-Axis", names(keeped),)
names(keeped) <- gsub("Y$","-Y-Axis", names(keeped),)
names(keeped) <- gsub("Z$","-Z-Axis", names(keeped),)
names(keeped) <- gsub("^t","time-", names(keeped),)
names(keeped) <- gsub("^f","frequency-", names(keeped),)
names(keeped) <- gsub("jerk","jerk-", names(keeped),)
names(keeped) <- tolower(names(keeped))
names(keeped) <- gsub("mag","mag-", names(keeped),)
