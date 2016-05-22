library(dplyr)

#Read in files
activity_labels <- read.table("./getdata-projectfiles-UCI HAR Dataset/activity_labels.txt")
features <- read.table("./getdata-projectfiles-UCI HAR Dataset/features.txt")

x_train <- read.table("./getdata-projectfiles-UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./getdata-projectfiles-UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./getdata-projectfiles-UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("./getdata-projectfiles-UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./getdata-projectfiles-UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./getdata-projectfiles-UCI HAR Dataset/test/subject_test.txt")

#Assign column names
colnames(x_train) <- features[,2]
colnames(y_train) <- "activityid"
colnames(subject_train) <- "subjectid"

colnames(x_test) <- features[,2]
colnames(y_test) <- "activityid"
colnames(subject_test) <- "subjectid"

colnames(activity_labels) <- c("activityid", "activity")

#Merge data sets
merged_train <- cbind(y_train, subject_train, x_train)
merged_test <- cbind(y_test, subject_test, x_test)
allmerged <- rbind(merged_train, merged_test, all=TRUE)

#Extract only the measurements on the mean and standard deviation for 
##each measurement.
allmerged_meanstd  <- allmerged[grepl("activityid|subjectid|*mean\\()|*std\\()", 
                                      names(allmerged))]

#Use descriptive activity names to name the activities in the data set
descnames <- merge(activity_labels, allmerged_meanstd, by = 'activityid', 
                   all.x = TRUE)
invisible(as.factor(descnames$activity))

#Appropriately label the data set with descriptive variable names.
names(descnames) <- gsub("^t", "time", names(descnames))
names(descnames) <- gsub("^f", "frequency", names(descnames))
names(descnames)<-gsub("Acc", "Accelerometer", names(descnames))
names(descnames)<-gsub("Gyro", "Gyroscope", names(descnames))
names(descnames)<-gsub("Mag", "Magnitude", names(descnames))
names(descnames)<-gsub("BodyBody", "Body", names(descnames))
names(descnames) <- gsub("\\()", "", names(descnames))
names(descnames) <- gsub("-", "", names(descnames))

       
#From the data set in step 4, create a second, independent tidy data set with 
        #the average of each variable for each activity and each subject
tidydata <- descnames %>% group_by(activity) %>% summarise_each(funs(mean))
write.table(format(tidydata, scientific = TRUE), file = "tidydata.txt", 
            row.name=FALSE)
