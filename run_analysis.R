# G S Sutcliffe - Jan 2018

# Script to perform the required analysis for the final project
# in Coursera's Geting and Cleaning Data course

# This script comprises 5 functions which correspond to the steps in the
# project outline. Each function is commented for clarity.

# load libraries
library(dplyr)

# The script assumes that the HAR dataset is in the current working directory,
# so we first check it's presence and exit if not found
if (!file.exists('./UCI HAR Dataset/')) {stop('UCI HAR Dataset directory not found')}

merge_raw_data <- function() {
    # This function handles loading all the required files and setting the column
    # names - the raw measurements, the activity IDs, and the subject IDs. It
    # returns the merged dataset as a dplyr data.frame

    # Since read.table can set the column names as it's loading the data, we'll
    # read features.txt first and use it to set the column names, rather than
    # adding them later via names()

    # load the column names from features.txt
    features <- read.table('UCI HAR Dataset/features.txt',col.names = c('id','feature'))

    # read the raw data, setting the column names as well, and merge row-wise
    test_data  <- tbl_df(read.table('UCI HAR Dataset/test/X_test.txt',col.names = (features$feature)))
    train_data <- tbl_df(read.table('UCI HAR Dataset/train/X_train.txt',col.names = (features$feature)))
    raw <- rbind(train_data,test_data)

    # The activity ID is needed for later grouping, so read it, merge it row-wise
    # and add it as a column to 'raw'
    activity_test  <- read.table('./UCI HAR Dataset/test/y_test.txt',col.names = c('activity'))
    activity_train <- read.table('./UCI HAR Dataset/train/y_train.txt',col.names = c('activity'))
    activities     <- rbind(activity_train,activity_test)
    raw            <- cbind(raw,activities)

    # The subject ID is also needed later for grouping, so again, read it, merge
    # it, and add it as a column
    subject_test  <- read.table('./UCI HAR Dataset/test/subject_test.txt',col.names = c('subject'))
    subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt',col.names = c('subject'))
    subjects      <- rbind(subject_train,subject_test)
    raw           <- cbind(raw,subjects)

    # Convert the subject ID to a factor while we're here, since each ID is a
    # separate individual
    mutate(raw, subject = as.factor(subject))

}

extract_means_and_stds <- function(dataset) {
    # This function filters for the columns we're looking for, which is anything
    # that is a mean or standard deviation

    # Since we're using Dplyr, we can use contains() in select() to do this
    # easily. We also need to keep the activity and subject ID columns.
    select(dataset,subject,activity,contains('mean'),contains('std')) %>%
        # We don't, however, want the 'meanFreq' or 'angle.*' variables
        select(-contains('meanFreq'),-starts_with('angle'))
}

label_activities <- function(dataset) {
    # This function reads the activity labels from activity_labels.txt and
    # converts the activity column to a factor using this data

    labels <- read.table('./UCI HAR Dataset/activity_labels.txt',col.names = c('activity','label'))

    # Now merge the data and select the label, and use that to replace the ID
    # column in the original dataset.
    merge(dataset,labels) %>%
        mutate(activity = label) %>%
        select(-label)
}

rename_variables <- function(dataset) {
    #This function just does a bit of tidying up on the variable names

    names <- names(dataset)

    # Replace CamelCase variables with lowercase + underscore
    names <- gsub('Acc','_acc',names)
    names <- gsub('Body','_body',names)
    names <- gsub('Gravity','_gravity',names)
    names <- gsub('Gyro','_gyro',names)
    names <- gsub('Jerk','_jerk',names)
    names <- gsub('Mag','_mag',names)

    # Remove trailing '..' from line ends
    names <- sub('\\.\\.$','',names)

    # Replace '...' with just '.'
    names <- gsub('\\.\\.\\.','\\.',names)

    # Lowercase the XYZ variables
    names <- tolower(names)

    # Assign the new names and return it
    names(dataset) <- names
    dataset
}

summarise_means_stds <- function(dataset) {
    # Thanks to dplyr, this is easy. We group by subject and activity, and
    # then call summarise_all to return the mean for every remaining column

    dataset %>%
        group_by(subject,activity) %>%
        summarise_all(mean) %>%
        arrange(subject,activity)
}

# Having defined all the functions, we now call them in order to produce the
# final dataset, which is printed to stdout.

merge_raw_data() %>%
    extract_means_and_stds %>%
    label_activities %>%
    rename_variables %>%
    summarise_means_stds %>%
    print