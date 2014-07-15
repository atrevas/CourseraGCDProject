# make.names

cDataFolder <- file.path('.', 'data', 'UCI HAR Dataset')
cDataFolder

cTrainFolder <- file.path(cDataFolder, 'train')
cTrainFolder

cTestFolder  <- file.path(cDataFolder, 'test')
cTestFolder

cFeaturesFile <- file.path(cDataFolder, 'features.txt')
cFeaturesFile

dfFeatures <- read.table(cFeaturesFile, header = FALSE
                       , stringsAsFactors = FALSE
                       , col.names = c('num', 'name'))
