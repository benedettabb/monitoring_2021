library(raster)
library(RStoolbox)

setwd ("C:/lab/landsat")

#ho un'immagine con molte bande, quindi utilizzo brick e non raster
land2011 <- brick ("p224r63_2011_masked.grd")

#scatter plot
plot(land2011$B1_sre, land2011$B2_sre, col="red", pch=19, cex=2)
#vedo che le variabili sono molto correlate tra di loro
#cex è il numero di bande
#pch?

#ora voglio plottare insieme tutte le bande
pair(land2011)
#questa funzione mette in correlazione a due a due tutte le bande. in alto c'è l'indice di correlazione. se va a 1 c'è una correlazione
#lineare, 0 non sono correlati ecc. correlazione di Pearson
