library(dplyr)
library(data.table)

#downloading files
temp<-tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", temp)
unzip(temp,list=TRUE)

#reading files into R, setting column names and labels
Features<-read.table(unzip(temp,"UCI HAR Dataset/features.txt"))
TestSet<-read.table(unzip(temp,"UCI HAR Dataset/test/X_test.txt"))
TestLabels<-read.table(unzip(temp,"UCI HAR Dataset/test/y_test.txt"))
SubjectTest<-read.table(unzip(temp,"UCI HAR Dataset/test/subject_test.txt"))
colnames(TestSet)<-t(Features[2])
TestSet$activity<-TestLabels[,1]
TestSet$volunteer<-SubjectTest[,1]

TrainSet<-read.table(unzip(temp,"UCI HAR Dataset/train/X_train.txt"))
TrainLabels<-read.table(unzip(temp,"UCI HAR Dataset/train/y_train.txt"))
SubjectTrain<-read.table(unzip(temp,"UCI HAR Dataset/train/subject_train.txt"))
colnames(TrainSet)<-t(Features[2])
TrainSet$activity<-TrainLabels[,1]
TrainSet$volunteer<-SubjectTrain[,1]

#merging test and train sets, deleting duplicated columns
Set<-rbind(TrainSet,TestSet)
doubles<-duplicated(colnames(Set))
Set<-Set[,!doubles]

#extracting the measurements on mean and standard deviation
ColMean<-grep("mean()",names(Set),value=FALSE,fixed=TRUE)
#including columns 471:477 because they also contain means
ColMean<-append(Mean,471:477)
SetMean<- Set[ColMean]
ColStDev<-grep("std()",names(Set),value=FALSE)
SetStDev<-Set[ColStDev]

#naming activities
Set$activity[Set$activity == 1] <- "Walking"
Set$activity[Set$activity == 2] <- "Walking Upstairs"
Set$activity[Set$activity == 3] <- "Walking Downstairs"
Set$activity[Set$activity == 4] <- "Sitting"
Set$activity[Set$activity == 5] <- "Standing"
Set$activity[Set$activity == 6] <- "Laying"

#naming volunteers
Set$volunteer[Set$volunteer == 1] <- "Volunteer 1"
Set$volunteer[Set$volunteer == 2] <- "Volunteer 2"
Set$volunteer[Set$volunteer == 3] <- "Volunteer 3"
Set$volunteer[Set$volunteer == 4] <- "Volunteer 4"
Set$volunteer[Set$volunteer == 5] <- "Volunteer 5"
Set$volunteer[Set$volunteer == 6] <- "Volunteer 6"
Set$volunteer[Set$volunteer == 7] <- "Volunteer 7"
Set$volunteer[Set$volunteer == 8] <- "Volunteer 8"
Set$volunteer[Set$volunteer == 9] <- "Volunteer 9"
Set$volunteer[Set$volunteer == 10] <- "Volunteer 10"
Set$volunteer[Set$volunteer == 11] <- "Volunteer 11"
Set$volunteer[Set$volunteer == 12] <- "Volunteer 12"
Set$volunteer[Set$volunteer == 13] <- "Volunteer 13"
Set$volunteer[Set$volunteer == 14] <- "Volunteer 14"
Set$volunteer[Set$volunteer == 15] <- "Volunteer 15"
Set$volunteer[Set$volunteer == 16] <- "Volunteer 16"
Set$volunteer[Set$volunteer == 17] <- "Volunteer 17"
Set$volunteer[Set$volunteer == 18] <- "Volunteer 18"
Set$volunteer[Set$volunteer == 19] <- "Volunteer 19"
Set$volunteer[Set$volunteer == 20] <- "Volunteer 20"
Set$volunteer[Set$volunteer == 21] <- "Volunteer 21"
Set$volunteer[Set$volunteer == 22] <- "Volunteer 22"
Set$volunteer[Set$volunteer == 23] <- "Volunteer 23"
Set$volunteer[Set$volunteer == 24] <- "Volunteer 24"
Set$volunteer[Set$volunteer == 25] <- "Volunteer 25"
Set$volunteer[Set$volunteer == 26] <- "Volunteer 26"
Set$volunteer[Set$volunteer == 27] <- "Volunteer 27"
Set$volunteer[Set$volunteer == 28] <- "Volunteer 28"
Set$volunteer[Set$volunteer == 29] <- "Volunteer 29"
Set$volunteer[Set$volunteer == 30] <- "Volunteer 30"

#fixing column names 
names(Set) <- gsub("Acc", "Accelerator", names(Set))
names(Set) <- gsub("Mag", "Magnitude", names(Set))
names(Set) <- gsub("Gyro", "Gyroscope", names(Set))
names(Set) <- gsub("^t", "Time", names(Set))
names(Set) <- gsub("^f", "Frequency", names(Set))

#writing down the final tidy data set, taking the mean of every column broken down by volunteer and activity
Set.dt<-data.table(Set)
TidyData <- Set.dt[, lapply(.SD, mean), by = 'volunteer,activity']
write.table(TidyData, file = "TidyData.txt", row.names = FALSE)