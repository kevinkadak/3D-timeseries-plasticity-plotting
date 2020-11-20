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

  #signal_df <- signal_df[-1] # Remove time

  #signal_df_melt$variable <- "Signal"
  #signal_df_melt$value <- "Intensity"
  #print(head(signal_df_melt))
  #signal_df_melt <- signal_df_melt[c(2,3,1)]

  return(signal_data)
}
plotting_2d <- function(signal_df) {
  #ggplot(signal_df_melt, aes(x = Time, y = value, color = variable)) +
    #geom_area(aes(fill=variable),alpha=0.4) +
  #  geom_line() +
  #  geom_smooth(method = 'loess', se = FALSE) +
  #  theme_bw() +
  #  theme(legend.position = 'top',
  #        legend.title = element_blank())

  #ggsave("kk1.pdf")


  for (i in signal_df[-1]) {
    ggplot(signal_df, aes(x = Time, y = i, color = i)) +
      geom_line() +
      #geom_area(aes(fill=Coupling.2.gNMDA),alpha=0.4) +
      #geom_smooth(method = 'loess', se = FALSE) +
      theme_bw() +
      theme(legend.position = 'top',
            legend.title = element_blank())
  }


  ggsave("kk2.pdf")
}

plotting_3d <- function(signal_df_melt) {
  #fig <- plot_ly(
  #  data = signal_df_melt,
  #  type = 'scatter3d',
  #  mode = 'h',
  #  x = ~ variable, # Time
  #  y = ~ Time, # Signal
  #  z = ~ value, # Values for each respective column name
  #  color = ~variable,
  #  line = list(width = 4)) %>%

  #  layout(scene = list(
  #    xaxis = list(title = 'Signals'),
  #    yaxis = list(title = 'Time (s)'),
  #    zaxis = list(title = 'Intensity (standardized)')))

  #run_dash(fig)


  #print(as.numeric(as.factor(signal_df_melt$variable)))
  scatter3D(x = as.numeric(as.factor(signal_df_melt$variable)), y = signal_df_melt$Time, z = signal_df_melt$value,
  theta = 55,
  phi = 20,
  bty = "g",
  type = "h",
  xlab = 'Signals',
  ylab = 'Time (s)',
  zlab = 'Intensity (standardized)',
  ticktype = "detailed",
  pch = 19,
  cex = 0.5,
  clab = "Signal Intensity",
  colvar = as.numeric(as.factor(signal_df_melt$variable)),
  col = c('red', 'blue', 'orange', 'green', 'purple'),
  alpha = 0.025,
  colkey = FALSE)

  scatter3D(x = as.numeric(as.factor(signal_df_melt$variable)), y = signal_df_melt$Time, z = signal_df_melt$value,
  pch = 19, cex = 0.25, add = TRUE, colkey = TRUE, type = 'g', alpha = .95, col = c('red', 'blue', 'orange', 'green', 'purple'), colvar = as.numeric(as.factor(signal_df_melt$variable)))
}

run_dash <- function(fig) {
  # Runs dash server at outputted local url
  library(dash)
  library(dashCoreComponents)
  library(dashHtmlComponents)

  app <- Dash$new()
  app$layout(
      htmlDiv(
          list(
              dccGraph(figure=fig)
          )
       )
  )

  app$run_server(debug=TRUE, dev_tools_hot_reload=FALSE)
}
