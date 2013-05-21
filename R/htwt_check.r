
#' Check for data entry errors in participant heights and weights.
#' 
#' This function generates a list containing a plot of particpant heights vs.
#' weights; a data.frame of the most extreme height/weight observations;
#' and a data.frame of participants missing height and/or weight.
#' 
#' This function generates a list with three elements: 
#' \enumerate{
#'   \item A plot (using ggplot2) of participant heights vs. 
#'         weights, with the most extreme observations labeled with study IDs.
#'   \item A table of the most extreme observations.
#'   \item A table of participants missing either height or weight
#' }
#' 
#' "Most extreme" is crudely defined as those points that are the furthest
#' from their nearest neighbor. This isn't intended as formal outlier detection;
#' it's just a quick way to label outlying points.
#' 
#' 
#' @return
#' A list containing three elements: \code{plot}, \code{outlierdf}, and
#' \code{missingdf}, each corresponding to the elements listed above.
#' 
#' @param cleanlist The list of cleaned TO1 data generated by 
#'   \code{\link{clean_to1}}
#' 
#' @export



# This function compares height and weight for patients and reports out
# those with unusual results.
# Output is a list of objects:
#  - a plot of height vs weight with potential
#  - a data.frame of outliers
#  - a data.frame of participants with missing height or weight



htwt_check <- function(cleanlist) {
    
    # Ensure that these variables are defined within the function's environment
    HeightInch <- WeightPound <- NULL

    require(ggplot2)

    # Extract the height and weight data
    htwt <- cleanlist$medicalhistory[ , c("StudyId", 
                                          "HeightInch", "HeightInchIdk",
                                          "WeightPound", "WeightPoundIdk")]

    # Calculate the distance matrix of all the points
    # Normalized ht/wt? Mahalanobis? Maybe later.
    distmat <- as.matrix(dist(htwt[ , c("HeightInch", "WeightPound")]))

    # Identify the minimum distance from each point to its nearest neighbor
    htwt$mindist <- apply(distmat, 1, function(x) {
                          min(x[x > 0], na.rm = TRUE)
                   }
    )

    # When min gets all NAs as input, it returns Inf - but that will screw up
    # the quantile calculation below, so I'm converting it to NA
    htwt$mindist[htwt$mindist == Inf] <- NA


    # Reorder the data by descending mindist
    htwt <- htwt[order(htwt$mindist, decreasing = TRUE), ]


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
    output$outlierdf <- htwt[!is.na(htwt$label),
                             c("StudyId", "HeightInch", "WeightPound")]

    # Create the table of participants with missing height or weight
    # To be truly missing, both the measure and its "I Don't Know" indicator
    # need to be NA
    htwt$heightmissing <- is.na(htwt$HeightInch) & is.na(htwt$HeightInchIdk)

    htwt$weightmissing <- is.na(htwt$WeightPound) & is.na(htwt$WeightPoundIdk)


    output$missingdf <- htwt[(htwt$heightmissing | htwt$weightmissing),
                             c("StudyId", "HeightInch", "WeightPound")]



    # Return the output list
    output

}
