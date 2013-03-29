



enroll_progress_plot <- function(to1data, 
                                 target = 500,
                                 enroll_start = as.Date("2012-11-01"),
                                 enroll_end = as.Date("2013-09-01")) {

    # Validate arguments



    require(plyr)
    require(ggplot2)


    # Get the questionnaire data
    enrolldat <- to1data$master


    # Compute weekly enrollment targets
    enrolldat$week <- format(enrolldat$enroll_date, "%Y-%U")


    # Calculate the required enrollment to meet the target
    enroll_targets <- data.frame(
        week = as.character(format(seq(from = enroll_start,
                                       to = enroll_end,
                                       by = "week"),
                                   "%Y-%U")),
        metric = "Target"
    )

    weekly_target <- target / length(enroll_targets$week)

    enroll_targets$n_enrolled <- seq(from = weekly_target, 
                                     length.out = length(enroll_targets$week),
                                     by = weekly_target)




    # Compute actual weekly enrollment
    # Limit to enrollment during the indicated period
    period_enrollment <- subset(enrolldat, week %in% enroll_targets$week)

    enroll_actual <- ddply(period_enrollment,
                           .var = "week", 
                           .fun = summarise,
                           n = sum(StudyId != "", na.rm = TRUE)
    )

    enroll_actual$n_enrolled <- cumsum(enroll_actual$n)

    enroll_actual$metric <- "Actual"


    # Combine the actual and target counts
    enroll_plot <- rbind(enroll_targets,
                         enroll_actual[ , c("week", "n_enrolled", "metric")]
    )


    ggplot(enroll_plot, aes(x = week, group = metric)) +
        geom_line(aes(y = n_enrolled, color = metric), size = 1) +
        geom_point(aes(y = n_enrolled, color = metric), size = 3) +
        scale_color_manual("Metric", values = c("#1F78B4", "#E41A1C")) +
        labs(title = "TBESC2 TO1 Enrollment Progress",
             x = "Week",
             y = "Cumulative Enrollment") +
        theme(axis.text.x = element_text(angle = 290, vjust = .5))



}
