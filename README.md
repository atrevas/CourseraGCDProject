# Getting and Cleaning Data Project

This repository contains the code for the **"Getting and Cleaning Data"** course project.

## Objective

The objective of this project is to prepare tidy data that can be used for later analysis. The source data comes from the Human Activity Recognition database. It has been built from the recordings of 30 subjects performing activities of daily living while carrying a waist-mounted smartphone with embedded intertial sensors.

## Source code

There are two source code files in this project:

* The run_analysis.R file contains the main code that calls all the necessary functions

* The func.R file contains the code of the functions that have been written to do the job.

## Functions

The job at hand has been divided in separated funcitons. Each function solves part of the overall problem.

* load_train_data: load the train data set into memory.
* load_test_data: load the test data set into memory.
* merge_train_test: merge the train and the test data sets.
* set_activity_labels: set the names of the activies in the data set.
* label_data_set: label the data set with descriptive variable names.
* average_by_activity_and_subject: create the final data set with the average of each variable.

