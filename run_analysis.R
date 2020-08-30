# Downloading the dataset
if(!file.exists("./data")){dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile="./data/Dataset.zip")
unzip(zipfile="./data/Dataset.zip",exdir="./data")
#-------------------- PREPARING AND QUESTION 1 ------------------------
# Reading de train and test
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
# reading features vector
features <- read.table('./data/UCI HAR Dataset/features.txt')
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')
#assign collumn names
colnames(x_train) <- features[,2]
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"
colnames(x_test) <- features[,2]
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"
colnames(activityLabels) <- c('activityId','activityType')
#mergin all data in one df
train <- cbind(y_train, subject_train, x_train)
test <- cbind(y_test, subject_test, x_test)
df <- rbind(train, test)
# ----------------------------QUESTION 2 ---------------------------------------
# reading collumn names
col <- colnames(df)
mean_and_std <- (grepl("activityId" , col) | grepl("subjectId" , col) |
                   grepl("mean.." , col) | grepl("std.." , col))
setForMeanAndStd <- df[ , mean_and_std == TRUE]
# ----------------------------QUESTION 3 ---------------------------------------
df <- merge(setForMeanAndStd, activityLabels,
            by='activityId',
            all.x=TRUE)
# ----------------------------QUESTION 4 ALREDY MADED --------------------------

# ----------------------------QUESTION 5 ---------------------------------------
Tydydf <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
Tydydf <- Tydydf[order(Tydydf$subjectId, Tydydf$activityId),]
write.table(Tydydf, "Tydydf.txt", row.name=FALSE)
Tydydf <- aggregate(. ~subjectId + activityId, df, mean)
Tydydf <- Tydydf[order(Tydydf$subjectId, Tydydf$activityId),]
write.table(Tydydf, "Tydydf.txt", row.name=FALSE)
