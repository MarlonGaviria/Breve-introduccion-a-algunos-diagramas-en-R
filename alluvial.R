# install.packages(c("alluvial"), dependencies = TRUE)
require(alluvial)

# Titanic data
tit <- as.data.frame(Titanic)

# 4d
alluvial( tit[,1:4], freq=tit$Freq,
          hide = tit$Freq < quantile(tit$Freq, .50),
          col=ifelse( tit$Class == "3rd" & tit$Sex == "Male", "red", "gray"),
          border = 'gray')


library(ggplot2)

### una prueba de colaboracion