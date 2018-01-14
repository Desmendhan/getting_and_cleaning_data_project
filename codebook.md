# Codebook for Getting and Cleaning Data Course Project

The output from the `run_analysis.R` script is a summary of gyroscopic and
accelerometer data from Samsung phones, from a set of 30 volunteers performing
a variety of activities. The base data and codebook can be found at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphone

The raw data contains 561 columns, which are spatial (X,Y,Z) derivatives (in
time) and Fast-Fourier-Transform frequency derivatives. In this dataset, only
the columns concerning *means* and *standard deviations* are selected. These
are then grouped by *subject* and *activity*, and a *mean average* is
calculated for each grouping. This produces 66 columns of averaged
observations, for example:

* t_body_acc.mean.x
* t_body_acc.mean.y
* t_body_acc.mean.z
  * mean of all "body acceleration in X/Y/Z" observations for a given subject & activity
* t_gravity_acc.mean.x
* t_gravity_acc.mean.y
* t_gravity_acc.mean.z
  * mean of all "gravity acceleration in X/Y/Z" observations for a given subject & activity
* ... and so on

There are 68 columns in the analysed dataset. The first (`subject`) is an
identifier for the volunteer who recorded this set of observations. The second
(`activity`) is the type of activity the subject was performing. The rest are
the calculated means for that grouping in the original data. The full list of
variables is:

* subject
* activity
* t_body_acc.mean.x
* t_body_acc.mean.y
* t_body_acc.mean.z
* t_gravity_acc.mean.x
* t_gravity_acc.mean.y
* t_gravity_acc.mean.z
* t_body_acc_jerk.mean.x
* t_body_acc_jerk.mean.y
* t_body_acc_jerk.mean.z
* t_body_gyro.mean.x
* t_body_gyro.mean.y
* t_body_gyro.mean.z
* t_body_gyro_jerk.mean.x
* t_body_gyro_jerk.mean.y
* t_body_gyro_jerk.mean.z
* t_body_acc_mag.mean
* t_gravity_acc_mag.mean
* t_body_acc_jerk_mag.mean
* t_body_gyro_mag.mean
* t_body_gyro_jerk_mag.mean
* f_body_acc.mean.x
* f_body_acc.mean.y
* f_body_acc.mean.z
* f_body_acc_jerk.mean.x
* f_body_acc_jerk.mean.y
* f_body_acc_jerk.mean.z
* f_body_gyro.mean.x
* f_body_gyro.mean.y
* f_body_gyro.mean.z
* f_body_acc_mag.mean
* f_body_body_acc_jerk_mag.mean
* f_body_body_gyro_mag.mean
* f_body_body_gyro_jerk_mag.mean
* t_body_acc.std.x
* t_body_acc.std.y
* t_body_acc.std.z
* t_gravity_acc.std.x
* t_gravity_acc.std.y
* t_gravity_acc.std.z
* t_body_acc_jerk.std.x
* t_body_acc_jerk.std.y
* t_body_acc_jerk.std.z
* t_body_gyro.std.x
* t_body_gyro.std.y
* t_body_gyro.std.z
* t_body_gyro_jerk.std.x
* t_body_gyro_jerk.std.y
* t_body_gyro_jerk.std.z
* t_body_acc_mag.std
* t_gravity_acc_mag.std
* t_body_acc_jerk_mag.std
* t_body_gyro_mag.std
* t_body_gyro_jerk_mag.std
* f_body_acc.std.x
* f_body_acc.std.y
* f_body_acc.std.z
* f_body_acc_jerk.std.x
* f_body_acc_jerk.std.y
* f_body_acc_jerk.std.z
* f_body_gyro.std.x
* f_body_gyro.std.y
* f_body_gyro.std.z
* f_body_acc_mag.std
* f_body_body_acc_jerk_mag.std
* f_body_body_gyro_mag.std
* f_body_body_gyro_jerk_mag.std
