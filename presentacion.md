Untitled
================

``` r
# install.packages(c("alluvial"), dependencies = TRUE)
require(alluvial)
```

    ## Loading required package: alluvial

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(magrittr)
# Titanic data
tit <- as.data.frame(Titanic)
#PLOT 1
alluvial( tit[,1:4], freq=tit$Freq,
          hide = tit$Freq < quantile(tit$Freq, .50),
          col=ifelse( tit$Sex =="Female", "darkcyan", "gray"),
          border = 'gray',blocks = FALSE)
```

![](presentacion_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

``` r
#PLOT 2
agroup1 <- tit %>% group_by(Sex,Survived) %>% summarise(n=sum(Freq))
```

    ## `summarise()` regrouping output by 'Sex' (override with `.groups` argument)

``` r
alluvial(agroup1[,1:2], freq=agroup1$n, layer = agroup1$Sex=="Female",
         col=ifelse(agroup1$Sex=="Female", "magenta","darkcyan"),
         alpha=0.5, blocks = FALSE, border=ifelse(agroup1$Sex=="Female", "magenta","darkcyan"))
```

![](presentacion_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

``` r
#PLOT 3 
agroup2<- tit %>% group_by(Sex, Age,Survived) %>%
    summarise(n = sum(Freq))
```

    ## `summarise()` regrouping output by 'Sex', 'Age' (override with `.groups` argument)

``` r
alluvial(agroup2[,1:3],freq = agroup2$n,
         col=ifelse(agroup2$Survived=="Yes","green","gray"),alpha=0.5,
         layer= agroup2$Sex=="Female", blocks = TRUE)
```

![](presentacion_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->
