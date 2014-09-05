#Download the data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(url,destfile="file.zip", method="curl") #for mac
download.file(url,destfile="file.zip") #for windows

#extract the file in the working directory
unzip("file.zip",list=FALSE, unzip="internal")

#read in common stuff
########################
#read in activity labels
activity_labels <- read.table(paste(getwd(),"/UCI HAR Dataset/activity_labels.txt", sep=""))

#read in column names
features <- read.table(paste(getwd(),"/UCI HAR Dataset/features.txt", sep=""))

#Read in Training-Stuff
#########################
#read in subjects
train_subjects <- read.table(paste(getwd(),"/UCI HAR Dataset/train/subject_train.txt", sep=""))

#read in data
train <- read.table(paste(getwd(),"/UCI HAR Dataset/train/X_train.txt", sep=""))

#read in results
train_results <- read.table(paste(getwd(),"/UCI HAR Dataset/train/y_train.txt", sep=""))


#Read in Test-Stuff
#########################
#read in subjects
test_subjects <- read.table(paste(getwd(),"/UCI HAR Dataset/test/subject_test.txt", sep=""))

#read in data
test <- read.table(paste(getwd(),"/UCI HAR Dataset/test/X_test.txt",sep=""))

#read in results
test_results <- read.table(paste(getwd(),"/UCI HAR Dataset/test/y_test.txt", sep=""))


#Step 1: Merge the datasets
###############################
#setting colnames of the data
colnames(test) <- features$V2
colnames(train) <- features$V2

#build up whole test dataset
test_frame <- data.frame(test_subjects, test, test_results)
train_frame <- data.frame(train_subjects, train, train_results)
frame <- rbind(test_frame,train_frame)

#make up good column names
colnames(frame)[1] <- "subject"
colnames(frame)[ncol(frame)] <- "id"

# Step 3: Map to better activity names
#########################################
#join real activity labels with activity numbers
library(plyr)
colnames(activity_labels) <- c("id","activity")
frame <- arrange(join(frame, activity_labels), id)
frame <- frame[-563]

# Step 2: Keeping specific measurements
############################################

#just keep the std and mean columns
means <- grep("mean" ,colnames(frame),value=TRUE, ignore.case = TRUE)
stds <- grep("std" ,colnames(frame),value=TRUE, ignore.case = TRUE)
variable_filter <- c(means, stds, "activity", "subject")

#I have to filter the combined test and training dataset on those variables
keeped <- frame[,(names(frame) %in% variable_filter)] #There should be 88 columns

#Step 4: clean the colum names
#####################################
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
names(keeped) <- gsub("^angle","angle-", names(keeped),)

# Step 5: Build small tidy dataset with avg of every variable by subject and activity
tidy_dataset <- aggregate(keeped, by=list(keeped$subject, keeped$activity), mean)
tidy_dataset$subject <- NULL
tidy_dataset$activity <- NULL
names(tidy_dataset)[1] <- "subject"
names(tidy_dataset)[2] <- "activity"
write.table(tidy_dataset, row.name=FALSE, file="tidy_dataset.txt")
