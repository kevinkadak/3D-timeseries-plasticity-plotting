#generatePlots.R
#Kevin Kadak (1007522888)

source('plottingTools.R')

args <- commandArgs(trailingOnly = TRUE) # Variable containing arguements passed from command line
check_args(args)



signal_df <- load_data(args[1])

library('ggplot2')
library('plotly')

print (signal_df[1:20,])

print(names(signal_df))

print(length(signal_df[["Time"]]))

signal_df.x1 <- signal_df[["Time"]]
signal_df.y1 <- signal_df[["Coupling.2.gNMDA"]]
signal_df.z1 <- signal_df[-1]$value


plot_ly(
  data = signal_df,
  x = signal_df.x1,
  y = signal_df.y1,
  z = signal_df.z1,
  type = 'scatter3d',
  mode = 'lines',
  color = c('red', 'blue', 'yellow', 'green'))

#signal_plot <- ggplot(data = signal_df, aes(x = length(df[['Coupling.2.gNMDA']]), y = df[['Coupling.2.gNMDA']])) +
#    geom_area(fill="#69b3a2", alpha=0.5) +
#    geom_line(color="#69b3a2") +
#    ylab("gNMDA Change")


#plot(signal_df.x1, scale(signal_df.y1), type = 'l')

#ggplot(a2, aes(x = year, y = values, color = values )) +
#  geom_line(size = 0.5)  +
#  geom_smooth(aes(color=..y..), size=1.5, se=FALSE) +
#  scale_colour_gradient2(low = "blue", mid = "yellow" , high = "red",
#                         midpoint=median(a2$values)) + theme_bw()

#cccc <- signal_df[["Time"]] ^ 2 # Ax2
#quadratic_model <- lm(signal_df[['Coupling.2.gNMDA']] ~ signal_df[["Time"]] + cccc) # Ax^2 + Bx + C
#qxx <- seq( # Generate range of values from min to max nbr.injuries that are equally spaced
#  min(signal_df[["Time"]]),
#  max(signal_df[["Time"]]),
#  len = length(signal_df[["Time"]]))
#qyy <- quadratic_model$coef %*% rbind(1, qxx, qxx ^ 2)
#lines(qxx, qyy, lwd = 2, col = 'red')

#lines(signal_df[['Time']], predict(scale(signal_df[['Coupling.2.gNMDA']])),lty=2,col="red",lwd=3)
#lines(signal_df[['Time']], scale(signal_df[['Coupling.2.Ca']]), type = 'l', col = 'purple')

#signal_plot
