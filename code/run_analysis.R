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
str(cNames)

# Create a new data frame only with the measurements on the mean and standard deviation
dfMeanStd <- (dfHAR[ , cNames])

str(dfMeanStd)

###################################################################################################
# 3 - Uses descriptive activity names to name the activities in the data set
###################################################################################################
dfActivity <- DFSetActivityLabel(dfMeanStd)
str(dfActivity)

# 4 - Appropriately labels the data set with descriptive variable names. 
# 5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


