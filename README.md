README for Coursera Getting and Cleaning Data Project
==========

Submitted by: Dave Manley
On: 5/23/2015

**Contents of directory**
README.md: this file
----------

run_analysis.R: script that takes the data set from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones:
    -Downloads the data
    -Merges the training and the test sets to create one data set.
    -Extracts only the measurements on the mean and standard deviation for each measurement. 
    -Uses descriptive activity names to name the activities in the data set
    -Appropriately labels the data set with descriptive variable names. 
    -From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
----------

Codebook.md: file describing the variables from that script
----------

**Idea behind run_analysis.R**

The script is broken into functions cooresponding to the steps listed above.
To run the script simply source it and then call the run_analysis function with no arguments. It writes the tidy data set to the DataCleaningFile.txt. Several decisions were made:
Tidy data was defined according to the paper: http://vita.had.co.nz/papers/tidy-data.pdf

The following decisions where made on renaming the data:
 - # t meaning time wasn't obvious to me, especially what a "tbody" or "tgravity" or "fbody" was so I will spell it out. I left "std" since I know what that means 
 -  #I do not believe that the parens add anything to the information given. This is a personal preference but also based on class lectures.
 -  #from the readme, I believe that the Acc means accelerometer which I think needs to be written out.
 -  # I think Mag means magnitude, so I'm changing that too

 - The decision was that mean is different than meanFreq, and since there was not a standard deviation for those variables they were not selected.

     Also: caps for XYZ and "Body" were left in for readability reasons.
