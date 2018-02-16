#' Fars Data Import
#'
#' This simple function serves as a basic check and data import for the
#' several other functions provided in this package
#'
#' @param filename this parameter takes the expected name of the file
#' that contains Fatality Analysis Reporting System data
#'
#' @return This function return a data frame using dplyr package's
#' tbl_df function and readr package's read_csv function
#'
#' @details this function requires you to unzip the fars_data file in
#' order to reach the .bz2 data files that is contained inside for
#' each individual year. Working directory needs to contain the files
#' that are included in data folder of fars_data .zip file
#' @export
#' @importFrom readr read_csv
#' @importFrom dplyr tbl_data
#' @examples
#' \dontrun{
#' fars_data(accident_2014.csv.bz2)
#'}
fars_read <- function(filename) {
  if(!file.exists(filename))
    stop("file '", filename, "' does not exist")
  data <- suppressMessages({
    readr::read_csv(filename, progress = FALSE)
  })
  dplyr::tbl_df(data)
}
