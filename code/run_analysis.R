source(file.path('.','code','func.R')) # Includes the ./code/func.R script

###############################################################################
# 1 - Merges the training and the test sets to create one data set.
###############################################################################
data <- merge_train_test()

###############################################################################
# 2 - Extracts only the measurements on the mean and standard deviation for 
# each measurement. 
###############################################################################
data_mean_std <- extract_mean_std(data)

# Check the total number of rows
stopifnot(nrow(data_mean_std) == nrow(data))

###############################################################################
# 3 - Uses descriptive activity names to name the activities in the data set
###############################################################################
data_activity <- set_activity_labels(data_mean_std)

# Check the total number of rows
stopifnot(nrow(data_activity) == nrow(data_mean_std))


###############################################################################
# 4 - Appropriately labels the data set with descriptive variable names. 
###############################################################################
new_names = label_data_set(names(data_activity))
data_descriptive <- data_activity
names(data_descriptive) <- new_names

###############################################################################
# 5 - Creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject.
###############################################################################
data_final <- average_by_activity_and_subject(data_descriptive)

# Save the resulting data set to disk
result_file_name <- file.path(data_folder, 'result.txt')
write.table(data_final, result_file_name, sep = ',')

