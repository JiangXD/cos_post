library(ggplot2);
library(reshape2);

myreplies <- 10000L;
mysublines <- 12L;

mydat <- melt(replicate(myreplies, diff(sort(c(0, runif(mysublines-1L), 1)))));
png("tmp.png")
ggplot(mydat) + geom_histogram(aes(x=value)) + facet_wrap(~Var1)
dev.off()
