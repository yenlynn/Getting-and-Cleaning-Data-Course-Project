setwd("C:/Users/mycp1urz/Desktop/R programming/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")
library(reshape2)
activity_labels <- read.table("./activity_labels.txt",col.names =c("activity_no","activity_desc"))
features <- read.table("./features.txt")
f_names<- features[,2]

test_subject <- read.table("./test/subject_test.txt")
dim(test_subject)
colnames(test_subject) <-"subjectid" 

test_Xdata <- read.table("./test/X_test.txt")
dim(test_Xdata)
colnames(test_Xdata)<- f_names

test_ydata <- read.table("./test/y_test.txt")
dim(test_ydata)
colnames(test_ydata) <-"tid"

train_subject <- read.table("./train/subject_train.txt")
dim(train_subject)
colnames(train_subject)<-"subjectid"

train_Xdata <- read.table("./train/X_train.txt")
dim(train_Xdata)
colnames(train_Xdata)<- f_names

train_ydata <- read.table("./train/y_train.txt")
dim(train_ydata)
colnames(train_ydata)<-"tid"

test_join <- cbind(test_subject,test_ydata, test_Xdata)
train_join <- cbind(train_subject, train_ydata, train_Xdata)

fulldata <-rbind(test_join,train_join)
dim(fulldata)

mean_column <- grep("mean", names(fulldata))
mean_coloum_name <- names(fulldata)[mean_column]
std_column <- grep("std", names(fulldata))
std_column_name <- names(fulldata)[std_column]

newdata <- fulldata[,c("subjectid","tid",mean_coloum_name,std_column_name)]


mergedata <- merge(activity_labels, newdata, by.x ="activity_no", by.y ="tid")


datadesc <- melt(mergedata, c("activity_no","activity_desc","subjectid"))

meandata <-dcast(datadesc,activity_desc + subjectid ~ variable,mean)

write.table(meandata, file ="./run_analysis.txt", row.names = FALSE)





