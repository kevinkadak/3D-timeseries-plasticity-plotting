#generatePlots.R
#Kevin Kadak (1007522888)

source('plottingTools.R')

args <- commandArgs(trailingOnly = TRUE) # Variable containing arguements passed from command line
check_args(args)

library('reshape2')

signal_df <- load_data(args[1])
signal_df_melt <- melt(signal_df, id.vars = c("Time"))

library('ggplot2')
library('plotly')

print (signal_df[1:20,])

signal_df.x1 <- signal_df[["Time"]]
signal_df.y1 <- signal_df # needed specifically for 2D plot
signal_df.z1 <- names(signal_df[-1]) # All column names, excluding time

print(signal_df.z1)

#plot(signal_df.x1, scale(signal_df.y1[["Coupling.2.gNMDA"]]), type = 'l')



fig <- plot_ly(
  data = signal_df_melt,
  type = 'scatter3d',
  mode = 'lines',
  x = ~ value, # Column names
  y = ~ Time, # Time
  z = ~ variable, # Values for each respective column name
  color = ~ variable,
  colors = c('red', 'blue', 'yellow', 'green', 'purple'))

fig

#plot_ly(
#  data = signal_df,
#  x = ~signal_df.z1, # Column names
#  y = ~signal_df.x1, # Time
#  z = ~signal_df.y1[, signal_df.z1], # Values for each respective column name
#  type = 'scatter3d',
#  mode = 'lines',
#  color = c('red', 'blue', 'yellow', 'green', 'purple'))



#+ stat_smooth(color = "#00AFBB", method = 'loess')

#ggplot(signal_df, aes(x=signal_df.x1, y = signal_df$Coupling.2.gNMDA)) +
  #geom_area(fill="#69b3a2", alpha=0.5) +
  #geom_line(aes(y = scale(Coupling.2.Ca)), color = "darkred") +
  #geom_line(aes(y = scale(Coupling.2.gNMDA)), color="steelblue", linetype="twodash") +
  #geom_smooth(method = loess)

ggsave('plotted.pdf', width = 5, height = 5)



#signal_plot <- ggplot(data = signal_df, aes(x = length(df[['Coupling.2.gNMDA']]), y = df[['Coupling.2.gNMDA']])) +
#    geom_area(fill="#69b3a2", alpha=0.5) +
#    geom_line(color="#69b3a2") +
#    ylab("gNMDA Change")




#ggplot(a2, aes(x = year, y = values, color = values )) +
#  geom_line(size = 0.5)  +
#  geom_smooth(aes(color=..y..), size=1.5, se=FALSE) +
#  scale_colour_gradient2(low = "blue", mid = "yellow" , high = "red",
#                         midpoint=median(a2$values)) + theme_bw()

#lines(signal_df[['Time']], predict(scale(signal_df[['Coupling.2.gNMDA']])),lty=2,col="red",lwd=3)
#lines(signal_df[['Time']], scale(signal_df[['Coupling.2.Ca']]), type = 'l', col = 'purple')

#signal_plot

#dev.off()
