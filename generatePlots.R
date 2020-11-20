#generatePlots.R
#Kevin Kadak (1007522888)

source('plottingTools.R')

args <- commandArgs(trailingOnly = TRUE) # Variable containing arguements passed from command line
#plotOption1 <- readline(prompt = "")
check_args(args)

library('reshape2')
library('ggplot2')
library('plotly')
library("rgl")
library('plot3D')

signal_df <- load_data(args[1])
chosenOP <- args[2]

signal_df.time <- signal_df[["Time"]]
#signal_df.y1 <- signal_df # needed specifically for 2D plot
signal_df.names <- names(signal_df[-1]) # All column names, excluding Time

signal_df[2:length(signal_df)] <- scale(signal_df[2:length(signal_df)]) # Scale all columns excluding Time
signal_df[is.na(signal_df)] <- 0 # Any instances where values did change and were thus rendered as NaN due to inability to scale() = 0
print(head(signal_df))

#names(signal_df) <- replace(names(signal_df), names(signal_df), split(names(signal_df), ".")[3])
#print(signal_df)

signal_df_melt <- melt(signal_df, id.vars = c("Time")) # Convert the dataframe into a 3-column str for xyz plotting
#names(signal_df_melt) <- replace(names(signal_df_melt), names(signal_df_melt), split(signal_df.names, ".")[3])
#signal_df_melt[['variable']] <- replace(signal_df_melt[['variable']], signal_df.names, c('nu', 'nutilde', 'Ca', 'B', 'gNMDA'))
#replace(signal_df_melt[['variable']], signal_df.names, split(signal_df.names, ".")[3])
print(head(signal_df_melt))



#----------2D Plot----------#
#
#
#
if (chosenOP == '2D') plotting_2d(signal_df) # Perform ggplot2 2D render

#----------3D Plot----------#
#
#
#
#

if (chosenOP == '3D') plotting_3d(signal_df_melt) # Perform scatter3D render

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
