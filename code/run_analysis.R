# make.names
library(stringr)

source('func.R')


###############################################################################
# 1 - Merges the training and the test sets to create one data set.
###############################################################################
data <- merge_train_est()

###############################################################################
# 2 - Extracts only the measurements on the mean and standard deviation for 
# each measurement. 
###############################################################################
pattern <- "-mean\\(\\)|std\\(\\)"

col_names <- colnames(data)[str_detect(colnames(data), pattern)]

# Add back the ActivityId and the Subject columns
col_names <- c(col_names, cActivityIdColName, cSubjectColName)

# Create a new data frame only with the measurements on the mean and standard 
# deviation + the ActivityId and the Subject columns
data_mean_std <- (data[ , col_names])

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
str(data_descriptive)


###############################################################################
# 5 - Creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject.
###############################################################################
data_final <- average_by_activity_and_subject(data_descriptive)
str(data_final)


# Save the resulting data set to disk
result_file_name <- file.path(cDataFolder, 'result.txt')
write.table(data_final, result_file_name, sep = ',')

