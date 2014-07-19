# make.names

# 1 - Merges the training and the test sets to create one data set.

DfMergeTrainTest <- function () {
  # Initialize folder variables
  cDataFolder <- file.path('.', 'data', 'UCI HAR Dataset')
  cTrainFolder <- file.path(cDataFolder, 'train')
  cTestFolder  <- file.path(cDataFolder, 'test')
  
  
  cTrainFile <- file.path(cTrainFolder, 'X_train.txt')
  cTestFile <- file.path(cTestFolder, 'X_test.txt')
  
  # Load the features file
  cFeaturesFile <- file.path(cDataFolder, 'features.txt')
  dfFeatures <- read.table(cFeaturesFile, header = FALSE
                           , stringsAsFactors = FALSE
                           , col.names = c('num', 'name'))
  
  # Load the train data
  dfTrain <- read.table(cTrainFile, header = FALSE, stringsAsFactors = FALSE)
  iDimTrain <- dim(dfTrain)
  
  # Load the test data
  dfTest <- read.table(cTestFile, header = FALSE, stringsAsFactors = FALSE)
  iDimTest <- dim(dfTest)
  
  # Number of columns must be the same
  stopifnot( iDimTrain[2] == iDimTest[2] )
  
  # Store the expected total number of rows
  iTotalRows <- iDimTrain[1] + iDimTest[1]
  
  # Merge the train and test data sets
  dfAll <- rbind(dfTrain, dfTest)
  iDimAll <- dim(dfAll)
  
  # Set the names of the columns to the features values
  names(dfAll) <- dfFeatures$name
  
  # Check number of total rows
  stopifnot(iDimAll[1] == iTotalRows)
  
  # Check number of columns
  stopifnot(iDimAll[2] == iDimTrain[2])
  
  return (dfAll)
}


dfHAR <- DfMergeTrainTest()
# 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 





# 3 - Uses descriptive activity names to name the activities in the data set
# 4 - Appropriately labels the data set with descriptive variable names. 
# 5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject.





dfFeatures <- read.table(cFeaturesFile, header = FALSE
                       , stringsAsFactors = FALSE
                       , col.names = c('num', 'name'))
