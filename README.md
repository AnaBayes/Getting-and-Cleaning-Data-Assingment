# Getting and Cleaning Data Assingment

This repository contains all the files for the Getting and Cleaning Data project.

## Files

The script *run_analysis.R* contains the code that does the analysis described in the project 5 steps. It merges the training and test set from the data UCI HAR Dataset, labels the new set appropriately and gives the variables their descriptive names. After merging, two new data sets are created containing only columns that have to do with mean and standard deviation. The output of the code is the text file *TidyData.txt* (also provided in the repository) with the required tidy data set.

*Code Book.md* describes the data , the variables and all transformations done by *run_analysis.R* script.
