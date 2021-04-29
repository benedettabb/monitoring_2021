#l'analisi multivariata PCA (analisi delle componenti principali) apuò essere fatta sulle diverse bande di un'immagine, ma anche su immagini -stessa banda -della
#stessa zona ma acquisite in tempi diversi (PCA + analisi multivariata)

library(raster)
library(RStoolbox)

#dati Landsat (30m)
setwd ("C:/lab/landsat")

#ho un'immagine con molte bande, quindi utilizzo brick e non raster
land2011 <- brick ("p224r63_2011_masked.grd")
#immagine con sette bande, molto correlate le une alle altre

#scatter plot - correlazione tra la B1 e la B2
plot(land2011$B1_sre, land2011$B2_sre, col="red", pch=19, cex=2)
#vedo che le variabili sono molto correlate tra di loro
#cex è il numero di bande
#pch?

#ora voglio plottare insieme tutte le bande
pairs(land2011)
#questa funzione mette in correlazione a due a due tutte le bande. in alto c'è l'indice di correlazione. se va a 1 c'è una correlazione
#lineare positiva, -1 correlazione perfettamente negativa, 0 non sono correlati. indice di correlazione di Pearson

#con la PCA creo un'immagine con lo stesso numero di bande, ma disposte diversamente nello spazio multispettrale 
#ottengo di spiegare la variabilità con le prime bande di un'immagine.
#si passa un nuovo asse lungo la varibilità maggiore, ed un nuovo asse lungo la variabilità minore. La prima componente viene fatta passare lungo la varibilità
#maggiore. Questo viene fatto nello spazio multi-spettrale con tante bande. le bande non sono più correlate tra di loro.
#Se ho una correlazione lineare e le variabili sono molto correlate posso aver bisogno di fare un'analisi multivariata. 

#la PCA è molto impattante come analisi. prima è più utile ricampionare le diverse bande con raster aggregate - aggrego i pixel facendo una media, creo coì
#un'immagine con risoluzione più bassa

#aggregate (immagine da aggregare, factor= di quante volte voglio diminuire la risoluzione - è un fattore lineare, funzione che vogliamo usare es media, varianza ecc)
#per ogni banda aumento la dimensione dei pixel (diminuisco la ris spaziale). res = resempled
land2011_res <- aggregate (land2011, fact=10)
#da un'immagine composta da pixel di 30x30m si ottiene un pixel di 300x300m - dettaglio minore, peso minore dell'immagine
#visualizzo le due immagini
par(mfrow=c(2,1))
plotRGB (land2011, r=4, g=3, b=2, stretch= "lin")
plotRGB (land2011_res, r=4, g=3, b=2, stretch= "lin")

#la funzione per fare l'analisità multivariata è all'interno di RStoolbox - si chiama rasterPCA
land2011_res_PCA <- rasterPCA (land2011_res)
#provo anche con l'immagine no resampled
land2011_PCA <- rasterPCA (land2011)
#il risultato della PCA è una mappa in uscita, un modello che ci da tutte le info eccetera
#qual'è la varianza spegata dal sistema? spiegata dalla componente principale? vado a fare summary (funzione base e generica di R)
#lego l'immagine con il modello
summary (land2011_res_PCA$model)
#la prima componente, PC1, spiega il 99% della variabilità. con quante bande, componenti, arrivo al 100%? mi servono tutte
#ma già con le prime tre componenti spiego il 99.998% - quindi è già sufficiente
#con plot vedo questa situazione (lego il risultato alla sua mappa)
plot(land2011_res_PCA$map)
#la prima componente vede tanta variabilità, distigue molte cose. l'ultima non vede praticamente nulla, solo rumore.

#chimando la variabile vedo tutto quello che c'è dentro
land2011_res_PCA

#vedo che call, model e map sono legate all'oggetto land2011_res_PCA che ho appena chiamato
#facciamo un plot RGB con le prime tre componenti principali
plotRGB (land2011_res_PCA$map, r=1, g=2, b=3, stretch="lin")

#plottiamo la prima componente contro la seconda per vedere se c'è correlazione tra di loro - non sono correlate tra loro
plot (land2011_res_PCA$map$PC1, land2011_res_PCA$map$PC2)

#con str ottengo molte info in più
str(land2011_PCA)


