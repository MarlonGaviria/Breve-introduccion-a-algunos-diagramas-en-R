# Diagramas con el paquete alluvial
Este repositorio esta diseñado con la intención de brindar una breve guía sobre el uso de algunos gráficos en R

Para esto, tenemos en cuenta que hay una gran oferta de graficos que R nos ofrece, seria una labor titanica y nada practica 
intentar explicar aqui todos ellos, por eso queremos llevarte por algunos de los graficos menos populares, pero que seguro haran que tus 
informes reluzcan y se vean maravillosos.

Empecemos con graficos Alluvial, este tipo de graficos muestra el paso de la informacion por "estaciones", con esto se logra ver con relativa claridad el paso de nuestra informacion; veamos como ejemplo los siguientes graficos creados con la base de datos del *titanic*. 

<img src="https://github.com/MarlonGaviria/Breve-introduccion-a-algunos-diagramas-en-R/blob/master/Images/plot1.png">

```
install.packages(c("alluvial"), dependencies = TRUE)
require(alluvial)
require(dplyr)
# Titanic data
tit <- as.data.frame(Titanic)
```

¿Atractivo verdad?, este grafico fue hecho con la funcion alluvial, del paquete alluvial en Rstudio, es un grafico llamativo, y dependiendo de 
tus intenciones, ¡seguro que tambien podria decir mucho acerca de tus datos!.

Veamos otra posible forma de graficarlo, solo es necesario cambiar algunos parametros de la funcion para lograr este resultado con los mismos datos:

<img src="https://github.com/MarlonGaviria/Breve-introduccion-a-algunos-diagramas-en-R/blob/master/Images/plot2.png">

```
#PLOT 1
alluvial( tit[,1:4], freq=tit$Freq,
          hide = tit$Freq < quantile(tit$Freq, .50),
          col=ifelse( tit$Sex =="Female", "darkcyan", "gray"),
          border = 'gray',blocks = FALSE)
```

Este tipo de graficos suelen ser muy utiles cuando tus datos tienen varias variables calitativas, pues estas variables son las que se utilizan como "capa"
o las "estaciones", basicamente lo que ves es la proporcion de datos en cada categoria.

Un ejemplo mas de estos graficos con la misma base de datos *titanic*, es como se ve acontinuacion.
<img src="https://github.com/MarlonGaviria/Breve-introduccion-a-algunos-diagramas-en-R/blob/master/Images/plot3.png">

```
#PLOT 2
agroup1 <- tit %>% group_by(Sex,Survived) %>% summarise(n=sum(Freq))
alluvial(agroup1[,1:2], freq=agroup1$n, layer = agroup1$Sex=="Female",
         col=ifelse(agroup1$Sex=="Female", "magenta","darkcyan"),
         alpha=0.5, blocks = FALSE, border=ifelse(agroup1$Sex=="Female", "magenta","darkcyan"))

```

Muy interesante, ¡seguro le sacaras provecho!
De nuevo, este paquete es muy versatil y permite una gran gama de posibilidades a un mismo grafico, este es otro ejemplo de ello:
<img src="https://github.com/MarlonGaviria/Breve-introduccion-a-algunos-diagramas-en-R/blob/master/Images/plot4.png">


```
#PLOT 3 
agroup2<- tit %>% group_by(Sex, Age,Survived) %>%
    summarise(n = sum(Freq))

alluvial(agroup2[,1:3],freq = agroup2$n,
         col=ifelse(agroup2$Survived=="Yes","green","gray"),alpha=0.5,
         layer= agroup2$Sex=="Female", blocks = TRUE)
```
Ahora, puedes optar tambien por usar el paquete ggalluvial incorporado a los paquetes de ggplot, ggplot es un paquete muy poderoso para la realizacion de graficos,
con una sintaxis mas amena y comodo para el flujo del codigo, te mostraremos como podrias hacer un grafico alluvial con ggplot y ggalluvial:

```
# Alluvial con ggplot2
library(ggplot2)
library(datasets)
library(ggalluvial)
library(dplyr)

tit <- data.frame(Titanic)
```

<img src="https://github.com/MarlonGaviria/Breve-introduccion-a-algunos-diagramas-en-R/blob/master/Images/plot5.png">

```
# PLOT 1
ggplot(data = tit,
       aes(axis1 = Class, axis2 = Sex, axis3 = Age,
           y = Freq)) +
    scale_x_discrete(limits = c("Class", "Sex", "Age"), expand = c(.1, .05)) +
    xlab("Variables") + ylab("Frecuencia")+
    geom_alluvium(aes(fill = Survived)) +
    geom_stratum()  +
    theme_minimal() + geom_text(stat = "stratum", infer.label = TRUE)

```
Este grafico fue hecho con la base *titanic* y *ggalluvial* veras que es otra forma de conseguir los graficos que vimos con el paquete *alluvial* pero con la sintaxis conocida de ggplot.

Otro ejemplo de estos graficos creador en ggalluvial es como sigue, usando la base *titanic* como sigue: 

<img src="https://github.com/MarlonGaviria/Breve-introduccion-a-algunos-diagramas-en-R/blob/master/Images/plot6.png">

```
# PLOT 2
group1 <- tit %>% group_by(Sex,Age) %>% summarise(n=sum(Freq))
ggplot(data=group1,
       aes(axis1=Sex, axis2=Age, y=n)) +
    scale_x_discrete(limits=c("Sex","Age"), expand=c(0.1,0.05)) +
    geom_alluvium(aes(fill=Sex)) +
    geom_stratum()+
    geom_text(stat="stratum",infer.label=TRUE)+ theme_minimal()
```
<img src="https://github.com/MarlonGaviria/Breve-introduccion-a-algunos-diagramas-en-R/blob/master/Images/plot7.png">

```
# PLOT 3

group2 <- tit %>% group_by(Sex,Age,Survived) %>% summarise(n=sum(Freq))
ggplot(data=group2,
       aes(axis1=Sex, axis2=Age,axis3=Survived, y=n)) +
    scale_x_discrete(limits=c("Sex","Age","Survived"), expand=c(0.1,0.05)) +
    geom_alluvium(aes(fill=Sex)) +
    geom_stratum()+
    geom_text(stat="stratum",infer.label=TRUE)+ theme_minimal()
```

Como has visto, estos graficos son ideales cuando deseas ver la distribucion de frecuencias entre variables cualitativas en tu base de datos,
ahora tienes las herramientas para poder hacer que !tu informe sea aun mas llamativo!

sientete confiado de utilizar el codigo y jugar con tus bases, tienes varias opciones y muchas posibilidades para hacer este tipo de graficos!

Si sientes inquietudes acerca de los codigos y temas puedes buscar en [Paquete alluvial](https://cran.r-project.org/web/packages/alluvial/vignettes/alluvial.html) y 
[Paquete ggalluvial](https://corybrunson.github.io/ggalluvial/)
