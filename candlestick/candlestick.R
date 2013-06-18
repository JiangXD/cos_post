#!/usr/local/bin/Rscript

library("ggplot2")

mydat = read.table(pipe("sed '1!s, ,\\/,' 1.txt"), head=TRUE)
mydat$time = as.POSIXct(as.character(mydat$time), format="%d/%m/%Y/%H:%M")
png("candlestick.png")
ggplot(mydat) + geom_errorbar(aes(x=time,ymax=high,ymin=low)) + geom_rect(aes(xmin=time-250, xmax=time+250, ymax=ifelse(open>close, open, close), ymin=ifelse(open>close, close, open), fill=ifelse(open>close,"white","black")), colour="black") + scale_fill_identity() + geom_line(aes(x=time, y=close), colour="orange")+ylab("price")
dev.off()
system("feh candlestick.png")
