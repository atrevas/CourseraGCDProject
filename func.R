library(plyr)

# Initialize folder variables
cDataFolder <- file.path('.', 'data')
cTrainFolder <- file.path(cDataFolder, 'train')
cTestFolder  <- file.path(cDataFolder, 'test')

# Define names for additional columns
cActivityIdColName <- 'ActivityId'
cActivityLabelColName <- 'ActivityLabel'
cSubjectColName <- 'Subject'


DFLoadTrainData <- function (cFeatures) {
  
  # Set file paths to load the data
  cTrainSet <- file.path(cTrainFolder, 'X_train.txt')
  cTrainLabel <- file.path(cTrainFolder, 'y_train.txt')
  cTrainSubject <- file.path(cTrainFolder, 'subject_train.txt')
  
  # Load the training set
  dfTrainSet <- read.table(cTrainSet, header = FALSE, stringsAsFactors = FALSE)
  
  # Set the columns names
  names(dfTrainSet) <- cFeatures
  
  # Load the training labels
  dfTrainLabel <- read.table(cTrainLabel, header = FALSE, col.names = c(cActivityIdColName) )
  
  # Load the subject data
  dfTrainSubject <- read.table(cTrainSubject, header = FALSE, col.names = c(cSubjectColName))
  
  # Combine the data
  dfResult <- cbind(dfTrainSet, dfTrainLabel, dfTrainSubject)
  
  return(dfResult)
}


DFLoadTestData <- function (cFeatures) {
  
  # Set file paths to load the data
  cTestSet <- file.path(cTestFolder, 'X_test.txt')
  cTestLabel <- file.path(cTestFolder, 'y_test.txt')
  cTestSubject <- file.path(cTestFolder, 'subject_test.txt')
  
  # Load the test set
  dfTestSet <- read.table(cTestSet, header = FALSE, stringsAsFactors = FALSE)
  
  # Set the columns names
  names(dfTestSet) <- cFeatures
  
  # Load the test labels
  dfTestLabel <- read.table(cTestLabel, header = FALSE, col.names = c(cActivityIdColName) )
  
  # Load the subject data
  dfTestSubject <- read.table(cTestSubject, header = FALSE, col.names = c(cSubjectColName))
  
  # Combine the data
  dfResult <- cbind(dfTestSet, dfTestLabel, dfTestSubject)
  
  return(dfResult)
}

DFMergeTrainTest <- function () {
  
  # Load the features file
  cFeaturesFile <- file.path(cDataFolder, 'features.txt')
  dfFeatures <- read.table(cFeaturesFile, header = FALSE
                           , stringsAsFactors = FALSE
                           , col.names = c('num', 'name'))
  
  dfTrain <- DFLoadTrainData(dfFeatures$name)
  
  dfTest <- DFLoadTestData(dfFeatures$name)
    
  # Number of columns must be the same
  stopifnot( ncol(dfTrain) == ncol(dfTest))
  
  # Store the expected total number of rows
  iTotalRows <- nrow(dfTrain) + nrow(dfTest)
  
  # Merge the train and test data sets
  dfResult <- rbind(dfTrain, dfTest)
  
  # Check number of total rows
  stopifnot(nrow(dfResult) == iTotalRows)
  
  # Check number of columns
  stopifnot(ncol(dfResult) == ncol(dfTrain))
  
  return (dfResult)
}

DFSetActivityLabel <- function(df){
  
  cActFile <- file.path(cDataFolder, 'activity_labels.txt')
      
  # Load activity labels
  dfActLabel <- read.table(cActFile, header = FALSE, col.names = c(cActivityIdColName
                                                                   , cActivityLabelColName) )
  
  
  # Join activity ids and labels
  dfResult <- merge(x = df, y = dfActLabel, by.x = cActivityIdColName, by.y = cActivityIdColName )  
  
  # Check the total number of rows
  stopifnot(nrow(dfResult)  == nrow(df))
  
  return(dfResult)
}

CLabelDataSet <- function(cNames){
  # Remove parenthesis
  cResult <- str_replace_all(cNames, '[\\(\\)]','')
    
  # Treat mean
  cResult <- str_replace(cResult, '-mean','Mean')
  
  # Treat std
  cResult <- str_replace(cResult, '-std','StdDev')
  
  # Treat ending -X, -Y, -Z
  cResult <- str_replace(cResult, '-([XYZ])$','\\1')
  
  # Treat prefix 't' (time)
  cResult <- str_replace(cResult, '^t','Time')
  
  # Treat prefix 'f' (Frequency)
  cResult <- str_replace(cResult, '^f','Frequency')
  
  # Treat Acc abreviation
  cResult <- str_replace(cResult, 'Acc','Acceleration')
  
  # Treat Gyro abreviation
  cResult <- str_replace(cResult, 'Gyro','Gyroscope')
  
  # Treat Mag abreviation
  cResult <- str_replace(cResult, 'Mag','Magnitude')
  
  # Check for repeated names
  cUnique <- unique(cResult)
  stopifnot(length(cUnique) == length(cResult))
  
  return(cResult)
}

DFAverageByActivityAndSubject <- function(df){
  # Convert ActivityId to factor just in case
  df$ActivityId <- as.factor(df$ActivityId)
  
  dfResult <- ddply(df, c(cSubjectColName,  cActivityLabelColName )
                    , numcolwise(mean))
  
  return(dfResult)
}