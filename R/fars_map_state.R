
#' FARS State Accident Plotter
#'
#' This function  plots the accidents of a given year and state to the
#' state's map. It uses fars_read and make_filename functions included
#' in this package. It also imports numerous functions from dplyr, maps
#' and graphics packages for its' function
#'
#' @param state.num The state's number as an integer
#' @param year The desired year in YYYY format as an integer
#'
#' @return Function returns a map of the given state with accident
#' reports that have valid longitude and latitute points plotted on the
#' map.
#'
#' @details This function requires a valid state number and  a year that
#' is included in FARS dataset to operate. The working directory needs to
#' include .csv.bz2 files included in the data folder of fars_data.zip
#' file.
#'
#' @export
#' @importFrom dplyr filter
#' @importFrom maps map
#' @importFrom graphics points
#'
#' @examples
#'\dontrun{
#' fars_map_state(25,2014)
#' fars_map_state(1,2015)
#' fars_map_state(6,2013)
#' }
fars_map_state <- function(state.num, year) {
  filename <- make_filename(year)
  data <- fars_read(filename)
  state.num <- as.integer(state.num)

  if(!(state.num %in% unique(data$STATE)))
    stop("invalid STATE number: ", state.num)
  data.sub <- dplyr::filter(data, STATE == state.num)
  if(nrow(data.sub) == 0L) {
    message("no accidents to plot")
    return(invisible(NULL))
  }
  is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
  is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
  with(data.sub, {
    maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
              xlim = range(LONGITUD, na.rm = TRUE))
    graphics::points(LONGITUD, LATITUDE, pch = 46)
  })
}
