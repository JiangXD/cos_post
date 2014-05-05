library(ggplot2)

mydat = data.frame(mydate=as.Date(scan(pipe("ls cn/_posts/*.md | sed 's,^[^0-9]*\\(.\\{10\\}\\).*$,\\1,;'"), what="")), mysize=scan(pipe("stat -f '%z' cn/_posts/*.md")))

png("blog.png")
ggplot(mydat, aes(x=mydate, y=mysize)) + geom_point(alpha=0.3, color="darkgreen") + geom_smooth() + labs(x="\nDate", y="Blog Size (Bytes)\n")
dev.off()
