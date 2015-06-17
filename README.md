<h1> Getting and Cleaning Data Course Project </h1>

This text explains how the script „run_analysis.R“ works.

<h2> Reading Data </h2>

The zip archive has been downloaded and unpacked. The directory containing the data has been moved into the working directory of R. In the first step, all required data files has been read with the function read.table() from the working directory and assigned to single data frames.


<h2> Computing the main data frame </h2>

The data frames with data from „X_test“ and „X_train“ were converted with the function tbl_df() from the package "plyr" in special data frames. Subsequently, these were combined with the function bind_row() and were assigned to one new Data Frame called "dt_test_train".

The variables' names read from text file "feature.txt" were assigned the Data Frame "dt_test_train" as the column names. With the function select_vars () were extracted subsets of those variables whose name "-mean ()" or "-std ()" contains. These two subsets ("submean", "substds") was again combined in one data frame.

The codings of the subjects taken from text files "subject test" and "subject train" were merged into a data frame "dt_subjects" and the column name "subject" was the data frame assigned.

Similarly, the codings of the activities taken from the text files "Y_test.txt" and "Y_train.txt" was merged into a data frame "dt_activities" and the column name "activity" has been assigned to this data frame.

The coding of the activities has been replaced by simple subsetting with clear names taken from the text file "activity_labels.txt".

The data frames of subjects and activities have been merged with the data frame of the measurements by applying function cbind().

<h2> Calculatings means of each variable for each activity and each subject </h2>
Finally, the data frame "dt_test_train" was grouped using the function "group_by()" along the variables "subject" and "activity" and assigned to a new data frame "df_means". To this the function "summarise_each" together with "mean ()" was used to calculate an average for each variable. The resulting data frame "df_mean" was written with the function "write.table ()" in a file.

To relieve the system all R-objects have been deleted as soon as they were no longer needed.

