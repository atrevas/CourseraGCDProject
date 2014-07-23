library(plyr)

# Initialize folder variables
data_folder <- file.path('.', 'data')
train_folder <- file.path(data_folder, 'train')
test_folder  <- file.path(data_folder, 'test')

# Define names for additional columns
activity_id_col_name <- 'ActivityId'
activity_label_col_name <- 'ActivityLabel'
subject_col_name <- 'Subject'


load_train_data <- function (features) {
  
  # Set file paths to load the data
  train_set_file <- file.path(train_folder, 'X_train.txt')
  train_label_file <- file.path(train_folder, 'y_train.txt')
  train_subject_file <- file.path(train_folder, 'subject_train.txt')
  
  # Load the training set
  train_set_df <- read.table(train_set_file, header = FALSE, stringsAsFactors = FALSE)
  
  # Set the columns names
  names(train_set_df) <- features
  
  # Load the training labels
  train_label_df <- read.table(train_label_file, header = FALSE
                             , col.names = c(activity_id_col_name) )
  
  # Load the subject data
  train_subject_df <- read.table(train_subject_file, header = FALSE
                               , col.names = c(subject_col_name))
  
  # Combine the data
  result_df <- cbind(train_set_df, train_label_df, train_subject_df)
  
  return(result_df)
}


load_test_data <- function (features) {
  
  # Set file paths to load the data
  test_set_file <- file.path(test_folder, 'X_test.txt')
  test_label_file <- file.path(test_folder, 'y_test.txt')
  test_subject_file <- file.path(test_folder, 'subject_test.txt')
  
  # Load the test set
  test_set_df <- read.table(test_set_file, header = FALSE, stringsAsFactors = FALSE)
  
  # Set the columns names
  names(test_set_df) <- features
  
  # Load the test labels
  test_label_df <- read.table(test_label_file, header = FALSE
                              , col.names = c(activity_id_col_name) )
  
  # Load the subject data
  test_subject_df <- read.table(test_subject_file, header = FALSE
                                , col.names = c(subject_col_name))
  
  # Combine the data
  result_df <- cbind(test_set_df, test_label_df, test_subject_df)
  
  return(result_df)
}

merge_train_est <- function () {
  
  # Load the features file
  features_file <- file.path(data_folder, 'features.txt')
  features_df <- read.table(features_file, header = FALSE
                           , stringsAsFactors = FALSE
                           , col.names = c('num', 'name'))
  
  train_df <- load_train_data(features_df$name)
  
  test_df <- load_test_data(features_df$name)
    
  # Number of columns must be the same
  stopifnot( ncol(train_df) == ncol(test_df))
  
  # Store the expected total number of rows
  total_rows <- nrow(train_df) + nrow(test_df)
  
  # Merge the train and test data sets
  result_df <- rbind(train_df, test_df)
  
  # Check number of total rows
  stopifnot(nrow(result_df) == total_rows)
  
  # Check number of columns
  stopifnot(ncol(result_df) == ncol(train_df))
  
  return (result_df)
}

set_activity_labels <- function(df){
  
  activity_file <- file.path(data_folder, 'activity_labels.txt')
      
  # Load activity labels
  activity_df <- read.table(activity_file, header = FALSE
                           , col.names = c(activity_id_col_name
                              , activity_label_col_name) )
  
  
  # Join activity ids and labels
  result_df <- merge(x = df, y = activity_df, by.x = activity_id_col_name
                    , by.y = activity_id_col_name )  
  
  # Check the total number of rows
  stopifnot(nrow(result_df)  == nrow(df))
  
  return(result_df)
}

label_data_set <- function(names){
  # Remove parenthesis
  result <- str_replace_all(names, '[\\(\\)]','')
    
  # Treat mean
  result <- str_replace(result, '-mean','Mean')
  
  # Treat std
  result <- str_replace(result, '-std','StdDev')
  
  # Treat ending -X, -Y, -Z
  result <- str_replace(result, '-([XYZ])$','\\1')
  
  # Treat prefix 't' (time)
  result <- str_replace(result, '^t','Time')
  
  # Treat prefix 'f' (Frequency)
  result <- str_replace(result, '^f','Frequency')
  
  # Treat Acc abreviation
  result <- str_replace(result, 'Acc','Acceleration')
  
  # Treat Gyro abreviation
  result <- str_replace(result, 'Gyro','Gyroscope')
  
  # Treat Mag abreviation
  result <- str_replace(result, 'Mag','Magnitude')
  
  # Check for repeated names
  unique_test <- unique(result)
  
  stopifnot(length(unique_test) == length(result))
  
  return(result)
}

average_by_activity_and_subject <- function(df){
  # Convert ActivityId to factor just in case
  df$ActivityId <- as.factor(df$ActivityId)
  
  result_df <- ddply(df, c(subject_col_name,  activity_label_col_name )
                    , numcolwise(mean))
  
  return(result_df)
}