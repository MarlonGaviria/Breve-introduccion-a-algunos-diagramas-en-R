# Diagramas con el paquete alluvial
Este repositorio esta diseñado con la intención de brindar una breve guía sobre el uso de algunos gráficos en R

Para esto, tenemos en cuenta que hay una gran oferta de graficos que R nos ofrece, seria una labor titanica y nada practica 
intentar explicar aqui todos ellos, por eso queremos llevarte por algunos de los graficos menos populares, pero que seguro haran que tus 
informes reluzcan y se vean maravillosos.

Empecemos con graficos Alluvial, este tipo de graficos muestra el paso de la informacion por "estaciones", con esto se logra ver con relativa claridad el paso de nuestra informacion; veamos como ejemplo los siguientes graficos creados con la base de datos de el *titanic*. 

<img src="https://github.com/MarlonGaviria/Breve-introduccion-a-algunos-diagramas-en-R/blob/master/Images/plot1.png">

```
install.packages(c("alluvial"), dependencies = TRUE)
require(alluvial)
require(dplyr)
# Titanic data
tit <- as.data.frame(Titanic)
```

¿Atractivo verdad?, este grafico fue hecho con la funcion alluvial, dle paquete alluvial en Rstudio, es un grafico llamativo, y dependiendo de 
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
De nuevo, este paquete es muy versatil y permite una gran gamma de posibilidades a un mismo grafico, este es otro ejemplo de ello:
<img src="https://github.com/MarlonGaviria/Breve-introduccion-a-algunos-diagramas-en-R/blob/master/Images/plot4.png">


```
#PLOT 3 
agroup2<- tit %>% group_by(Sex, Age,Survived) %>%
    summarise(n = sum(Freq))

alluvial(agroup2[,1:3],freq = agroup2$n,
         col=ifelse(agroup2$Survived=="Yes","green","gray"),alpha=0.5,
         layer= agroup2$Sex=="Female", blocks = TRUE)
```


