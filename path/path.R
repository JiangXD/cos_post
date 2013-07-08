#!/usr/local/bin/Rscript

library(ggplot2)
mydat <- read.table("dat.txt", header=TRUE)
mylabels <- mydat[c(1,23),]
mylabels$text <- c("Site 1 *", "Site 23 **")
png("path.png")
ggplot(mydat) + geom_path(aes(X, Y)) +
              geom_point(aes(X, Y,size=Length),
                         shape=21, colour="white",
                         fill="orange") +
              scale_size_identity() +
              geom_text(aes(X, Y,label=text),
                        colour="blue", size=6,
                        fontface=2, hjust=-0.7,
                        data=mylabels)
dev.off()
system("feh path.png")
