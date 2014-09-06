##Codebook.md

###Data downloading
1. First of all the zip-file from the given url is downloaded into the current working directory.
2. Then the file is going to be unzipped in the current working directory creating a sub directory called
UCI HAR Dataset.

###Data transformation
1. After reading in all the interessting files (features.txt, activity_labels.txt, subject_train.txt, 
   X_train.txt, y_train.txt, subject_test.txt, X_test.txt, y_test.txt)
2. I reset the columnnames of the test-set and the training-set to the given values in the features.txt file, where the features are described.
3. Then the datasets for trainingset and testset are stiched together from the files:
* for the testset:
    + test_subjects (561 variables)
    + X_test
    + y_test
* for the trainingset:
    + training_subjects (561 variables)
    + X_training
    + y_training

4. Then the above created datasets are combined to build a huge dataset with 563 variables.
5. Later I assigend new columnnames for the subject and the activity -> id to the builded dataset before
6. When the acitvity was named to id, I mapped those column against the id column in the acitivtyies file,
   to append the written acitvity values.
7. Then a filter on the column names of the created huge dataset is calculated which only keeps the columns
   that have "mean" or "std" or acivity or subject in their names. There are 88 variables left.
8. Later I cleaned all the names of the columns to be more desciptive.
9. Finally the tidy dataset is created which arrange all the columns by subject and activity and calculate for every combination for the earlier called values the mean values of every column.
10. Last of all the tiny dataset is written out for submittion as a text-file.

###Variable description
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 'time' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'frequency' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

####List of variables
 "subject"
 "time-bodyaccelerometer-mean-x-axis"
 "time-bodyaccelerometer-mean-y-axis"
 "time-bodyaccelerometer-mean-z-axis"              
 "time-bodyaccelerometer-std-x-axis"
 "time-bodyaccelerometer-std-y-axis"               
 "time-bodyaccelerometer-std-z-axis"
 "time-gravityaccelerometer-mean-x-axis"
 "time-gravityaccelerometer-mean-y-axis"
 "time-gravityaccelerometer-mean-z-axis"           
 "time-gravityaccelerometer-std-x-axis"
 "time-gravityaccelerometer-std-y-axis"
 "time-gravityaccelerometer-std-z-axis"
 "time-bodyaccelerometer-jerkmean-x-axis"          
 "time-bodyaccelerometer-jerkmean-y-axis"
 "time-bodyaccelerometer-jerkmean-z-axis"          
 "time-bodyaccelerometer-jerkstd-x-axis"
 "time-bodyaccelerometer-jerkstd-y-axis"           
 "time-bodyaccelerometer-jerkstd-z-axis"
 "time-bodygyroscope-mean-x-axis"                  
 "time-bodygyroscope-mean-y-axis"
 "time-bodygyroscope-mean-z-axis"                  
 "time-bodygyroscope-std-x-axis"
 "time-bodygyroscope-std-y-axis"                   
 "time-bodygyroscope-std-z-axis"
 "time-bodygyroscope-jerkmean-x-axis"              
 "time-bodygyroscope-jerkmean-y-axis"
 "time-bodygyroscope-jerkmean-z-axis"              
 "time-bodygyroscope-jerkstd-x-axis"
 "time-bodygyroscope-jerkstd-y-axis"               
 "time-bodygyroscope-jerkstd-z-axis"
 "time-bodyaccelerometer-mag-mean"                 
 "time-bodyaccelerometer-mag-std"
 "time-gravityaccelerometer-mag-mean"              
 "time-gravityaccelerometer-mag-std"
 "time-bodyaccelerometer-jerkmag-mean"             
 "time-bodyaccelerometer-jerkmag-std"
 "time-bodygyroscope-mag-mean"                     
 "time-bodygyroscope-mag-std"
 "time-bodygyroscope-jerkmag-mean"                 
 "time-bodygyroscope-jerkmag-std"
 "frequency-bodyaccelerometer-mean-x-axis"         
 "frequency-bodyaccelerometer-mean-y-axis"
 "frequency-bodyaccelerometer-mean-z-axis"         
 "frequency-bodyaccelerometer-std-x-axis" 
 "frequency-bodyaccelerometer-std-y-axis"          
 "frequency-bodyaccelerometer-std-z-axis" 
 "frequency-bodyaccelerometer-meanfreq-x-axis"     
 "frequency-bodyaccelerometer-meanfreq-y-axis" 
 "frequency-bodyaccelerometer-meanfreq-z-axis"     
 "frequency-bodyaccelerometer-jerkmean-x-axis"
 "frequency-bodyaccelerometer-jerkmean-y-axis"     
 "frequency-bodyaccelerometer-jerkmean-z-axis" 
 "frequency-bodyaccelerometer-jerkstd-x-axis"      
 "frequency-bodyaccelerometer-jerkstd-y-axis"  
 "frequency-bodyaccelerometer-jerkstd-z-axis"      
 "frequency-bodyaccelerometer-jerkmeanfreq-x-axis"
 "frequency-bodyaccelerometer-jerkmeanfreq-y-axis" 
 "frequency-bodyaccelerometer-jerkmeanfreq-z-axis" 
 "frequency-bodygyroscope-mean-x-axis"             
 "frequency-bodygyroscope-mean-y-axis" 
 "frequency-bodygyroscope-mean-z-axis"             
 "frequency-bodygyroscope-std-x-axis"
 "frequency-bodygyroscope-std-y-axis"              
 "frequency-bodygyroscope-std-z-axis"
 "frequency-bodygyroscope-meanfreq-x-axis"         
 "frequency-bodygyroscope-meanfreq-y-axis" 
 "frequency-bodygyroscope-meanfreq-z-axis"         
 "frequency-bodyaccelerometer-mag-mean"
 "frequency-bodyaccelerometer-mag-std"             
 "frequency-bodyaccelerometer-mag-meanfreq" 
 "frequency-bodybodyaccelerometer-jerkmag-mean"    
 "frequency-bodybodyaccelerometer-jerkmag-std" 
 "frequency-bodybodyaccelerometer-jerkmag-meanfreq"
 "frequency-bodybodygyroscope-mag-mean" 
 "frequency-bodybodygyroscope-mag-std"             
 "frequency-bodybodygyroscope-mag-meanfreq"
 "frequency-bodybodygyroscope-jerkmag-mean"        
 "frequency-bodybodygyroscope-jerkmag-std" 
 "frequency-bodybodygyroscope-jerkmag-meanfreq"    
 "angle-tbodyaccelerometer-meangravity" 
 "angle-tbodyaccelerometer-jerkmeangravitymean"    
 "angle-tbodygyroscope-meangravitymean" 
 "angle-tbodygyroscope-jerkmeangravitymean"        
 "angle-xgravitymean"              
 "angle-ygravitymean"                              
 "angle-zgravitymean"
 "activity"