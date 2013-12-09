library(ggplot2)

set.seed(10)
mydf <- data.frame(x=1:100, y=rnorm(100))
ret <- loess(y~x, data=mydf, span=0.3)

newX=seq(1,100,0.1)
ret_p <- data.frame(x=newX, y=predict(ret, newdata=data.frame(x=newX)))
myborders <- newX[which(diff(diff(diff(ret_p$y))>0)!=0L)+2L]
k=diff(diff(diff(ret_p$y))>0L)
k=k[k!=0L]
mystat=k[1]>0
mystat0=mystat

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
if(mystat0) myp$type = myp$type + c(1,0) else myp$type = myp$type + c(0,1) 



png("guai.png", width=800)
ggplot(mydf) + geom_point(aes(x,y), alpha=0.4, shape=1) +
  geom_line(aes(x,y), data=ret_p, colour="orange", size=0.9) +
  geom_point(aes(x,y), color="blue", size=4, shape=21, data=myp[-1,]) +
  geom_text(aes(x,y), label="拐", color="grey", size=6, vjust=-1, size=4, shape=21, data=myp[-1,]) 
dev.off()

system("feh guai.png")
