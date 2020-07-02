# Alluvial con ggplot2
library(ggplot2)
library(datasets)
library(ggalluvial)
library(dplyr)

tit <- data.frame(Titanic)

# PLOT 1
ggplot(data = tit,
       aes(axis1 = Class, axis2 = Sex, axis3 = Age,
           y = Freq)) +
    scale_x_discrete(limits = c("Class", "Sex", "Age"), expand = c(.1, .05)) +
    xlab("Variables") + ylab("Frecuencia")+
    geom_alluvium(aes(fill = Survived)) +
    geom_stratum()  +
    theme_minimal() + geom_text(stat = "stratum", infer.label = TRUE)

# PLOT 2
group1 <- tit %>% group_by(Sex,Age) %>% summarise(n=sum(Freq))
ggplot(data=group1,
       aes(axis1=Sex, axis2=Age, y=n)) +
    scale_x_discrete(limits=c("Sex","Age"), expand=c(0.1,0.05)) +
    geom_alluvium(aes(fill=Sex)) +
    geom_stratum()+
    geom_text(stat="stratum",infer.label=TRUE)+ theme_minimal()

# PLOT 3

group2 <- tit %>% group_by(Sex,Age,Survived) %>% summarise(n=sum(Freq))
ggplot(data=group2,
       aes(axis1=Sex, axis2=Age,axis3=Survived, y=n)) +
    scale_x_discrete(limits=c("Sex","Age","Survived"), expand=c(0.1,0.05)) +
    geom_alluvium(aes(fill=Sex)) +
    geom_stratum()+
    geom_text(stat="stratum",infer.label=TRUE)+ theme_minimal()







