# Getting and Cleaning Data Project

## Reading in the AverageResults.txt file

**Failure to load the file in using the arguments specified below will result in incorrect characters in the variable names of the data frame.**

To read in the AverageResults.txt file use the following line of code.  This assumes your working directory is the same one the file is in.  Replace the "AverateResults.txt" argument with the full path to the file if this is not the case.
> averages <- read.table("AverageResults.txt", header = TRUE, check.names = FALSE)

## Script Design
There are 4 functions in the run_analysis.R file.

1. run_analysis
2. convertAct
3. buildTable
4. calcAverages

### run_analysis()
The main function is run_analysis.  This uses two calls to do it's job.  First it calls buildTable to get all the data cleaned and gathered into one data frame.  Then it calls calcAverages to get the table consisting of an average per (subject, activity) pair.  It will return this data frame.  After execution there will be two new files in the working directory, FullResults.txt and AverageResults.txt.

**Note**: In the call to buildTable, run_analysis passes the output of getwd() as the argument.  If the data is not in the same directory as the script then this parameter will need a new value.

### convertAct(x, acts) 
The convertAct function is just a simple wrapper for use in the mutate call inside buildTable.  It's use is to translate the activity number into a readable value.  It relies on the act list passed in being the full list of activities.

### buildTable(wd)
The buildTable function pulls in all the scattered data from the different files then pulls it together into one data frame with just the Standard Deviation and Mean features.  The basic process is to call rbind() with the output of read.table() on the test data set as teh first argument and the output of read.table() on the train dataset as the second argument.  (This was done to eliminate the  need for a pair of variables which would just be combined into one.  I was having some issues with memory on my computer, and this was an attempt to alleviate them.)  The files were opened in pairs, with both subject files opened first.  Then any necessary processing was done on the data before using cbind() to attach that data to the results data frame.  The following code snippet shows this on the Y data.

    # load the activity column
    y <- rbind(
        read.table("test/y_test.txt"),
        read.table("train/y_train.txt")
    )

    # create a new column with the descriptive name of the activity
    y <- mutate(y, Activity = convertAct(y$V1, acts))

    # add that the final DF
    retDF <- cbind(retDF, Activity = y$Activity)


### calcAverages(tdata)
The calcAverages function loops through two lists of unique values from the first two columns of the data frame passed in.  The outer loop goes over the Volunteers while the inner loop goes over the Activities.  Inside the inner loop a subset of the input data frame is taken based on these two items.  The features are extracted from the later columns, and lapply is used to apply the mean function to each of these.  Finally a row is added to new data frame with this data prefixed by the volunteer id and activity.

## Variable Naming

While I spent some time trying to decipher the full meaning of the feature names (and did come to understand them - see the codebook for details), I eventually decided the better option was to leave them unchanged.  None of the values are raw data.  Rather they are the result of passing the raw data through a filtering function and then normalizing the output.  While needed, this adds a larger layer of complexity which has been captured by the name given by the original team.  Without the domain knowledge they possess, any attempts to change the name run the risk of losing the processing information contained within.
