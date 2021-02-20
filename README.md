# ProgrammingAssignment3
Work submitted for 'Getting and cleaning data' assignment in Coursera Data Science Specialisation. This assignment requires the candidate to combine data from several files stored at the location below and clean it for later analysis.

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This repository includes the following
  
  1)  run_analysis.R
      The R script used to provide a clean dataset

  2)  aggregated_dataset.txt
      The clean dataset that is output from the run_analysis.R
      
  3)  codebook.md
      The codebook, which lists the variables in the clean dataset and their units

**About the data**

This data relates to Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Further information can be found here

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


**Run analysis.R**
 
This R script performs the following key tasks

1) Downloads the zip file from the given URL
2) Unzips the file
3) Reads those files data from the unzipped files which are relevant to this task
4) Adds column titles
5) Merges the data from the 'test' and 'train' files
6) Removes those columns which do NOT include information about the mean or standard deviation of the variables
7) Aggregates the data to calculate the mean of each activity for each subject in the trial
8) Writes this aggregated data to a .txt file aggregated_dataset.txt

R Studio version 1.3.959 was used to  run the script.



**aggregated_dataset.txt**

This is the output file of run_analysis.R. It is a clean data set for future analysis which contains the aggregated mean of each activity for each subject in the trial


**codebook.md""

A codebook of the variables included in the aggregated_dataset.txt file.
