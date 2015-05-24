# Dave Manley
# 5/23/2015
# Coursera Getting and Cleaning Data Course Project

#Download the data files from the cloudfront set. Obviously, we know what the zip file
#is called, but as a courtesy we make that a removeable part. Also, if the files are already
#there from previous iterations, there is no need to download them again.
get_data_files<-function(datadir)
{
        exerciseDataTestUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        zipfile = "alldata.zip"
      
        zipfileFullPath = paste(datadir, "//",zipfile, sep="")
        
        #No need to re-download if it already exists!
        if (!file.exists(datadir)) {dir.create(datadir)}
        if (!file.exists(zipfileFullPath)) {
                download.file(exerciseDataTestUrl,destfile=zipfileFullPath)
                unzip(zipfileFullPath,exdir=datadir)
        } 
        
}

#This is the first step that the project asks for:
#It "Merges the training and the test sets to create one data set."
#This set is returned. It assumes that the datadir is already downloaded 
#and unzipped.
merge_test_and_training_set<-function(datadir,datasetdir)
{
        #These file names never change, but we'll make them variable names for code readability
        testsetfile="test\\X_test.txt"
        trainingsetfile = "train\\X_train.txt"
        
        testlabelsetfile="test\\Y_test.txt"
        traininglabelsetfile = "train\\Y_train.txt"
        
        testsubjectsetfile="test\\subject_test.txt"
        trainingsubjectsetfile = "train\\subject_train.txt"

        #The full path is for ease of organization, we'll paste the values based on directories
        testsetFullPath = paste(datadir, "//",datasetdir,"//", testsetfile, sep="")
        trainingsetFullPath = paste(datadir, "//",datasetdir,"//", trainingsetfile, sep="")
        
        testsubjectsetFullPath = paste(datadir, "//",datasetdir,"//", testsubjectsetfile, sep="")
        trainingsubjectsetFullPath = paste(datadir, "//",datasetdir,"//", trainingsubjectsetfile, sep="")
        
        testlabelsetFullPath = paste(datadir, "//",datasetdir,"//", testlabelsetfile, sep="")
        traininglabelsetFullPath = paste(datadir, "//",datasetdir,"//", traininglabelsetfile, sep="")
        
        testset<-read.table(testsetFullPath)
        trainingset<-read.table(trainingsetFullPath)
        
        testsubjectset<-read.table(testsubjectsetFullPath)
        trainingsubjectset<-read.table(trainingsubjectsetFullPath)
        
        testlabelset<-read.table(testlabelsetFullPath)
        traininglabelset<-read.table(traininglabelsetFullPath)

        #Turns out to be easier to bind these here, if the rows get re-arranged nothing bad happens
        testandtrainingset<-rbind(cbind(testsubjectset,testlabelset,testset),
                                  cbind(trainingsubjectset,traininglabelset,trainingset))
        
        return(testandtrainingset)
}       


#This function covers the second and third steps of the project.
#It "Extracts only the measurements on the mean and standard deviation for each measurement."
#and then "Uses descriptive activity names to name the activities in the data set"
#This filtered and activity named set is returned. It assumes that the datadir is already downloaded 
#and unzipped.
extract_means_from_test_and_training_set<-function(datadir,datasetdir,testandtrainingset)
{
        featuresfile = "features.txt"
        
        
        featuresFullPath = paste(datadir, "//",datasetdir,"//", featuresfile, sep="")
        features<-read.table(featuresFullPath, stringsAsFactors=FALSE)
        
        # add in the column names for subject and activity to keep the data aligned
        subjectLabel<-c(-1,"subject")
        activityLabel<-c(0,"activity")
        allLabels<-rbind(subjectLabel,activityLabel,features)

        ##do the second step here:
        #need to avoid cases where mean or std is part of var name--as a result
        #we pay attention to the case, which means we don't get the last seven categories
        #which have Mean in their title but it is incidental
        
        #Also, I do not believe that meanFreq is a mean value, so I am making sure that mean has
        #parens right after it to be in this data set.
        meanAndStdVector<-grepl("mean\\(\\)|std\\(\\)|subject|activity",ignore.case=FALSE,allLabels$V2)

        # t meaning time wasn't obvious to me, especially what a "tbody" or "tgravity" or "fbody" was so I will
        # spell it out. I left the "BodyBody" and "bodybody" since I do not know anything better.
        # Similar logic in leaving "Jerk" as "jerk"
        # I left "std" since I know what that means I suspect people do in general.
        allLabels$V2<-gsub("tBody","timebody",allLabels$V2)
        allLabels$V2<-gsub("tGravity","timegravity",allLabels$V2)
        allLabels$V2<-gsub("fBody","frequencyBody",allLabels$V2)
        allLabels$V2<-gsub("Body","body",allLabels$V2)
        allLabels$V2<-gsub("BodyBody","bodybody",allLabels$V2)
        allLabels$V2<-gsub("Jerk","jerk",allLabels$V2)
        
        
        
        #I do not believe that the parens add anything to the information given. This is a personal preference.
        allLabels$V2<-gsub("\\(\\)","",allLabels$V2)
        
        #from the readme, I believe that the Acc means accelerometer which I think needs to be written out.
        allLabels$V2<-gsub("Acc","accelerometer",allLabels$V2)
        
        #from the readme, I believe that the Gyro means gyroscope which I think needs to be written out.
        allLabels$V2<-gsub("Gyro","gyroscope",allLabels$V2)
        
        #Mag is magnitude. Not obvious.
        allLabels$V2<-gsub("Mag","magnitude",allLabels$V2)
        
        #all of the dashes make things less readable. The first lecture of the fourth week agrees.
        allLabels$V2<-gsub("-","",allLabels$V2)
        
        
        #One way to do this (and I went with the more efficient way of just requesting parenthesis to follow mean)
        #would be to explicitly write the names of categories I wanted to omit.
        #excludeTheseNamesThough<-grepl("gravityMean|tBodyAccMean|tBodyAccJerkMean|tBodyGyroMean|tBodyGyroJerkMean|meanFreq",
        #                               features$V2)
        
        #now do the third step
        names(testandtrainingset)<-c(as.character(allLabels$V2))
        
        #return the finished product, doing the filtering is the easiest part to decide and code
        return(testandtrainingset[,meanAndStdVector])
}


#This function covers the fourth step of the project.
#It "Appropriately labels the data set with descriptive variable names."
#It assumes that the datadir is already downloaded 
#and unzipped.
change_activity_names<-function(datadir,datasetdir,meanandstdSet)
{
        
        activitylabelsfile = "activity_labels.txt"
        activitylabelsFullPath = paste(datadir, "//",datasetdir,"//", activitylabelsfile, sep="")
        activitylabels<-read.table(activitylabelsFullPath,stringsAsFactors = FALSE)
 
        #replace numbers with activity names--one could easily do a join here but it 
        #would be overkill
        newlabels<-sub("_","",tolower(activitylabels[,2]))
        #Also: for readability and cutting down on confusion we will remove the underscore character
        # and make everything lowercase. This jives with the 1st lecture under the 4th week of the class 
        # and is supposed to be lower case according to the lecture, easy enough to do it here
        
        meanandstdSet$activity<-factor(meanandstdSet$activity,labels=newlabels)
        #In effect, this is what happens: factor(meanandstdSet$activity, 
        # labels=c("walking", "walkingupstairs", "walkingdownstairs", "sitting", "standing", "laying"))
        
        #if we want strings instead of functions we'd want to do this:
        ##    activitylabels<-tolower(activitylabels)
        ##for(i in 1:nrow(meanandstdSet)){
        ##        activitynumber <- meanandstdSet[i,2]
        ##        activitylabel <- activitylabels[activitynumber,2]
        ##        meanandstdSet[i,2] <- gsub("_","",tolower(activitylabel))
        ##}
        
        return (meanandstdSet)
}


#This function covers the last step of the project.
#It follow the direction to"From the data set in step 4, creates a second, independent tidy data 
#set with the average of each variable for each activity and each subject."
#It turns out there is a dplyr function that does exactly that.
calculate_means_by_subject_and_activity<-function(meanandstdSetWithActivityNames)
{
        #add dplyr package
        library(dplyr)
        tidyset <- meanandstdSetWithActivityNames %>% 
                group_by(subject,activity) %>% 
                summarise_each(funs(mean))
        return(tidyset)
}

# This function needs to be called to run the script. It breaks out the five parts of the project after getting
# the zip file
run_analysis<-function()
{
        datadir = "./ExData"
        datasetdir = "UCI HAR Dataset"
        
        get_data_files(datadir)
        testandtrainingset<-merge_test_and_training_set(datadir,datasetdir)
        meanandstdSet<-extract_means_from_test_and_training_set(datadir,datasetdir,testandtrainingset)
        meanandstdSetWithActivityNames<-change_activity_names(datadir,datasetdir,meanandstdSet)
        tidydata<-calculate_means_by_subject_and_activity(meanandstdSetWithActivityNames)
        write.table(tidydata, "DataCleaningFile.txt", row.name=FALSE)

}

run_analysis()

