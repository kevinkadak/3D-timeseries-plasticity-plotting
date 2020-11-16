#plottingTools.R
#Kevin Kadak (1007522888)

check_args <- function(args) {
  if (length(args) != 2) { # If no arguments have been passed, stop and output
    stop("Script requires exactly 2 arguments: file name and plot type ('2D', '3D').")
  } else if (file.exists(args[1]) != TRUE) { # If the passed file does not exist in the current directory, stop and output
    stop("File not found in current directory.")
  } else if (args[2] != '2D' && args[2] != '3D') { # If neither of the 2nd arugments are plot/noplot, stop and output
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
  signal_columns <- signal_columns[-1] # Remove the index name from the column names

  signal_data <- read.table(arg1_filename, skip = 72, col.names = signal_columns) # Render a data table from the raw data
  signal_data <- as.data.frame.matrix(signal_data) # Convert data table into a data frame

  signal_data.names <- names(x)	# get the column names

  #x[x.names[1]]	# 1st column
  #x[x.names[1]][[1]]

  return(signal_data)
}


#x <- table(rpois(100, 5))

#x.names <- names(x)	# get the column names

#x[x.names[1]]	# 1st column
#x[x.names[1]][[1]]	# only value for first column
