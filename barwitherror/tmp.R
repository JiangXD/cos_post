library(ggplot2)
library(ggthemes)
data1 <- data.frame(x=c(0,0,5,5,10,10,20,20), type1=c(0,1,0,1,0,1,0,1), val=c(2,3,15,25,22,27,20,34))
data1$x = as.factor(data1$x)
data1$type1 = as.factor(data1$type1)
data2<-data.frame(x=c(0,5,10,20), val=c(0,35,35,40), mysig=c("","*","*","**"))
data2$x = as.factor(data2$x)
png("fig1.png")
ggplot(data1) + geom_bar(aes(x,y=val), width=0.25, fill="white", colour="black", data=data2) +
         geom_text(aes(x,y=val,label=mysig), size=12, data=data2) +
         geom_errorbar(aes(x=x, ymin=val, ymax=val+3, fill=type1), colour="white", size=2, width=0.2, position=position_dodge(0.5) ) +
         geom_bar(aes(x=x, y=val, fill=type1), width=0.5, position="dodge", stat="identity", colour="black") +
         geom_errorbar(aes(x=x, ymin=val-2, ymax=val+2, fill=type1), width=0.2, position=position_dodge(0.5) ) +
         scale_fill_manual(guide=guide_legend(title=" "), breaks=c(0, 1), values=c("white", "grey68"), labels=c("NT", "eEF2K siRNA")) +
         scale_y_continuous(limits=c(0,46), expand=c(0,0)) +
         xlab("MK2206 umol/L") +
         ylab("Percent of cells with\nactivated caspases(%)") +
         theme_few(16) + theme(legend.position=c(0.2,0.9),
                               panel.border=element_blank(),
                               axis.line=element_line())

dev.off()
system("feh *.png")
