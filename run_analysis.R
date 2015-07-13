## set the working directory where the UCI Har Dataset located
setwd("C:/Users/mycp1urz/Desktop/R programming/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")

## set the reshape2 library
library(reshape2)

## load in activity_labels.txt and rename the column to activity_no and activity description
activity_labels <- read.table("./activity_labels.txt",col.names =c("activity_no","activity_desc"))

## load in features.txt file and rename the col to no and desc. Then, assign it to features
features <- read.table("./features.txt", col.names =c("no","desc"))

## After loading features.txt file, extract the column desc and assign it to f_names
f_names<- features[,"desc"]

## Load in subject_test.txt, assign it to test_subject and rename the column name to subject id
test_subject <- read.table("./test/subject_test.txt")
dim(test_subject)
colnames(test_subject) <-"subjectid" 

## Load in X_test.txt, assign it to test_Xdata and rename the column name following the fnames assign earlier
test_Xdata <- read.table("./test/X_test.txt")
dim(test_Xdata)
colnames(test_Xdata)<- f_names

## Load in y_test.txt, assign it to test_ydata and rename the column name to tid
test_ydata <- read.table("./test/y_test.txt")
dim(test_ydata)
colnames(test_ydata) <-"tid"

## Load in subject_train.txt, assign it to train_subject and rename the column name to subject id
train_subject <- read.table("./train/subject_train.txt")
dim(train_subject)
colnames(train_subject)<-"subjectid"

## Load in X_train.txt, assign it to train_Xdata and rename the column name following the fnames assign earlier
train_Xdata <- read.table("./train/X_train.txt")
dim(train_Xdata)
colnames(train_Xdata)<- f_names

## Load in y_train.txt, assign it to train_ydata and rename the column name to tid
train_ydata <- read.table("./train/y_train.txt")
dim(train_ydata)
colnames(train_ydata)<-"tid"

## Column bind test data set (test_subject, test_ydata and test_Xdata) into test_join
test_join <- cbind(test_subject,test_ydata, test_Xdata)

## Column bind test data set (train_subject, train_ydata and train_Xdata) into test_join
train_join <- cbind(train_subject, train_ydata, train_Xdata)

## Row bind both the test_join and train_join into fulldata
fulldata <- rbind(test_join,train_join)
dim(fulldata)

## Filter columns refering to mean() or std() values
## Filter only mean value
mean_column <- grep("mean", names(fulldata))
mean_coloum_name <- names(fulldata)[mean_column]

## Filter only std value
std_column <- grep("std", names(fulldata))
std_column_name <- names(fulldata)[std_column]

## Extract from fulldata with column subjectid, tid, column name with "mean" and column name with "std"
newdata <- fulldata[,c("subjectid","tid",mean_coloum_name,std_column_name)]

## Merge the activity_labels and newdata to get the activity_desc by merging activity_no 
## from activity_label and tid from newdata
mergedata <- merge(activity_labels, newdata, by.x ="activity_no", by.y ="tid")

## Using the reshape function melt to reshape the data
datadesc <- melt(mergedata, c("activity_no","activity_desc","subjectid"))

## Using the dcast function to get the average (mean) of each variable for each activity and each subject
meandata <-dcast(datadesc,activity_desc + subjectid ~ variable,mean)


## Using write.table to save tidy dataset into run_analysis.txt
write.table(meandata, file ="./run_analysis.txt", row.names = FALSE)










