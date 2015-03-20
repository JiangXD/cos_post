#/usr/local/bin/R
library(ggplot2)
library(reshape2)

mydat=read.table("mydat.dat")
mydat$myid=1:48;
names(mydat)[3]=c("mylabel");
names(mydat)[4]=c("x");
mydat=melt(mydat, id.vars=c("x", "mylabel"))

pic=ggplot(mydat) + geom_bar(aes(x,y=value,group=variable, 
                             fill=variable), position="fill", 
                             stat="identity") + 
                    scale_fill_manual(values=c("orange","purple"), guide=FALSE)+
                    geom_text(aes(x,label=value),y=0,hjust=0,
                              data=subset(mydat, variable=="SampleA"))+
                    geom_text(aes(x,label=value),y=1,hjust=1,
                              data=subset(mydat, variable=="SampleB"))+
                    geom_hline(yintercept=0.5, linetype="dashed")+
                    scale_y_continuous(breaks=c(0,0.5,1), labels=c("0","50%","100%"),expand=c(0,0))+
                    scale_x_continuous(breaks=1:48, labels=subset(mydat, variable=="SampleA")$mylabel, expand=c(0,0))+
                    coord_flip() + labs(x=NULL,y=NULL)
png("figB.png",height=1000)
print(pic)
dev.off()

system("feh figB.png")




