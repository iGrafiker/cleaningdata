#You should create one R script called run_analysis.R that does the following. 
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.

## manipulte data frames with package dplyr
library(dplyr)

## set working directory
old_wd <- getwd()
directory <-"Google Drive/eLearning/Kurs_3"
myPath <- paste(sep="/", old_wd, directory)
if (getwd() != myPath){
  setwd(myPath) 
}
if (!file.exists("data")) {
  dir.create("data")
}
## read data files from working directory
file_test <- "./data/UCI HAR Dataset/test/X_test.txt"
file_train <- "./data/UCI HAR Dataset/train/X_train.txt"
file_activiesTest <- "./data/UCI HAR Dataset/test/Y_test.txt"
file_activiesTrain <- "./data/UCI HAR Dataset/train/Y_train.txt"
file_subjectsTest <-"./data/UCI HAR Dataset/test/subject_test.txt"
file_subjectsTrain <-"./data/UCI HAR Dataset/train/subject_train.txt"
file_activityLabels <- "./data/UCI HAR Dataset/activity_labels.txt"
file_features <-"./data/UCI HAR Dataset/features.txt"

dt_features <- data.frame(read.table(file_features, header=FALSE))
dt_activityLabels <- data.frame(read.table(file_activityLabels, header=FALSE))
dt_activies_test <- data.frame(read.table(file_activiesTest, header=FALSE))
dt_activies_train <- data.frame(read.table(file_activiesTrain, header=FALSE))
dt_subjects_test <- data.frame(read.table(file_subjectsTest, header=FALSE))
dt_subjects_train <- data.frame(read.table(file_subjectsTrain, header=FALSE))
dt_test <- tbl_df(read.table(file_test, header=FALSE))
dt_train <- tbl_df(read.table(file_train, header=FALSE))

# remove variables that are no longer needed
rm(file_test, file_train, file_activiesTest, file_activiesTrain, file_subjectsTest,file_subjectsTrain,
   file_activityLabels, file_features, directory, myPath)

## merge both data frames test and train
dt_test_train <- bind_rows(dt_test, dt_train)
rm(dt_test, dt_train) # remove r-objects that are no longer needed

# add clear names to variables/columns
var_names <- as.vector(dt_features$V2)
names(dt_test_train) <- var_names
rm(dt_features)

# extract variables with mean and standard deviation
var_means <- select_vars(names(dt_test_train), contains("-mean()"))
var_stds <- select_vars(names(dt_test_train), contains("-std()"))
sub_mean <- dt_test_train[var_means]
sub_stds <- dt_test_train[var_stds]
dt_test_train <- cbind(sub_mean, sub_stds)
rm(sub_mean, sub_stds)

# merge subjects and add column name
dt_subjects <- bind_rows(dt_subjects_test, dt_subjects_train)
names(dt_subjects) <- "subject"
rm(dt_subjects_test, dt_subjects_train)

# merge actvities codes and add column name
dt_activities <- bind_rows(dt_activies_test, dt_activies_train)
names(dt_activities) <- "activity_code"
rm(dt_activies_test, dt_activies_train)

# replace activity codes with clear names
dt_activities$activity[dt_activities$activity_code == 1] <- as.vector(dt_activityLabels[1,2])
dt_activities$activity[dt_activities$activity_code == 2] <- as.vector(dt_activityLabels[2,2])
dt_activities$activity[dt_activities$activity_code == 3] <- as.vector(dt_activityLabels[3,2])
dt_activities$activity[dt_activities$activity_code == 4] <- as.vector(dt_activityLabels[4,2])
dt_activities$activity[dt_activities$activity_code == 5] <- as.vector(dt_activityLabels[5,2])
dt_activities$activity[dt_activities$activity_code == 6] <- as.vector(dt_activityLabels[6,2])
# remove column with activity code
dt_activities <- subset(dt_activities, select = -c(activity_code))

# add columns with subjects and activities to data frame
dt_test_train <- cbind(dt_subjects, dt_activities, dt_test_train)
rm (dt_subjects, dt_activities, dt_activityLabels) # remove data frames

# compute new data frame with the average of each variable for each activity and each subject
dt_means <- group_by(dt_test_train, subject, activity)
dt_means <- dt_means %>% summarise_each(funs(mean))

# write new data frame to disk
write.table(dt_means, file = "./data/datafile.txt", sep = " ", col.names=TRUE, row.names = FALSE)
#df_test <- data.frame(read.table("datafile.txt", header=TRUE))

# reset working directory
setwd(old_wd) 
