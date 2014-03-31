library(ggplot2)

box_location=read.table(textConnection(
    'x1  y1 x2 y2
     0   0  10 20
     20  30  40 60
    '
    ), header=TRUE)

mydots <- function(mydat){
    shu=30
    data.frame(x=runif(shu, min=mydat$x1, max=mydat$x2),
               y=runif(shu, min=mydat$y1, max=mydat$y2),
               f=runif(shu)
               )
}

mydotsdat <- mydots(box_location[1,])
mydotsdat2 <- mydots(box_location[2,])

png("tmp.png")
 ggplot(box_location) + geom_rect(aes(xmin=x1,ymin=y1,xmax=x2, ymax=y2), fill=NA, colour="black") +
    geom_point(aes(x,y,alpha=f), size=4, colour="red", data=mydotsdat) +
    geom_point(aes(x,y,alpha=f), size=4, colour="blue", data=mydotsdat2) +
    scale_alpha(breaks=NULL) +
    theme_minimal()
dev.off()
system("feh tmp.png")
