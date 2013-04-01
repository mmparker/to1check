


calc_fu <- function(x) {

    require(lubridate)

    # Test that x is a Date (or can be coerced)

    # Set up the results
    fu.dates <- data.frame(enroll.date = x,
                           start6 = x + months(6) - days(14),
                           end6 = x + months(6) + days(30),
                           start12 = x + months(12) - days(14),
                           end12 = x + months(12) + days(30),
                           start18 = x + months(18) - days(14),
                           end18 = x + months(18) + days(30),
                           start24 = x + months(24) - days(14),
                           end24 = x + months(24) + days(30))

    fu.dates

}
