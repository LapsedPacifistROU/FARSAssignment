
#' FARS Data Summarizer
#'
#' This function retreves the data for requested years and summarizes
#' the data in a table for each month.It uses fars_read and make_filename
#' and fars_read_years functions contained in this package. Function also
#' uses dplyr and tidyr packages.
#'
#' @param years this parameter takes a vector of numbers that represent
#' the desired years as an input.
#'
#' @return the function returns a table that provides monthly number of
#' incidents for each year.
#'
#' @details This function expects to get the years as numbers in YYYY
#' format and have the relevant .csv.bz2 files in the working directory.
#' The function sends a warning message for each year file it wasn't
#' able to locate.
#'
#' @export
#' @importFrom dplyr group_by summarize bind_rows
#' @importFrom tidyr spread
#'
#' @examples
#' \dontrun{
#' fars_summarize_years (c(2013,2015))
#' fars_summarize_years (c(2014,2015))}
fars_summarize_years <- function(years) {
  dat_list <- fars_read_years(years)
  dplyr::bind_rows(dat_list) %>%
    dplyr::group_by(year, MONTH) %>%
    dplyr::summarize(n = n()) %>%
    tidyr::spread(year, n)
}
