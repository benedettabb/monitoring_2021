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
