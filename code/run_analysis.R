# make.names
library(stringr)

source('func.R')

###################################################################################################
# 1 - Merges the training and the test sets to create one data set.
###################################################################################################
dfHAR <- DFMergeTrainTest()
str(dfHAR)

###################################################################################################
# 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
###################################################################################################
cPattern <- "-mean\\(\\)|std\\(\\)"

cNames <- colnames(dfHAR)[str_detect(colnames(dfHAR), cPattern)]

# Add back the ActivityId and the Subject columns
cNames <- c(cNames, cActivityIdColName, cSubjectColName)

# Create a new data frame only with the measurements on the mean and standard deviation
# + the ActivityId and the Subject columns
dfMeanStd <- (dfHAR[ , cNames])

str(dfMeanStd)

# Check the total number of rows
stopifnot(nrow(dfMeanStd) == nrow(dfHAR))

###################################################################################################
# 3 - Uses descriptive activity names to name the activities in the data set
###################################################################################################
dfActivity <- DFSetActivityLabel(dfMeanStd)
str(dfActivity)

# Check the total number of rows
stopifnot(nrow(dfActivity) == nrow(dfMeanStd))

###################################################################################################
# 4 - Appropriately labels the data set with descriptive variable names. 
###################################################################################################
CLabelDataSet(names(dfActivity))

# 5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


