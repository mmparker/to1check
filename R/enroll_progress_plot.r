
#' Generate a plot of enrollment progress and targets throughout a given period.
#' 
#' This function generates a plot (using ggplot2) of cumulative enrollment
#' progress and enrollment targets throughout the given period.
#' The plot currently aggregates by week only.
#' 
#' 
#' @return
#' A ggplot2 plot.
#' 
#' @param enroll_dates A Date vector of enrollment dates
#' @param target The total enrollment target for the period
#' @param enroll_start The start Date of the enrollment period
#' @param enroll_end The end Date of the enrollment period
#' 
#' @export

enroll_progress_plot <- function(enroll_dates, 
                                 target,
                                 enroll_start,
                                 enroll_end) {

    # Ensure that these variables are defined within the function's environment
    metric <- n_total <- NULL

    # Validate arguments


    require(ggplot2)
    require(scales)

    # Convert enrollment dates to weekly indicators
    enroll_weeks <- format(enroll_dates, "%Y-%U")


    # Calculate the required enrollment to meet the target
    enroll_targets <- data.frame(week = seq(from = enroll_start,
                                            to = enroll_end,
                                            by = "week"),
                                 metric = "Target"
    )

    weekly_target <- target / length(enroll_targets$week)

    enroll_targets$n <- weekly_target

    enroll_targets$n_total <- seq(from = enroll_targets$n[1],
                                  length.out = length(enroll_targets$week),
                                  by = weekly_target)




    # Compute actual weekly enrollment
    # Limit to enrollment during the indicated period
    period_enrolls <- enroll_dates[enroll_dates >= enroll_start & 
                                   enroll_dates <= enroll_end]

    # Get counts using the same weeks as in the targets
    # But subset to only those bins that will include the current enrollment -
    # otherwise, the actual enrollment line plateaus out to the end of the 
    # period instead of stopping at the current enrollment period
    current_bins <- enroll_targets$week[enroll_targets$week < 
                                        max(period_enrolls) + 7]


    enroll_hist <- hist(x = period_enrolls,
                        breaks = current_bins,
                        right = FALSE,
                        plot = FALSE)


    # Use the histogram results to set up a data.frame like enroll_targets'
    enroll_actual <- data.frame(week = current_bins,
                                n = c(enroll_hist$counts, NA),
                                metric = "Actual"
    )

    enroll_actual$n_total <- cumsum(enroll_actual$n)



    # Combine the actual and target counts
    enroll_plot <- rbind(enroll_targets, enroll_actual)


    ggplot(enroll_plot, aes(x = week, group = metric)) +
        geom_line(aes(y = n_total, color = metric), size = 1) +
        geom_point(aes(y = n_total, color = metric), size = 3) +

        scale_x_date(labels = date_format("%b %Y"),
                     breaks = date_breaks("months"),
                     minor_breaks = date_breaks("weeks")) +

        scale_color_manual("Metric", values = c("#1F78B4", "#E41A1C")) +

        labs(title = "TBESC2 TO1 Enrollment Progress",
             x = "Month",
             y = "Cumulative Enrollment") +

        theme(axis.text.x = element_text(angle = 290, vjust = .5))



}
