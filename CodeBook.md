# Codebook

## Initial Data

The initial data consisted of data gathered as part of a study on using sensors (specifically those within a smartphone) to determine the activity people were engaged in at any given point.  The files presented were: 

- activity_labels.txt - Definitions of numerical activity 
- features_info.txt - Explanations of the features written by the original authors.
- features.txt - Names of the features.
- README.txt - Explanation of the study and it's methods.
- test Directory
  * subject_test.txt - List of the subject (a volunteer participating in the study) under observation.
  * X_test.txt - List of the measurements taken in each observation.
  * y_test.txt - List of the activities being under-taken for each observation.
  * Inertial Signals Directory
- train Directory
  * subject_test.txt - List of the subject (a volunteer participating in the study) under observation.
  * X_test.txt - List of the measurements taken in each observation.
  * y_test.txt - List of the activities being under-taken for each observation.
  * Inertial Signals Directory

There were additional files inside the *test\Inertial Signals* and *train\Inertial Signals* directories, but these are immaterial to the work done here.  These files were raw data from the sensors.

The files had several associations which required merging and manipulating the different sets to get all the data into one format.
The Features described in features_info.txt and listed in the features.txt file were the variable names for the values in the X_test.txt and X_train.txt.

The subject, X, and Y data each cover the same set of observations.  The data was measured at a fixed time interval (50 Hz, or 50 measurements per second) and recorded into the X_test.txt file.  Then video recordings were used to align activities to those records.  Initially all the data was in one set, but the original study's authors split the dataset into the test and train sets.

## Processing Steps

The relationships between the files dictated that several actions needed to occur:

1. Transpose the second column of the features.txt file into the variable names of the X data.
2. Re-combine the test and train data into one set.
3. Merge the subject, Y, and X data was needed into one dataset.

First the data from the test and train sets were gathered into one dataset.  Then the feature list was transposed into the column names of the X data.  To meet the objectives of the project all the columns not containing data for Standard Deviation or Mean was then dropped out of the X.  Finally all the pieces were assembled left to right (subject, Y, X).

To meet the second objective of the project this data is then subset by the volunteer id and activity.  Each of the features for the subsets was averaged and this was added to a new table of data.  This new table has one row per each unique (volunteer, activity) pair.

## Processing Output

There are two files created by the process above.

*FullResults.txt* contains all of the original feature data.

*AverageResults.txt* contains the averaged data.  A copy of this file is included in this project.

## Variable Definitions

While the full list is presented below for completeness, the precise meaning of variables after the first two (which the original files refer to as features) is best understood by consulting the *features_info.txt* file.  But a summary of these names is reached by breaking them down into the following parts:

* Domain - Either Time(t) or Fast Fourier Transform(f)
* Measurement - The actual measurement taken.
* Function - The processing function applied to that measurement.
* Axis - The 3 dimensional axis the measurement was taken on (X, Y, or Z.

In some cases the function requires extra information.  In this case it is added to the end of the feature and separated from the Axis by a comma. 

So, to apply this to the first feature in the list, *tBodyAcc-mean()-X*, it is a measurement of BodyAcc along the X Axis over time and then passed into the mean() function.

There are no units for any of the variables.  The Volunteer ID is between 1 and 30, and the Activity is one of the following list

* Walking
* Going Up Stairs
* Going Down Stairs
* Seated
* Standing
* Laying Down.  

All the features were normalized to be between -1 and 1.

### Variables
- Volunteer - An unique id number assigned to each volunteer for the study.
- Activity - Which of the activities the volunteer was performing when the feature data was gathered.
- tBodyAcc-mean()-X 
- tBodyAcc-mean()-Y
- tBodyAcc-mean()-Z
- tBodyAcc-std()-X
- tBodyAcc-std()-Y
- tBodyAcc-std()-Z
- tGravityAcc-mean()-X
- tGravityAcc-mean()-Y
- tGravityAcc-mean()-Z
- tGravityAcc-std()-X
- tGravityAcc-std()-Y
- tGravityAcc-std()-Z
- tBodyAccJerk-mean()-X
- tBodyAccJerk-mean()-Y
- tBodyAccJerk-mean()-Z
- tBodyAccJerk-std()-X
- tBodyAccJerk-std()-Y
- tBodyAccJerk-std()-Z
- tBodyGyro-mean()-X
- tBodyGyro-mean()-Y
- tBodyGyro-mean()-Z
- tBodyGyro-std()-X
- tBodyGyro-std()-Y
- tBodyGyro-std()-Z
- tBodyGyroJerk-mean()-X
- tBodyGyroJerk-mean()-Y
- tBodyGyroJerk-mean()-Z
- tBodyGyroJerk-std()-X
- tBodyGyroJerk-std()-Y
- tBodyGyroJerk-std()-Z
- tBodyAccMag-mean()
- tBodyAccMag-std()
- tGravityAccMag-mean()
- tGravityAccMag-std()
- tBodyAccJerkMag-mean()
- tBodyAccJerkMag-std()
- tBodyGyroMag-mean()
- tBodyGyroMag-std()
- tBodyGyroJerkMag-mean()
- tBodyGyroJerkMag-std()
- fBodyAcc-mean()-X
- fBodyAcc-mean()-Y
- fBodyAcc-mean()-Z
- fBodyAcc-std()-X
- fBodyAcc-std()-Y
- fBodyAcc-std()-Z
- fBodyAccJerk-mean()-X
- fBodyAccJerk-mean()-Y
- fBodyAccJerk-mean()-Z
- fBodyAccJerk-std()-X
- fBodyAccJerk-std()-Y
- fBodyAccJerk-std()-Z
- fBodyGyro-mean()-X
- fBodyGyro-mean()-Y
- fBodyGyro-mean()-Z
- fBodyGyro-std()-X
- fBodyGyro-std()-Y
- fBodyGyro-std()-Z
- fBodyAccMag-mean()
- fBodyAccMag-std()
- fBodyBodyAccJerkMag-mean()
- fBodyBodyAccJerkMag-std()
- fBodyBodyGyroMag-mean()
- fBodyBodyGyroMag-std()
- fBodyBodyGyroJerkMag-mean()
- fBodyBodyGyroJerkMag-std()
