#download the data
#Windows specific workaround
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile="file.zip", method="curl")

#extract the data
unzip("file.zip",list=TRUE, exdir = temp, unzip="internal")

#build the dataset
files <- filelist$Name
merge("file.zip", files)

merge <- function(zipfile) {
    # Create a name for the dir where we'll unzip
    tmp_folder <- tempfile()
    # Create the dir using that name
    dir.create(tmp_folder)
    # Unzip the file into the dir
    unzip(zipfile, exdir = tmp_folder)
    # Get a list of csv files in the dir
    files <- list.files(tmp_folder)
    files_train <- files[grep(".train\\.txt$", files)]
    files_test <- files[grep(".test\\.txt$", files)]
    final_files <- c(files_train, files_test)
    
    # Create a list of the imported csv files
    #list is bad make a combined big table if possible
    csv.data <- sapply(final_files, function(f) {
      fp <- file.path(tmp_folder, f)
      return(read.csv(fp))
    }, simplify = TRUE)
    return(csv.data)
}

#read in common stuff
########################
#read in activity labels
activity_labels <- read.table("/Users/stefan/getting_and_cleaning_data/UCI HAR Dataset/activity_labels.txt")

#read in column names
features <- read.table("/Users/stefan/getting_and_cleaning_data/UCI HAR Dataset/features.txt")

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

#build up whole test dataset
frame <- data.frame(test_subjects, test, test_results)
#TODO: Add second Data frame for Training data and join it with test-data to build a final dataframe

#make up good column names
colnames(frame)[1] <- "subject"
colnames(frame)[ncol(frame)] <- "id"

#join real activity labels with activity numbers
library(plyr)
colnames(activity_labels) <- c("id","activity")
test_set <- arrange(join(frame, activity_labels), id)
test_set <- test_set[-563]

#just keep the std and mean columns
means <- grep("mean" ,colnames(test_set),value=TRUE)
stds <- means <- grep("std" ,colnames(test_set),value=TRUE)
variable_filter <- c(means,stds)

#I have to filter the combined test and training dataset on those variables
keeped <- test_set[,(names(test_set) %in% variable_filter)]

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
