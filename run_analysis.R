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


#Merges the training and the test sets to create one data set.

#Extracts only the measurements on the mean and standard deviation for each measurement.

#Uses descriptive activity names to name the activities in the data set

#Appropriately labels the data set with descriptive variable names. 

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.