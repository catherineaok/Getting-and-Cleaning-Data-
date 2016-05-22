### Getting and Cleaning Data Assignment

## Overview
The purpose of this project is to prepare tidy data that can be used for later analysis.

This work is based on the "Human Activity Recognition Using Smartphones Dataset" Version 1.0 : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

[The source data for this project can be found here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


## Analysis performed

The `run_analysis.R` script does the following:

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Additional Information
Additional information about the variables, data, and transformations can be found in the CODEBOOK.MD file.