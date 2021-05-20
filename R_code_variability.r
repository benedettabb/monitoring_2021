# R_code_variability.r
eterogeneità di un sistema attraverso una moving window

#carico le librerie
library (raster)
library (ggplot)
library (RStoolbox)

#set working directory
setwd ("C:/lab/similaun")

#carico l'immagine
sent <-brick ("sentinel.png")
#NIR 1, RED 2, GREEN 3
plotRGB(sent, stretch="lin")
plotRGB(sent, r= 2, g = 1, b = 3, stretch="lin")

#per il calcolo della dev standard usiamo una sola banda e utilizziamo la moving window
#maggiore è la dev stand maggiore è l'eterogeneità di un sistema

#calcolo dell'NDVI per ottenere un singolo strato
nir <- sent$sentinel.1
red <-sent$sentinel.2
ndvi <- (nir-red) / (nir+red)
ndvi
plot(ndvi) #in verde ho i valori alti di ndvi e in rosa quelli bassi

#cambio la color rampe palette
cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) # 
plot(ndvi,col=cl)

#ora possiamo calcolare la variabilità dell'immagine con la funzione focal
#focal values dal pacchetto raster
ndvi_sd3 <- focal (ndvi, w=matrix (1/9, nrow=3, ncol=3), fun=sd)
#w è la finestra. solitamente è meglio farla quadrata. più grande è la finestra più lungo è il calcolo. 
#1/9 vuol dire che si considera ogni signolo pixel su 9. La funzione è la deviazione standard
#cambio la color rampe palette
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #
plot(ndvi_sd3, col=clsd)

#invece della dev.standard calcolo la media
mean_sd3 <- focal (ndvi, w=matrix (1/9, nrow=3, ncol=3), fun=mean)
plot(mean_sd3, col=clsd)

#posso anche calcolare la prima componente principale - prendiamo un sistema a multi bande, ne calcoliamo una pca, e usiamo solo la prima componente principale
#così ottengo un solo strato
#e poi faccio passare la moving window su quello strato 
#uso la funzione raster cps di RStoolboox
sentPCA <- rasterPCA (sent)
sentPCA
#vedo le 4 componenti principali
plot(sentPCA$map)
#meglio...
summary (sentPCA$model)
#la prima componente spiega il 77.33% 
