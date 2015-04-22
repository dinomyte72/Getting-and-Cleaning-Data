#Introduction
The script *run_analysis.R* performs the analysis described in the [course project's definition](https://class.coursera.org/getdata-013/human_grading/view/courses/973500/assessments/3/submissions).

1. We begin by reading in and loading all source data into temporary data sets and naming all columns with descriptive names wherever possible, using *features.txt*.
2. Next, using the `rbind()` function, we bind all test and training datasets into one dataset for X and one dataset for y. A third dataset is created to hold the subjects participating in the test.
3. We continue by retaining only those columns with the mean and standard deviation measures. 
4. We then, using `cbind()`, bind all datasets to create a complete dataset containing observations, subjects and activities.
5. We then replace the activity ID with the correct activity name from *activity_labels.txt* and they are substituted in the dataset.
6. Finally, we generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is uploaded to this repository.

#Variables
* **trainx**, **trainy**, **testx**, **testy**, **trainsubject** and **testsubject** contain the data from the downloaded files.
* **xdata**, **ydata** and **subjdata** merge the previous datasets to further analysis.
* **feat** contains the correct names for the xdata dataset, which are applie to the column names stored in **meanstdfeat**, a numeric vector used to extract the desired data. A similar approach is taken with activity names through the **act** variable.
* **bounddata** merges xdata, ydata and subjdata in a complete dataset.
* Finally, **avgdata** contains the relevant averages which will be later stored in the *averages_data.txt* file. `ddply()` from the plyr package is used to apply `colMeans()` to obtain the required statistical values.