
#' FARS Data Reader
#'
#' This function retrieves the reported incidents from requested data
#' files and creates a table that provides month and year information
#' the incident has occured. It also uses fars_read and make_filename
#' functions contained in this package, and imports dplyr package.
#'
#' @param years this parameter takes a vector of numbers that represent
#' the desired years as an input.
#'
#' @return the function returns a table that provides month and year of
#' each reported incident.
#'
#' @details This function expects to get the years as numbers in YYYY
#' format and have the relevant .csv.bz2 files in the working directory.
#' The function sends a warning message for each year file it wasn't
#' able to locate.
#' @export
#' @importFrom dplyr mutate select
#' @examples
#' \dontrun{
#' fars_read_years (c(2013,2015))
#' fars_read_years (c(2014,2015)) }
fars_read_years <- function(years) {
  lapply(years, function(year) {
    file <- make_filename(year)
    tryCatch({
      dat <- fars_read(file)
      dplyr::mutate(dat, year = year) %>%
        dplyr::select(MONTH, year)
    }, error = function(e) {
      warning("invalid year: ", year)
      return(NULL)
    })
  })
}
