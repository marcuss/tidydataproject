library(tidyr)
library(dplyr)
library(lubridate)
library(stringr)

getwd()
##1. Read the column names, and tidy them up. ##Review Point 4.
read.delim("UCI\ HAR\ Dataset/features.txt", header = FALSE, 
           stringsAsFactors = FALSE, sep = " ")->x_column_names
rm(x_column_names)
tidy_names <- tolower(x_column_names[,2])
tidy_names <- make.names(tidy_names)
tidy_names <- gsub("\\.\\.","\\.", tidy_names)
tidy_names <- gsub("\\.\\.","\\.", tidy_names) 

#2. Read activity names.
activity_names <- read.delim("UCI\ HAR\ Dataset/activity_labels.txt", header = FALSE, 
                             stringsAsFactors = FALSE, sep = " ")

##3. Read Test dataset.
read.fwf("UCI\ HAR\ Dataset/test/X_test.txt", strip.white=TRUE, 
         widths = rep(16,561), col.names = tidy_names) -> X_test

##4. Read activities for Test dataset.
read.delim("UCI\ HAR\ Dataset/test/Y_test.txt", strip.white=TRUE, header = FALSE, 
           stringsAsFactors = FALSE, sep = " ",col.names = c("activity")) -> Y_test

##5. Read subjects for test dataset.
read.delim("UCI\ HAR\ Dataset/test/subject_test.txt", strip.white=TRUE, header = FALSE, 
           stringsAsFactors = FALSE, sep = " ",col.names = c("subject")) -> subjects_test

##6. Bind activity and subject columns to Test dataset
X_test <- bind_cols(Y_test, subjects_test, X_test)
rm(Y_test, subjects_test)

##7. Read Train dataset.
read.fwf("UCI\ HAR\ Dataset/train/X_train.txt", strip.white=TRUE, 
         widths = rep(16,561), col.names = tidy_names) -> X_train

##8. Read activities for Train dataset.
read.delim("UCI\ HAR\ Dataset/train/Y_train.txt", strip.white=TRUE, header = FALSE, 
           stringsAsFactors = FALSE, sep = " ",col.names = c("activity")) -> Y_train

##9. Read subjects for Train dataset.
read.delim("UCI\ HAR\ Dataset/train/subject_train.txt", strip.white=TRUE, header = FALSE, 
           stringsAsFactors = FALSE, sep = " ",col.names = c("subject")) -> subjects_train

##10. Bind activity and subject columns to Train dataset  #Review Point 1.
X_train <- bind_cols(Y_train, subjects_train, X_train)
rm(subjects_train, Y_train)

##11. Merge the two datasets together
dataset <- bind_rows(X_test, X_train)
rm(X_test, X_train)

##12. Cast activities to a factor variable #Review Point 3.
dataset$activity <- factor(dataset$activity,
                           levels = activity_names$V1,
                           labels = activity_names$V2) 
rm(activity_names)
##13. Select only std and mean variables. #Review point 2.
dataset <- select(dataset, c("activity", "subject", tidy_names[grep(".*mean|.*std", x = tidy_names)])) 
rm(tidy_names)

##14. Create new dataset with avg per subject per activity
avg_dataset <- dataset %>%
               group_by(activity, subject) %>%
               summarise_all("mean")

##15. write the final dataset text file.
write.table(x = avg_dataset, row.name=FALSE, file = "avg_dataset.txt") 

               



