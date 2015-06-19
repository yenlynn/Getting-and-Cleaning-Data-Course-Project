# Getting-and-Cleaning-Data-Course-Project
##Code Book
1. activity_labels - List of activity labels including activity_no and activity_desc
2. features - List of features of studies
3. test_subject - List of test subject, subject's id
4. test_Xdata - List of test dataset
5. test_ydata - List of test label set data
6. train_subject - List of train subject, subject's id
4. train_Xdata - List of train dataset
5. train_ydata - List of train label set data
6. test_join - Data consist of column bind test_subject, test_Xdata and test_ydata
7. train_join - Data consist of column bind train_subject, train_Xdata and train_ydata

##How the script work
1. Set the working directory in R to be where the "getdata_projectfiles_UCI HAR Dataset" located
2. Load in reshape package to use it function to prepare the data
3. Load in activity_label.txt file and assign it to activity_labels
4. Load in features.txt file and assign it to features
5. After loading features.txt file, extract the column name and assign it to f_names
6. Load in subject_test.txt, assign it to test_subject and rename the column name to subject id
7. Load in X_test.txt, assign it to test_Xdata and rename the column name following the fnames assign earlier
8. Load in y_test.txt, assign it to test_ydata and rename the column name to tid
9. Load in subject_train.txt, assign it to train_subject and rename the column name to subject id
10. Load in X_train.txt, assign it to train_Xdata and rename the column name following the fnames assign earlier
11. Load in y_train.txt, assign it to train_ydata and rename the column name to tid
12. Column bind test_subject, test_ydata and test_Xdata into test_join
13. Column bind train_subject, train_ydata and train_Xdata into train_join
14. Row bind both the test_join and train_join into fulldata
15. Use grep to find all the column name with "mean" in it into mean_column
16. Extract out the column name that consist column name with "mean" into mean_column_name
17. Use grep to find all the column name with "std" in it into std_column
18. Extract out the column name that consist column name with "std" into std_column_name
19. Extract the fulldata with column subjectid, tid, column name with "mean" and column name with "std"
20. Merge the activity_labels and newdata to get the activity_desc by merging activity_no from activity_label and tid from newdata
21. Use melt function from reshape package to change the data presentation style to row
22. Use the dcast function from reshape package to cast the data to produce the mean result.
23. Use the write.table to save the output into a run_analysis.txt text file
