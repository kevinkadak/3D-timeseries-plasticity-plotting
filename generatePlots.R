#generatePlots.R
#Kevin Kadak (1007522888)

source('plottingTools.R') # Source functions from <

args <- commandArgs(trailingOnly = TRUE) # Variable containing arguments passed from command line
check_args(args) # Ensure no unacceptable arguments are passed

signal_df <- load_data(args[1]) # Assign data frame to variable
chosenOp <- args[2]

library('reshape2') # For reshapping data frame
library('ggplot2') # For mainly 2D plotting
library('plot3D') # For plotting 3D plot

col_palete <- c('#4b2991', '#c0369d', '#47bd97', '#83d75d', '#ffb224') # Colour palette to be passedpassed to 3D plot
sig_labels <- c('Coupling Strength', 'Target CS', 'ICC', 'Glutamate Change', 'NMDA Gain') # Items stand for the following:
# Coupling strength = the strength of the connection between two neurons at the synaptic cleft
# Target coupling strength = same as above, but as a prediction of coupling strength change in the absence of noise
# Intraceullular calcium concentration = the amount of calcium saturating neurons, affecting plasticity
# Glutamte change = Gluatemate changes in response to (no change in this case)
# NMDA receptor gain = Measured change in number of NMDA receptors opening, a prelimiary factor of long-term neuronal change (plasticity)

signal_df[2:length(signal_df)] <- scale(signal_df[2:length(signal_df)]) # Scale all columns excluding Time
signal_df[is.na(signal_df)] <- 0 # Any instances where values did change and were thus rendered as NaN due to inability to scale() = 0

signal_df_melt <- melt(signal_df, id.vars = c("Time")) # Convert the dataframe into a 3-column str for xyz plotting
levels(signal_df_melt[["variable"]]) <- sig_labels # Convert short-form signal names into proper names for plotting

sig.df.melt_Time <- signal_df_melt[["Time"]] # X variable, time
sig.df.melt_variable <- signal_df_melt[["variable"]] # Y variable, each unique group (found in sig_labels)
sig.df.melt_value <- signal_df_melt[["value"]] # Z variable, time-series values associated with each signal


#----------2D Plot----------#
# My 2D plot depicts each individual signal in its own subplot, fitted with a LOESS curve to show the
# overall trend and directionality of each signal's movement.  Plotting was performed with ggplot2, specifically
# by partitioning the entire dataframe into its respective 'variable' groups and graphing each, respectively.

if (chosenOp == '2D') {
  cat("\n-----------------------------------")
  cat("\nPerforming", chosenOp, "render")
  cat("\n-----------------------------------\n")
  plotting_2d(signal_df_melt, sig_labels) # Perform ggplot2 2D render
}

#----------3D Plot----------#
# My 3D plot depicts time-series signals, each measuring a different component associated with synaptic plasticity, in 3D space.
# Scatter3D provided an invaluable set of tools to modify the nature of the plotted points, as well as the perspective at which
# the plot is 'viewed'.  Filling the area under each line curve, which is currently not an natively-available feature for ggplot2, plotly, or
# even scatter3D was performed by inserting 2 seperate points plots.  The first point plot was a vertical-line plot with small point 'heads', generating a
# concurrent wall of lines.  The second point plot was of normal, larger, more opaque points, located in the same positions, but englufing the 'heads' of
# the first-placed points.  This helped the render to have cleaner, distinct lines while retaining the visually-pleasing signal comparisson render.

if (chosenOp == '3D') {
  cat("\n-----------------------------------")
  cat("\nPerforming", chosenOp, "render")
  cat("\n-----------------------------------\n")
  plotting_3d( # Perform scatter3D render
    sig.df.melt_Time,
    sig.df.melt_variable,
    sig.df.melt_value,
    sig_labels,
    col_palete)
}
