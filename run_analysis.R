#make sure the dplyr library is loaded
library(dplyr)

################################################################################
#
# This is just a wrapper for the two functions that actually do the work.  It
# wasn't strictly neccessary to break them up as I did (steps 1-4 in one
# function and step 5 in the other), but it made it easier to track the two in
# my head.
#
################################################################################
run_analysis <- function() {

    # this takes in the data and creates the initial table
    tdata <- buildTable(getwd())

    # creates the table with the averages
    calcAverages(tdata)
}

# This simple function is for the mutate call in buildTable.
#   x: Index of the activity
#   acts: Arrary of the activity names
convertAct <- function(x, acts) { acts[x] }

# This function creates the dataset to meet steps 1-4.
# The parameter is the top directory with the data to work on
buildTable <- function(wd) {


    # Activity name lookup
    acts <- c("Walking", "Going Up Stairs", "Going Down Stairs", "Seated", "Standing", "Laying Down")
    #   1 WALKING               Walking
    #   2 WALKING_UPSTAIRS      Going Up Stairs
    #   3 WALKING_DOWNSTAIRS    Going Down Stairs
    #   4 SITTING               Seated
    #   5 STANDING              Standing
    #   6 LAYING                Laying Down

    # get to the directory tree where the data starts
    setwd(wd)

    # create the subject column as the final DF (RETurn Data Frame)
    #   subTrain <- read.table("train/subject_train.txt")
    #   subTest <- read.table("test/subject_test.txt")
    # I was using the two above to load the data into 2 variables, but that's a
    # doubling of the memory footprint.  Unless R interpreter works in a very
    # unexpected manner, this is more memory efficient.
    retDF <- rbind(
        read.table("test/subject_test.txt"),
        read.table("train/subject_train.txt")
    )

    # re-name the column before doing anything else
    names(retDF) <- "Volunteer"

    # load the activity column
    y <- rbind(
        read.table("test/y_test.txt"),
        read.table("train/y_train.txt")
    )

    # create a new column with the descriptive name of the activity
    y <- mutate(y, Activity = convertAct(y$V1, acts))

    # add that the final DF
    retDF <- cbind(retDF, Activity = y$Activity)

    # read the X data in
    xfull <- rbind(
        read.table("test/X_test.txt"),
        read.table("train/X_train.txt")
    )

    # read the features file and use that to re-name the variables
    # this is fire and forget because we don't need it again
    names(xfull) <- read.table("features.txt")$V2

    # subset xfull into xsub via the variable names
    xsub <- xfull[ ,grep('std\\(|mean\\(', names(xfull))]

    # add that the final DF
    retDF <- cbind(retDF, xsub)

    # dump the results to a file
    write.table(retDF, file = "FullResults.txt")

    # return the results in case something needs them later
    retDF
}

# This function does the grouping and calculation needed to fullfill step 5.
#
calcAverages <- function(tdata) {
    # init the data frame of mean values to return
    #meanDF <- structure(names(tdata), class = "data.frame")
    meanDF <- tdata[1,]
    meanDF <- meanDF[c(FALSE),]

    # double loops - for each volunteer process each activity
    for(vol in unique(tdata$Volunteer)) {
        for(act in unique(tdata$Activity)) {

            # get the rows with the data for this volunteer and activity
            drows <- tdata[(tdata$Volunteer == vol & tdata$Activity == act), ]

            # perform the mean operation on each column after the volunteer id and activity
            mvals <- lapply(drows[3:dim(drows)[2]], mean)

            # now add that to the return data frame
            meanDF[nrow(meanDF) +1, ] <- c(Volunteer = vol, Activity = act, mvals)
        }
    }

    # write the results to a file
    write.table(meanDF, file = "AverageResults.txt")

    # return the data
    meanDF
}

