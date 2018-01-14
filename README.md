# Getting and Clean Data - Course Project

This repo contains the analysis script and codebook for the week 4 course
project of Getting and Cleaning Data. This file explains the workings of the
script.

# Running the script

You will need the Samsung UCI HAR data unzipped in this directory - i.e the
directory `UCI HAR Dataset` needs to exist. The script will exit with an error
if it cannot find the data.

You will also need the `dplyr` package available. The script will load it
automatically.

Once these conditions are met, simply `source('run_analysis.R')` to run the
script and return the analysed tidy data set. `codebook.md` contains the
explanation of the variables.

# How the script works

The script is split into 5 functions, each of which performs a specific goal.
Each function except the first takes a single `data.frame` argument, so
chaining can be used between the functions. At the end of the script we call
all 5 functions in sequence (using chaining) to get the final dataset.

## Function 1 - loading the data from files

The first function handles all the file loading, and creates the initial
*merged* messy dataset. It loads all the data in:

* features.txt
* X_train.txt
* X_test.txt
* Y_train.txt
* Y_test.txt
* subject_train.txt
* subject_test.txt

It first merges the `X_train.txt` and `X_test.txt` files, and uses the data in
`features.txt` to set the column names. `rbind` is used to merge these into a
single data.frame.

Since the subject and activity IDs are also needed, it loads these from
`subject_train.txt`, `subject_test.txt`, `Y_train.txt`, and `Y_test.txt`, again
merging them with `rbind` and then adding them to the data.frame with `cbind`.
Subject ID is also converted to a factor since it represents individuals.

Finally, the messy dataset is returned from the function

## Function 2 - selecting columns

The assignment calls for all the means and standard deviations. The codebook
shows that these columns are called `mean` and `std` so the script uses
`select()` and `contains()` to extract all the matching columns, as well as the
`subject` and `activity` columns needed for later grouping.

However, this also matches `meanFreq` and 7 columns starting with `angle` which
are not required, so a second `select` is called to remove these columns. The
extracted dataset is then returned from the function.

## Function 3 - labelling activities

At this point the dataset has activities as a numeric ID, which needs to be
corrected.

The script first loads the activity labels from `activity_labels.txt` and
merges this into the main dataset. This produces a new column `label` *in
addition to* the `activity` numeric ID, so a `mutate` and `select` is used to
update the `activity` column with the text, and remove the unnecessary `label`
column. The updated dataset is then returned.

## Function 4 - tidying variable names

This function simply manipulates the column names to make them a bit more readable.

First, note that names like `tBodyGyro.std` don't look good with a simple
lowercase (e.g. `tbodygyro.std`) so instead we use a series of `gsub` sunctions
to replace capitalised words with lowercase & an underscore. Then extra periods
are cleaned up, and a final `tolower` used to ensure nothing was missed.

Finally, the new column names are assigned to the dataset and the dataset is
returned.

## Function 5 - calculating means per subject & activity

`Dplyr` makes this stage very easy. First, `group_by` will deal with the
grouping, after which `summarise_all` will calculate the mean for every
ungrouped column. Finally `arrange` is used to sort the result nicely, and the
result is returned for printing.
