#libraries
library('ggplot2')
library('rgl')

#set seed (so random data look the same each time)
set.seed(123)

#make kevin data
variable <- as.factor(c(rep('coupling_a', 100), rep('coupling_b', 100), rep('coupling_c', 100), rep('coupling_d', 100)))
time <- rep(seq(1,100),4)
value <- abs(cumsum(rnorm(100)))
df <- data.frame(time, variable, value)

print (df)

ggplot(df, aes(x=time, y=value, color=variable)) +
  geom_area(aes(fill=variable),alpha=0.4) +
  geom_line() +
  theme_bw() +
  theme(legend.position = 'top',
        legend.title = element_blank())

ggsave("helpplot.pdf")
