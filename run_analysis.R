library(base)
library(utils)
library(data.table)
require(downloader)

# downloading the Data
download.data <- function () {
  zip.url <- 'http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
  zip.file <- 'dataset.zip'
  download(zip.url, destfile=zip.file, mode = "wb")
  #download.file(zip.url, destfile = zip.file, method = 'curl')
  unzip(zip.file)
}

# The function loads and processes either a train or a test data set,

load.dataset <- function (set, features, labels) {
  # Construct the relative pathes of data files
  prefix <- paste(set, '/', sep = '')
  file.data <- paste(prefix, 'X_', set, '.txt', sep = '')
  file.label <- paste(prefix, 'y_', set, '.txt', sep = '')
  file.subject <- paste(prefix, 'subject_', set, '.txt', sep = '')
  # We read the data into a data.frame and then transform it into data.table
  data <- read.table(file.data)[, features$index]
  names(data) <- features$name
  label.set <- read.table(file.label)[, 1]
  data$label <- factor(label.set, levels=labels$level, labels=labels$label)
  subject.set <- read.table(file.subject)[, 1]
  data$subject <- factor(subject.set)
  # convert to data table
  data.table(data)
}
run.analysis <- function () {
  setwd('UCI HAR Dataset/')
  # Get the features
  feature.set <- read.table('features.txt', col.names = c('index', 'name'))
  features <- subset(feature.set, grepl('-(mean|std)[(]', feature.set$name))
  # Get the labels
  label.set <- read.table('activity_labels.txt', col.names = c('level', 'label'))
  # Read train and test data sets
  train.set <- load.dataset('train', features, label.set)
  test.set <- load.dataset('test', features, label.set)
  # The raw data set
  dataset <- rbind(train.set, test.set)
  # Generate the clean data set
  clean.dataset <- dataset[, lapply(.SD, mean), by=list(label, subject)]
  # Fix the variable names
  names <- names(clean.dataset)
  names <- gsub('-mean', 'Mean', names) 
  names <- gsub('-std', 'Std', names) 
  names <- gsub('[()-]', '', names) 
  names <- gsub('BodyBody', 'Body', names) 
  setnames(clean.dataset, names)
  # Write the raw and the clean data sets to files
  setwd('..')
  write.table(dataset, file = 'rawdata.txt', row.names = FALSE)
  write.table(clean.dataset, file = 'cleandata.txt',
            row.names = FALSE)
  # Return the clean data set
  clean.dataset
}

