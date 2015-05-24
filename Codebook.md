Codebook for Coursera Getting and Cleaning Data Project
==========

Submitted by: Dave Manley
On: 5/23/2015

The features selected for this database originally come from the adomain of wearable computing. For more information see: http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/.

Specifically, the data set comes from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones which draws on 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

The processing of the data was according to the script in this directory and went along the following lines:
*Merges the training and the test sets to create one data set*
*Extracts only the measurements on the mean and standard deviation for each measurement*
*Uses descriptive activity names to name the activities in the data set*
*Appropriately labels the data set with descriptive variable names* 
*From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject*

Tidy data was defined according to the paper: http://vita.had.co.nz/papers/tidy-data.pdf


##DECISIONS

The following decisions where made on rnaming the data:
 -  #for the most part lower cases were removed except where it was needed for readability.
 -  #t meaning time wasn't obvious to me, especially what a "tbody" or "tgravity" or "fbody" was so I will spell it out. I left "std" since I know what that means and I suspect "std" means more to the average person than it in long form
 -  #I do not believe that the parens add anything to the information given. This is a personal preference but also based on class lectures.
 -  #from the readme, I believe that the Acc means accelerometer which I think needs to be written out.
 -  # I think Mag means magnitude, so I'm changing that too

**The decision was that mean is different than meanFreq, and since there was not a standard deviation for those variables they were not selected.**

Also: capitals for XYZ were left in for readability reasons.

As a result, this data first came from readings of accelerometer and :w 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean
Of course, for the assignment the features were renamed and cleaned.

Here is a list of the data that was cleaned:
 [1] "subject"                                         "activity"                                       
 [3] "timebodyaccelerometermeanX"                      "timebodyaccelerometermeanY"                     
 [5] "timebodyaccelerometermeanZ"                      "timebodyaccelerometerstdX"                      
 [7] "timebodyaccelerometerstdY"                       "timebodyaccelerometerstdZ"                      
 [9] "timegravityaccelerometermeanX"                   "timegravityaccelerometermeanY"                  
[11] "timegravityaccelerometermeanZ"                   "timegravityaccelerometerstdX"                   
[13] "timegravityaccelerometerstdY"                    "timegravityaccelerometerstdZ"                   
[15] "timebodyaccelerometerjerkmeanX"                  "timebodyaccelerometerjerkmeanY"                 
[17] "timebodyaccelerometerjerkmeanZ"                  "timebodyaccelerometerjerkstdX"                  
[19] "timebodyaccelerometerjerkstdY"                   "timebodyaccelerometerjerkstdZ"                  
[21] "timebodygyroscopemeanX"                          "timebodygyroscopemeanY"                         
[23] "timebodygyroscopemeanZ"                          "timebodygyroscopestdX"                          
[25] "timebodygyroscopestdY"                           "timebodygyroscopestdZ"                          
[27] "timebodygyroscopejerkmeanX"                      "timebodygyroscopejerkmeanY"                     
[29] "timebodygyroscopejerkmeanZ"                      "timebodygyroscopejerkstdX"                      
[31] "timebodygyroscopejerkstdY"                       "timebodygyroscopejerkstdZ"                      
[33] "timebodyaccelerometermagnitudemean"              "timebodyaccelerometermagnitudestd"              
[35] "timegravityaccelerometermagnitudemean"           "timegravityaccelerometermagnitudestd"           
[37] "timebodyaccelerometerjerkmagnitudemean"          "timebodyaccelerometerjerkmagnitudestd"          
[39] "timebodygyroscopemagnitudemean"                  "timebodygyroscopemagnitudestd"                  
[41] "timebodygyroscopejerkmagnitudemean"              "timebodygyroscopejerkmagnitudestd"              
[43] "frequencybodyaccelerometermeanX"                 "frequencybodyaccelerometermeanY"                
[45] "frequencybodyaccelerometermeanZ"                 "frequencybodyaccelerometerstdX"                 
[47] "frequencybodyaccelerometerstdY"                  "frequencybodyaccelerometerstdZ"                 
[49] "frequencybodyaccelerometerjerkmeanX"             "frequencybodyaccelerometerjerkmeanY"            
[51] "frequencybodyaccelerometerjerkmeanZ"             "frequencybodyaccelerometerjerkstdX"             
[53] "frequencybodyaccelerometerjerkstdY"              "frequencybodyaccelerometerjerkstdZ"             
[55] "frequencybodygyroscopemeanX"                     "frequencybodygyroscopemeanY"                    
[57] "frequencybodygyroscopemeanZ"                     "frequencybodygyroscopestdX"                     
[59] "frequencybodygyroscopestdY"                      "frequencybodygyroscopestdZ"                     
[61] "frequencybodyaccelerometermagnitudemean"         "frequencybodyaccelerometermagnitudestd"         
[63] "frequencybodybodyaccelerometerjerkmagnitudemean" "frequencybodybodyaccelerometerjerkmagnitudestd" 
[65] "frequencybodybodygyroscopemagnitudemean"         "frequencybodybodygyroscopemagnitudestd"         
[67] "frequencybodybodygyroscopejerkmagnitudemean"     "frequencybodybodygyroscopejerkmagnitudestd"    

See the UCI Dataset for more information, but these variable names all come from there.