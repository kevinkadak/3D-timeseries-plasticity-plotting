#generatePlots.R
#Kevin Kadak (1007522888)

source('plottingTools.R')

args <- commandArgs(trailingOnly = TRUE) # Variable containing arguements passed from command line
check_args(args)

library('reshape2')
library('ggplot2')
library('plotly')
library("rgl")
library('plot3D')

signal_df <- load_data(args[1])

signal_df[2:length(signal_df)] <- scale(signal_df[2:length(signal_df)]) # Scale all columns
signal_df[is.na(signal_df)] <- 0 # Catch any instances where values were rendered as NaN due to inability to scale()

print(head(signal_df))
signal_df_melt <- melt(signal_df, id.vars = c("Time"))
print(head(signal_df_melt))

signal_df.x1 <- signal_df[["Time"]]
signal_df.y1 <- signal_df # needed specifically for 2D plot
signal_df.z1 <- names(signal_df[-1]) # All column names, excluding Time

print(signal_df.z1)


#plotting_2d(signal_df_melt) # Perform ggplot2 2D render
plotting_3d(signal_df_melt) # Perform plot_ly 3D render




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
