#carico le librerie necessarie
library (raster)

#definisco la working directory
setwd ("C:/lab/defor")

defor1 <- brick ("defor1.png")
defor2 <- brick ("defor2.png")

#multiframe plot RGB
par(mfrow=c(2,1))
plotRGB (defor1, r=1, g=2, b=3, stretch ="lin")
plotRGB (defor2, r=1, g=2, b=3, stretch ="lin")

#ottengo info
defor1
#su names: ci sono le bande

#calcolo il dvi (difference vegetation index)
dvi1 <- defor1$defor1.1-defor1$defor1.2
#la vegetazione di default viene verde

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifico una palette
#le zone più scure sono vegetazione più rigorosa (dvi>)
plot (dvi1, col =cl, stretch="lin", main="dvi at time 0")

#stesso con la seconda immagine
defor2
dvi2 <- defor2$defor2.1-defor2$defor2.2 
plot(dvi2)
plot (dvi1, col =cl, stretch="lin", main="dvi at time 0")

#plotto le 4 immagini insieme
par (mfrow=c(2,2))
plotRGB(defor1)
plotRGB(defor2)
plot (dvi1, col =cl, stretch="lin", main="dvi at time 0")
plot (dvi2, col =cl, stretch="lin", main="dvi at time 1")
dev.off()

#sottraggo il dvi1 della prima immagine al dvi2 della seconda immagine.
dvi_diff <- dvi1-dvi2
#valori alti in dvi_diff mi dicono che c'è stata una diminuzione di dvi. valori bassi mi dicono che c'è stato un aumento
plot(dvi_diff)
dev.off()

#utilizzo una palette spesso usata per le differenze
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(dvi_diff, col =cld)
#le zone in rosso sono quelle in cui l'impatto è stato più forte (impatto della deforestazione)

#ora facciamo lo stesso per NDVI - rispetto al DVI questo è standardizzato: valori che vanno da -1 a +1
#NDVI= (NIR-RED) / (NIR+RED)
NDVI1 <- (defor1$defor1.1-defor1$defor1.2)/(defor1$defor1.1+defor1$defor1.2)
plot(NDVI1)
NDVI2 <-(defor2$defor2.1-defor2$defor2.2)/(defor2$defor2.1+defor2$defor2.2)
plot(NDVI2)

#alcuni sofware ragionano in modo sequenziale -> fanno le operazioni nell'ordine in cui le trovano. è sempre meglio mettere le parentesi
par(mfrow = c(1,2))
plot(NDVI1, col=cl, main="NDVI at time 0")
plot(NDVI2, col=cl, main="NDVI at time 1")


#su RStoolbox ci sono già tanti indici già pronti
library(RStoolbox)
vi1 <- spectralIndices (defor1, green=3, red=2, nir=1)
plot(vi1, col=cl)

vi2 <- spectralIndices (defor2, green=3, red=2, nir=1)
plot(vi2, col=cl)
