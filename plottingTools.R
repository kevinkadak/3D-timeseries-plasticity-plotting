#plottingTools.R
#Kevin Kadak (1007522888)

check_args <- function(args) {
  if (length(args) != 2) { # If no arguments have been passed, stop and output
    stop("Script requires exactly 2 arguments: file name and plot type ('2D', '3D').")
  } else if (file.exists(args[1]) != TRUE) { # If the passed file does not exist in the current directory, stop and output
    stop("File not found in current directory.")
  } else if (args[2] %in% c('2D', '3D') == FALSE) { # If the 2nd cmdline arg is not in the vector, stop and output
      stop("2nd argument must be '2D' or '3D'.")
  }
}

# Process and load file
load_data <- function(arg1_filename) {
  cat("\n-----------------------------------")
  cat("\nLoading file:", arg1_filename) # Output file being processed
  cat("\n-----------------------------------\n")

  # Render the read.csv object into a dataframe, ensuring NA values are excluded
  signal_columns <- read.table(arg1_filename, nrows = 1, skip = 70) # Grab column names from file
  signal_data <- read.table(arg1_filename, skip = 72, col.names = signal_columns) # Render a data table from raw data, w/ signal_columns as respective titles
  signal_data <- as.data.frame.matrix(signal_data) # Convert data table into a data frame

  signal_data[[1]] <- signal_data[[1]] + (.001 * 198000) # Time addition to account for removal of empty signal movement

  return(signal_data)
}
