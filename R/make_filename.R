
#' Expected Filename Creator
#'
#' This function takes a number as an input and creates the predicted
#' filename for the data file that should contain the corresponding
#' year's Fatality Analysis Reporting System data
#'
#' @param year this parameter takes a number as integer and in order
#' to create that year's expected filename
#'
#' @return Function returns a string that should be same as the name
#' of the desired datafile
#'
#' @details Function expects to get number of a year in the YYYY format.
#'  Even though it can coerce double numbers to integers and accept
#'  invalid numbers as an input, any number that is not one of the years
#'  FARS data contains  would result in an error. The function also
#'  operates with the asumption that the file names contained in the data
#'  folders are not changed.
#' @export
#' @examples
#' \dontrun{
#' make_filename(2014)
#' make_filename(2015) }
make_filename <- function(year) {
  year <- as.integer(year)
  sprintf("accident_%d.csv.bz2", year)
}
