library(ggplot2)

set.seed(1)
mydf <- data.frame(x=1:100, y=rnorm(100))
ret <- loess(y~x, data=mydf, span=0.3)

newX=seq(1,100,0.1)
ret_p <- data.frame(x=newX, y=predict(ret, newdata=data.frame(x=newX)))
myborders_max <- newX[which(as.integer(diff(diff(ret_p$y)>0))<0L)+1]
len=length(myborders_max)
myborders_max <- (myborders_max[1:len-1]+myborders_max[2:len])/2

myp <- sapply(as.data.frame(rbind(c(0,myborders_max), c(myborders_max,100))),
              function(k){
                optimize(f=function(x){predict(ret, newdata=data.frame(x))},
                         maximum=TRUE, interval=k)})
myp=as.data.frame(t(myp))
names(myp) <- c("x", "y")
myp$x=as.numeric(myp$x)
myp$y=as.numeric(myp$y)

myborders_min <- newX[which(as.integer(diff(diff(ret_p$y)>0))>0L)+1]
len=length(myborders_min)
myborders_min <- (myborders_min[1:len-1]+myborders_min[2:len])/2

myp2 <- sapply(as.data.frame(rbind(c(0,myborders_min), c(myborders_min,100))),
              function(k){
                optimize(f=function(x){predict(ret, newdata=data.frame(x))},
                         maximum=FALSE, interval=k)})
myp2=as.data.frame(t(myp2))
names(myp2) <- c("x", "y")
myp2$x=as.numeric(myp2$x)
myp2$y=as.numeric(myp2$y)


png("search.png", width=800)
ggplot(mydf) + geom_point(aes(x,y), shape=1) +
  geom_line(aes(x,y), data=ret_p, colour="orange", size=0.9) +
  geom_point(aes(x,y), size=4, shape=9, data=myp, color="red") +
  geom_point(aes(x,y), size=4, shape=9, data=myp2, color="blue") +
  geom_vline(aes(xintercept=x), data=myp, color="red",alpha=0.5, linetype="twodash") +
  geom_vline(aes(xintercept=x), data=myp2, color="blue2", alpha=0.5, linetype="dashed") 
dev.off()

system("feh search.png")
