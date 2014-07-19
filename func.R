# Initialize folder variables
cDataFolder <- file.path('.', 'data', 'UCI HAR Dataset')
cTrainFolder <- file.path(cDataFolder, 'train')
cTestFolder  <- file.path(cDataFolder, 'test')

DFMergeTrainTest <- function () {
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

DFSetActivityLabel <- function(df){
  cActFile <- file.path(cDataFolder, 'activity_labels.txt')
  cTrainFile <- file.path(cTrainFolder, 'y_train.txt')
  cTestFile <- file.path(cTestFolder, 'y_test.txt')
    
  # Load activity labels
  dfActLabel <- read.table(cActFile, header = FALSE, col.names = c('ActivityId'
                                                                   , 'ActivityLabel') )
  
  # Load activity ids for the train data
  dfTrainAct <- read.table(cTrainFile, header = FALSE, col.names = c('ActivityId') )
  
  # Load activity ids for the test data
  dfTestAct <- read.table(cTestFile, header = FALSE, col.names = c('ActivityId') )
  
  # Merge the train and test data
  dfAct <- rbind(dfTrainAct, dfTestAct)
        
  # Check the total number of rows
  stopifnot(nrow(dfAct)  == nrow(df))
  
  # Add the Activity Id column to the result data frame
  dfResult <- cbind(df, dfAct)
  str(dfResult)
  
  # Join activity ids and labels
  dfResult <- merge(x = dfResult, y = dfActLabel, by.x = 'ActivityId', by.y = 'ActivityId' )  
  
  # Check the total number of rows
  stopifnot(nrow(dfResult)  == nrow(df))
  
  return(dfResult)
}

CLabelDataSet <- function(cNames){
  # Remove parenthesis
  cResult <- str_replace_all(cNames, '[\\(\\)]','')
    
  # Mean
  cResult <- str_replace(cResult, '-mean','Mean')
  
  # Std
  cResult <- str_replace(cResult, '-std','StdDev')
  
  
  return(cResult)
}