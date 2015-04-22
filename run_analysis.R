library(plyr)
setwd("./UCIHARDataset")
# Read global parameters
feat<-read.table("./features.txt",sep=" ",header=FALSE)
colnames(feat)<-c("feat_id","feat_name")
act<-read.table("./activity_labels.txt",sep=" ",header=FALSE)
colnames(act)<-c("act_id","act_name")

# Read source test data
testx<-read.table("./test/X_test.txt")
colnames(testx)<-feat[,2]
testy<-read.table("./test/y_test.txt")
colnames(testy)<-"act_id"
testsubject<-read.table("./test/subject_test.txt")
colnames(testsubject)<-"subject_id"

#Read source train data
trainx<-read.table("./train/X_train.txt")
colnames(trainx)<-feat[,2]
trainy<-read.table("./train/y_train.txt")
colnames(trainy)<-"act_id"
trainsubject<-read.table("./train/subject_train.txt")
colnames(trainsubject)<-"subject_id"

# 1. Merge the training and the test sets to create one data set.
xdata<-rbind(testx,trainx)
ydata<-rbind(testy,trainy)
subjdata<-rbind(testsubject,trainsubject)

# 2. Extract only the measurements on the mean and standard deviation
# for each measurement.
meanstdfeat <- grep("-(mean|std)\\(\\)", feat[, 2])
xdata <- xdata[, meanstdfeat]

# 3. Use descriptive activity names to name the activities in the 
# data set.
ydata[, 1] <- act[ydata[, 1], 2]
colnames(ydata)<-"activity"

# 4. Appropriately label the data set with descriptive variable names. 
colnames(subjdata)<-"subject"

# Bind all cleaned data in one table.
bounddata<-cbind(xdata,ydata,subjdata)

# 5. From the data set in step 4, create a second, independent tidy 
# data set with the average of each variable for each activity and 
# each subject.
avgdata<-ddply(bounddata, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(avgdata, "averages_data.txt", row.name=FALSE)