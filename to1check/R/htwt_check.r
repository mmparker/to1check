


# This function compares height and weight for patients and reports out
# those with unusual results.
# Output is a list of objects:
#  - a plot of height vs weight with potential
#  - a data.frame of outliers
#  - a data.frame of participants with missing height or weight



htwt_check <- function(cleanlist) {


    # Extract the height and weight data
    htwt <- subset(cleanlist$medicalhistory,
                   select = c("StudyId", "HeightInch", "WeightPound"))

    # Calculate the distance matrix of all the points
    distmat <- as.matrix(dist(htwt[ , c("HeightInch", "WeightPound")]))

    # Identify the minimum distance from each point to its nearest neighbor
    htwt$mindist <- apply(distmat, 1, function(x) {
                          min(x[x > 0], na.rm = TRUE)
                   }
    )

    # When min gets all NAs as input, it returns Inf - but that will screw up
    # the quantile calculation below, so I'm converting it to NA
    htwt$mindist[htwt$mindist == Inf] <- NA



    # Set up a label variable that is NA except for the participants with the
    # most-distant points
    htwt$label <- htwt$StudyId

    # Less than the 98th percentile?  No label.
    htwt$label[htwt$mindist < quantile(htwt$mindist, .99, na.rm = TRUE)] <- NA

    # No calculated distance?  No label.
    htwt$label[is.na(htwt$mindist)] <- NA


    # Set up the output list
    output <- list()



    # Create the plot
    output$plot <- ggplot(htwt, aes(x = HeightInch, y = WeightPound)) +
                       geom_point(color = "#43A2CA") +
                       geom_text(aes(label = label), size = 4, hjust = -0.05) +
                       labs(x = "Height (inches)", y = "Weight (pounds)") +
                       scale_x_continuous(expand = c(.2, 1)) +
                       scale_y_continuous(expand = c(.2, 1))


    # Create the table of outliers
    output$outlierdf <- subset(htwt, 
                               subset = !is.na(label),
                               select = c("StudyId", "HeightInch", 
                                          "WeightPound")
    )


    # Create the table of participants with missing height or weight
    output$missingdf <- subset(htwt,
                               subset = is.na(HeightInch) | is.na(WeightPound),
                               select = c("StudyId", "HeightInch", 
                                          "WeightPound")
     )



    # Return the output list
    output

}
