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

  signal_data[[1]] <- signal_data[[1]] + (.001 * 198000) # No signal movement occurs before 198s.  Render data progression to begin immediately

  return(signal_data)
}

plotting_2d <- function(signal_df_melt, sig_labels) {
#  ggplot(signal_df_melt, aes(x = Time, y = value, colour =  variable)) +
#    geom_line() +
#    geom_area(alpha=0.4, position = 'identity') +
  #  geom_smooth(method = 'loess', se = FALSE) +
#    theme_bw() +
#    theme(legend.position = 'top')#, legend.title = element_text('Signals'))

  #all_plot <- ggplot(signal_df_melt, aes(x = Time, y = value, colour = variable)) +
  #  xlab("Time (s)") +
  #  ylab("Intensity (standardized)") +
  #  geom_line() +
  #  geom_smooth(method = 'loess', se = FALSE, linetype = 'dashed', colour = 'black', size = .7, formula = y ~ x) +
  #  theme_bw() +
  #  theme(legend.position = 'top', legend.title = element_blank())

  full_plot <- ggplot(signal_df_melt, aes(x = Time, y = value, colour = variable)) +
    xlab("Time (s)") +
    ylab("Intensity (standardized)") +
    geom_line() +
    geom_smooth(method = 'loess', se = FALSE, linetype = 'dashed', colour = 'black', size = .7, formula = y ~ x) +
    theme_bw() +
    theme(legend.position = 'top', legend.title = element_blank()) +
    facet_wrap(~variable)

  ggsave("2dplot.pdf")
}

plotting_3d <- function(sig.df.melt_Time, sig.df.melt_variable, sig.df.melt_value, sig_labels, col_palete) {
  # Under-line area fill, perspective orientation, and labelling
  scatter3D(x = as.numeric(as.factor(sig.df.melt_variable)), y = sig.df.melt_Time, z = sig.df.melt_value,
  theta = 55, # Camera orientation
  phi = 22, # Camera orientation
  bty = "g", # Graph background type
  type = "h", # points w/ vertical lines
  xlab = 'Signals', # X label
  ylab = 'Time (s)', # Y label
  zlab = 'Intensity (standardized)', # Z label
  ticktype = "detailed", # Include more information on plot ticks
  pch = 19, # Point style
  cex = 0.1, # Point size
  colvar = as.numeric(as.factor(sig.df.melt_variable)), #
  col = col_palete,
  alpha = 0.02,
  colkey = FALSE)

  # Solid data points forming line, Colour legend
  scatter3D(x = as.numeric(as.factor(sig.df.melt_variable)), y = sig.df.melt_Time, z = sig.df.melt_value,
  pch = 19,
  cex = .05,
  plot = TRUE,
  add = TRUE,
  colkey = list(
    at = 1:length(unique(sig.df.melt_variable)),
    labels = sig_labels,
    side = 3,
    dist = .06,
    shift = -.018),
  type = 'g',
  alpha = .95,
  col = col_palete,
  colvar = as.numeric(as.factor(sig.df.melt_variable)))
}

run_interactive <- function(signal_df_melt) {
  fig <- plot_ly(
    data = signal_df_melt,
    type = 'scatter3d',
    mode = 'h',
    x = ~ variable, # Time
    y = ~ Time, # Signal
    z = ~ value, # Values for each respective column name
    color = ~variable,
    line = list(width = 4)) %>%

    layout(scene = list(
      xaxis = list(title = 'Signals'),
      yaxis = list(title = 'Time (s)'),
      zaxis = list(title = 'Intensity (standardized)')))

  run_dash(fig)


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
