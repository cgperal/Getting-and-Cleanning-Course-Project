# Getting-and-Cleanning-Course-Project

Please find attached a file run_analysis.R in the main directory that can be run as long as the Samsung data is in your working directory.

The run.analysis() performs the actual job:
- reads train and test data sets and merges them
- processes the merged data set (extract the relevant variables, adds descriptive activity names, etc.)
- writes the merged data set to rawdata.txt
- generates the clean data set
- writes the clean data set to cleandata.txt
- returns the clean data set


To run the script and test the code do the following:

source('./run_analysis.R')

download.data() # download data and unzip it

run.analysis() # invoke the function

Raw data set

In order to create a raw data set, the following regular expression was used: -(mean|std)[(]. I.e. all variables containing -mean( or -std( in their names were filtered.

Totally, the raw data set contains 68 variables:

- subject - An identifier of the subject who carried out the experiment.
- label - An activity label.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern:
-XYZ is used to denote 3-axial signals in the X, Y and Z directions.

The set of variables that were estimated from these signals are:

- mean(): Mean value
- std(): Standard deviation

Tidy data set

Tidy data set contains the same variables as the raw does, but the variables were renamed according to following rules like all lower case when possible, descriptive (Diagnosis versus Dx), not duplicated or not have underscores or dots or white spaces.



