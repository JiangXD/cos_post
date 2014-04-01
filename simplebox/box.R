library(ggplot2)
library(grid)

box_location=read.table(textConnection(
    'x1  y1 x2 y2
     0   0  10 20
     20  30  25 35
    '
    ), header=TRUE)

mydots <- function(mydat){
    shu=80
    data.frame(x=runif(shu, min=mydat$x1, max=mydat$x2),
               y=runif(shu, min=mydat$y1, max=mydat$y2),
               f=runif(shu)
               )
}

mydotsdat <- mydots(box_location[1,])
mydotsdat2 <- mydots(box_location[2,])

png("tmp.png")
mainpic <- ggplot(box_location) + geom_rect(aes(xmin=x1,ymin=y1,xmax=x2, ymax=y2), fill=NA, colour="black") +
    geom_point(aes(x,y,alpha=f), size=8, colour="red", data=mydotsdat) +
    geom_point(aes(x,y,alpha=f), size=4, fill="lightblue", colour="red", shape=21, data=mydotsdat2) +
    scale_alpha(breaks=NULL) +
    theme_minimal()
subpic <- ggplot(mydotsdat) + geom_point(aes(x,y,alpha=f), size=8, colour="darkgreen") +
    scale_alpha(breaks=NULL) + labs(x="",y="") +
    scale_x_continuous(expand=c(0,0)) +
    scale_y_continuous(expand=c(0,0)) +
    theme_minimal() +
    theme(text=element_blank(),
          axis.ticks=element_blank(),
          panel.grid=element_blank(),
          panel.background=element_rect())
subvp <- viewport(width=0.4, height=0.535, x=0.7,y=0.34)
mainpic
print(subpic, vp=subvp)

dev.off()
system("feh tmp.png")
