#### PART 1 ####

# download the file

dataSource <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataSource, destfile="accelerometerData.zip")

# unzip the file

zipF <- "./accelerometerData.zip"
outdir <- "./accelerometerData"
unzip(zipF, exdir=outdir)

# define file path of the new data

filepath <- file.path("./accelerometerData", "UCI HAR Dataset")

# list the files for information

files <- list.files(filepath, recursive=TRUE)

# read the relevant 'test' files from the unzipped data

test_subject <- read.table(file.path(filepath, "test", "subject_test.txt"), header = FALSE)
test_x <- read.table(file.path(filepath, "test", "X_test.txt"), header = FALSE)
test_y <- read.table(file.path(filepath,"test","y_test.txt"),header=FALSE)

# read the relevant 'train' files from the unzipped data

train_subject <- read.table(file.path(filepath, "train", "subject_train.txt"), header = FALSE)
train_x <- read.table(file.path(filepath, "train", "X_train.txt"), header = FALSE)
train_y <- read.table(file.path(filepath,"train","y_train.txt"),header=FALSE)

# read the 'features' list

features <- read.table(file.path(filepath, "features.txt"), header = FALSE)

# add column names to each of the tables

colnames(test_x) <- features[,2]
colnames(train_x) <- features[,2]
colnames(test_y) <- "Exercise_ID"
colnames(train_y) <- "Exercise_ID"
colnames(test_subject) <- "Person_ID"
colnames(train_subject) <- "Person_ID"

# combine the test data in to one table

test_data <- cbind(test_subject, test_y, test_x)

# combine the train data in to one table

train_data <- cbind(train_subject, train_y, train_x)

# combine test adn train data in to final dataset

complete_data <- rbind(test_data, train_data)


#### PART 2 ####

# make a vector 'columnNames' from the column names in the dataset 

columnNames <- colnames(complete_data)

# use grepl() and regular expressions to 'filter' those with 'mean' and 'std' in the title

mean_and_std <- grepl("mean..", columnNames) | grepl("std..", columnNames)

# set the first two values to TRUE, as 'Person_ID' and 'Exercise_ID' need to be retained

mean_and_std[1] <- TRUE
mean_and_std[2] <- TRUE

# use mean_and_std to filer rows of the original dataset

mean_and_std_set <- complete_data[mean_and_std]


#### PART 3 ####

# read the activities and change column names

activities <- read.table(file.path(filepath, "activity_labels.txt"), header = FALSE)
colnames(activities) <- c("Number","Activity")

# merge 'mean_and_std_set' with activities

mean_and_std_activities <- merge(mean_and_std_set, activities, by = "Exercise_ID", all = TRUE)

# move the 'Activitiy' column to the right of the 'Exercise_ID' column where it makes more sense

library(dplyr)
mean_and_std_activities <- mean_and_std_activities %>% relocate("Activity", .after = "Exercise_ID")


#### PART 4 ####

# descriptive variable names included in part 1


#### PART 5 ####

# create a copy of the main dataset for summarising

mean_values <- mean_and_std_activities

# use the aggregate() function to calculate the means of each person and each activity

agg_mean_values <- aggregate(.~ Person_ID + Activity, mean_values, mean)

# order the new dataset by Person_ID then Exercise_ID

agg_mean_values <- agg_mean_values[order(agg_mean_values$Person_ID, agg_mean_values$Exercise_ID), ]

# write the data to a new text file

write.table(agg_mean_values, "aggregated_dataset.txt", row.name = FALSE)