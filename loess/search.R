library(ggplot2)

set.seed(100)
mydf <- data.frame(x=1:100, y=rnorm(100))
ret <- loess(y~x, data=mydf, span=0.35)

newX=seq(1,100,0.1)
ret_p <- data.frame(x=newX, y=predict(ret, newdata=data.frame(x=newX)))
myborders <- newX[which(diff(diff(ret_p$y)>0)!=0L)+1L]
k=diff(diff(ret_p$y)>0L)
k=k[k!=0L]
mystat=k[1]>0

len=length(myborders)
myborders <- (myborders[1:len-1]+myborders[2:len])/2

myp <- sapply(as.data.frame(rbind(c(newX[1],myborders),
                                  c(myborders,newX[length(newX)]))),
              function(k){ mystat <<- !mystat;
                optimize(f=function(x){predict(ret, newdata=data.frame(x))},
                         maximum=mystat, interval=k)})
myp=as.data.frame(t(myp))
names(myp) <- c("x", "y")
myp$x=as.numeric(myp$x)
myp$y=as.numeric(myp$y)
myp$type= 0; 
if(mystat) myp$type = myp$type + c(0,1) else myp$type = myp$type + c(1,0) 



png("search.png", width=800)
ggplot(mydf) + geom_point(aes(x,y), shape=1) +
  geom_line(aes(x,y), data=ret_p, colour="orange", size=0.9) +
  geom_point(aes(x,y, color=as.factor(type)), size=4, shape=9, data=myp) +
  geom_vline(aes(xintercept=x, color=as.factor(type)), data=myp, alpha=0.5, linetype="twodash")+
  scale_colour_manual(values=c("red","blue"), breaks=NULL)
dev.off()

system("feh search.png")
