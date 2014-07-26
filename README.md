# Getting and Cleaning Data Project

This repository contains the code for the **"Getting and Cleaning Data"** course project.

## Objective

The objective of this project is to prepare tidy data that can be used for later analysis. The source data comes from the Human Activity Recognition database. It has been built from the recordings of 30 subjects performing activities of daily living while carrying a waist-mounted smartphone with embedded intertial sensors.

## Data Source

* The original data set can be obtained from this site:

    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
    
* The data for the project can be downloaded from:

    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Source code

The R source code files are located under the *./code* directory. There are two source code files in this project:

* The *./code/run_analysis.R* file contains the main code that calls all the necessary functions.

* The *./code/func.R* file contains the code of the functions that have been written to do the job.

## Functions

The task has been divided in separated functions. Each function solves part of the overall problem.

* load_train_data: load the train data set into memory.
* load_test_data: load the test data set into memory.
* merge_train_test: merge the train and the test data sets.
* extract_mean_std: extracts only the measurements on the mean and standard deviation.
* set_activity_labels: set the names of the activies in the data set.
* label_data_set: label the data set with descriptive variable names.
* average_by_activity_and_subject: create the final data set with the average of each variable.

## Instructions

In order to use these scripts you will have to:

* set the working directory in R to the the main directory in which the repository is located.
* have the data uncompressed and located under the *./data* directory.
* run the *./code/run_analysis.R* script to generate the final result data set.

## What the script will do

The script will read the raw train and test data from the data folder and apply a series of transformations that will merge the two data sets, keep only the variables related to means and standard deviations, associate an activity label to each observation and aggregate the data by subject and activity, calculating means for all remaining variables.
The final result will be saved in a file named *result.txt* under the data directory.

## References

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012



