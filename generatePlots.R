#generatePlots.R
#Kevin Kadak (1007522888)

source('plottingTools.R')

args <- commandArgs(trailingOnly = TRUE) # Variable containing arguements passed from command line
check_args(args)



signal_df <- load_data(args[1])

library('ggplot2')

print (signal_df[1:20,])

signal_plot <- ggplot(data = signal_df, aes(x = length(df[['Coupling.2.gNMDA']]), y = df[['Coupling.2.gNMDA']])) +
    geom_area(fill="#69b3a2", alpha=0.5) +
    geom_line(color="#69b3a2") +
    ylab("gNMDA Change")


#plot(scale(df[['Coupling.2.gNMDA']]), type = 'l')
#lines(scale(df[['Coupling.2.Ca']]), type = 'l', col = 'purple')

signal_plot
