#!/usr/local/bin/Rscript

library(ggplot2)
library(grid)
mydat <- read.table("dat.txt", header=TRUE)
mylabels <- mydat[c(1,23),]
mylabels$text <- c("Site 1 **", "Site 23 *")
myarrow <- data.frame(x=c(150,150), y=c(110,260),
                      xend=c(175,110), yend=c(148,230))
mylabels2 <- data.frame(x=c(135,110), y=c(100,220),
                        text=c("Upstream", "Downstream"))
png("path.png")
ggplot(mydat) + geom_path(aes(X, Y), colour="slateblue4") +
              geom_point(aes(X, Y,size=0.8*Length),
                         shape=21, colour="white",
                         fill="orange") +
              scale_size_identity() +
              geom_text(aes(X, Y,label=text),
                        colour="brown", size=6,
                        fontface=2, hjust=-0.7,
                        data=mylabels)+
              geom_segment(aes(x,y,xend=xend,yend=yend),
                           arrow=arrow(angle=10, length=unit(8,"mm"),
                             type="closed"),
                           colour="slateblue2",
                           data=myarrow)+
              geom_text(aes(x,y, label=text), colour="slateblue3",
                        fontface=2, data=mylabels2)
dev.off()
system("feh path.png")
