<h1> Getting and Cleaning Data Course Project </h1>

This text explains how the script „run_analysis.R“ works.

<h2> Reading Data </h2>

The zip archive is manually downloaded and unpacked. The directory containing the unzipped data has been moved into the working directory of R. In the first step, all required raw data files are read with the function read.table() from the working directory and assigned to single data frames. Here, the function tbl_df () from the package "dplyr" is used to create special data frames from the main data sets X_test and X_train.


<h2> Computing the main data frame </h2>

Subsequently, these two data frames are merged with the function bind_row() and assigned to one new data frame called "dt_test_train".

The variables' names read from text file "feature.txt" are assigned the data frame "dt_test_train" as the column names. With the function select_vars () are extracted subsets of those variables whose name "-mean ()" or "-std ()" contains. These two subsets ("submean", "substds") are again joined in one data frame.

The codings of the subjects taken from text files "subject test" and "subject train" are merged into a data frame "dt_subjects" and the column name "subject" is assigned to this data frame.

Similarly, the codings of the activities taken from the text files "Y_test.txt" and "Y_train.txt" are merged into a data frame "dt_activities" and the column name "activity" is assigned to this data frame. The codings of the activities are replaced by simple subsetting with clear names taken from the text file "activity_labels.txt".

The data frames of subjects and activities are merged with the data frame of the measurements by applying function cbind().

<h2> Calculatings means of each variable for each activity and each subject </h2>
Finally, the data frame "dt_test_train" is grouped using the function "group_by()" along the variables "subject" and "activity" and assigned to a new data frame "df_means". To this the function "summarise_each" together with "mean ()" is used to calculate an average of each variable for each activity and each subject. The resulting data frame "df_mean" is written with the function "write.table ()" in a plain text file called ".txt".

To relieve the system all R-objects are deleted as soon as they are no longer needed.

