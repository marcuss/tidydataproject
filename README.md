# tidydataproject

The run_analysis.R script runs smoothly if the Samsung dataset is decompressed in the working directory, keeping it's original folder structure, this is all the data and other directories are under the parent directory: "UCI HAR Dataset"

The script has full comments that explain each step of the process, these comments will be duplicated here for simplicity.

The script steps are the following.

##1. Read the column names, and tidy them up. ##Review Point 4.

##2. Read activity names.

##3. Read Test dataset.

##4. Read activities for Test dataset.

##5. Read subjects for test dataset.

##6. Bind activity and subject columns to Test dataset

##7. Read Train dataset.

##8. Read activities for Train dataset.

##9. Read subjects for Train dataset.

##10. Bind activity and subject columns to Train dataset  #Review Point 1.

##11. Merge the two datasets together

##12. Cast activities to a factor variable #Review Point 3.

##11. Select only std and mean variables. #Review point 2.

##12. Create new dataset with avg per subject per activity

##13. write the final dataset text file.
