#generatePlots.R
#Kevin Kadak (1007522888)

source('plottingTools.R') # Source functions from <

args <- commandArgs(trailingOnly = TRUE) # Variable containing arguments passed from command line
check_args(args) # Ensure no unacceptable arguments are passed

library('reshape2') # For reshapping data frame
library('ggplot2') # For mainly 2D plotting
#library('plotly') #
#library("rgl")
library('plot3D') # For plotting 3D plot

#col_palete <- c('#4b2991', '#c0369d', '#ea4f88', '#fa7876', '#f6a97a')
#col_palete <- c('#4b2991', '#4cc8a3', '#ea4f88', '#d1afe8', '#f6a97a')
col_palete <- c('#4b2991', '#c0369d', '#ff6362', '#dc395a', '#ffa602')
sig_labels <- c('Coupling Strength', 'Target CS', 'ICC', 'Glutamate Change', 'NMDA Gain') # Items stand for the following:
# Coupling strength = the strength of the connection between two neurons at the synaptic cleft
# Target coupling strength = same as above, but as a prediction of coupling strength change in the absence of noise
# Intraceullular calcium concentration = the amount of calcium saturating neurons, affecting plasticity
# Glutamte change = Gluatemate changes in response to (no change in this case)
# NMDA receptor gain = Measured change in number of NMDA receptors opening, a prelimiary factor of long-term neuronal change (plasticity)


signal_df <- load_data(args[1]) # Assign data frame to variable
chosenOp <- args[2]

#signal_df.time <- signal_df[["Time"]]
#signal_df.names <- names(signal_df[-1]) # All column names, excluding Time

signal_df[2:length(signal_df)] <- scale(signal_df[2:length(signal_df)]) # Scale all columns excluding Time
signal_df[is.na(signal_df)] <- 0 # Any instances where values did change and were thus rendered as NaN due to inability to scale() = 0
print(head(signal_df))


signal_df_melt <- melt(signal_df, id.vars = c("Time")) # Convert the dataframe into a 3-column str for xyz plotting
levels(signal_df_melt[["variable"]]) <- sig_labels # Convert short-form signal names into proper names for plotting

sig.df.melt_Time <- signal_df_melt[["Time"]]
sig.df.melt_variable <- signal_df_melt[["variable"]]
sig.df.melt_value <- signal_df_melt[["value"]]

print(head(signal_df_melt))


#----------2D Plot----------#
# My 2D plot depicts each individual signal in its own subplot, fitted with a LOESS curve to show the
# overall trend and directionality of each signal's movement.  Plotting was performed with ggplot2, specifically
# by partitioning the entire dataframe into its respective 'variable' groups and graphing each, respectively.

if (chosenOp == '2D') {
  cat("\nPerforming", chosenOp, "render\n")
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
  cat("\nPerforming", chosenOp, "render\n")
  plotting_3d( # Perform scatter3D render
    sig.df.melt_Time,
    sig.df.melt_variable,
    sig.df.melt_value,
    sig_labels,
    col_palete)
}
###########################

#ggplot(signal_df_melt, aes(x = `Mean Temperature [F]`, y = `Month`, fill = ..x..))

#plot(signal_df.x1, scale(signal_df.y1[["Coupling.2.gNMDA"]]), type = 'l')

#plot3d(signal_df_melt$variable, signal_df_melt$Time, signal_df_melt$value)
#scatter3D(x = rep(signal_df_melt[["variable"]]), y = signal_df[["Time"]], z = signal_df[["Coupling.2.gNMDA"]], bty = "b2", colkey = FALSE, main ="bty= 'b2'")



#rgl.postscript("mypdf.pdf","pdf")

#ggsave('plotted.pdf', width = 5, height = 5)


#plot_ly(
#  data = signal_df,
#  x = ~signal_df.z1, # Column names
#  y = ~signal_df.x1, # Time
#  z = ~signal_df.y1[, signal_df.z1], # Values for each respective column name
#  type = 'scatter3d',
#  mode = 'lines',
#  color = ~variable,
#  colors = c('red', 'blue', 'yellow', 'green', 'purple'))



#+ stat_smooth(color = "#00AFBB", method = 'loess')

#ggplot(signal_df, aes(x=signal_df.x1, y = signal_df$Coupling.2.gNMDA)) +
  #geom_area(fill="#69b3a2", alpha=0.5) +
  #geom_line(aes(y = scale(Coupling.2.Ca)), color = "darkred") +
  #geom_line(aes(y = scale(Coupling.2.gNMDA)), color="steelblue", linetype="twodash") +
  #geom_smooth(method = loess)




#signal_plot <- ggplot(data = signal_df, aes(x = length(df[['Coupling.2.gNMDA']]), y = df[['Coupling.2.gNMDA']])) +
#    geom_area(fill="#69b3a2", alpha=0.5) +
#    geom_line(color="#69b3a2") +
#    ylab("gNMDA Change")




#ggplot(a2, aes(x = year, y = values, color = values )) +
#  geom_line(size = 0.5)  +
#  geom_smooth(aes(color=..y..), size=1.5, se=FALSE) +
#  scale_colour_gradient2(low = "blue", mid = "yellow" , high = "red",
#                         midpoint=median(a2$values)) + theme_bw()
