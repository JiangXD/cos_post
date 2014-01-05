link = "http://img.dafont.com/dl/?f=wm_people_1";
download.file(link, "wmpeople1.zip", mode = "wb");
unzip("wmpeople1.zip");


link = "http://img.dafont.com/dl/?f=memes_by_jopea302";
download.file(link, "memes_by_jopea302.zip", mode = "wb");
unzip("memes_by_jopea302.zip");

library(showtext);
font.add("wmpeople1", "wmpeople1.TTF");
font.add("Memes", "Memes.ttf");

library(ggplot2);
library(plyr);

dat = read.csv(textConnection('
edu,educode,gender,population
A,1,男,17464
A,1,女,41268
B,2,男,139378
B,2,女,154854
C,3,男,236369
C,3,女,205537
D,4,男,94528
D,4,女,70521
E,5,男,57013
E,5,女,50334
'));

dat$int = round(dat$population / 10000);
gdat = ddply(dat, "educode", function(d) {
    male = d$int[d$gender == "男"];
    female = d$int[d$gender == "女"];
    data.frame(gender = c(rep("男", male), rep("女", female)),
               x = 1:(male + female));
});
gdat$char = ifelse(gdat$gender == "男", "p", "u");

pdf("edu.pdf", height=4);
showtext.begin();
ggplot(gdat, aes(x = x, y = educode)) +
    geom_text(aes(label = char, colour = gender),
              family = "wmpeople1", size = 7) +
    scale_x_continuous("人数（千万）") +
    scale_y_discrete("受教育程度",
        labels = unique(dat$edu[order(dat$educode)])) +
    scale_colour_manual("性别", breaks=NULL, values = c("#00BFC4", "#F8766D")) +
    theme(axis.text.y=element_text(size=rel(4), family="Memes")) +
    ggtitle("2012年统计数据");
showtext.end();
dev.off();
