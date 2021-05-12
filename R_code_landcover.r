require(raster)
require(rasterdiv)
require(RStoolbox)
require(ggplo2)
library(gridExtra)

setwd ("C:/lab/defor")
defor1 <- brick ("defor1.png")
defor2 <- brick ("defor2.png")

plotRGB(defor1, r=1, g=2, b=3, stretch ="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch ="lin")

#se ho installati e caricati il pacchetto ggplot2 e RStoolbox posso fare anche un altro tipo di plot, più bello da vedere.
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch ="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch ="lin")

#multiframe con ggplot e gridExtra (plot1, plot2, numero righe)
grid.arrange(p1, p2, nrow= 2)

#classificazione non sup che prende un campione random di pixel (10 000)
#foresta
#agricolo
#acqua
d1c <-unsuperClass (defor1, nClasses =2)
d2c <-unsuperClass (defor2, nClasses =2)
plot(d1c$map)
#classe 1: agricolo, 2: foresta
#per ottenere lo stesso risultato
set.seed(42)
plot(d2c$map)

#faccio un'altra classificazione con tre classi
d1c3 <-unsuperClass (defor1, nClasses =3)
d2c3 <-unsuperClass (defor2, nClasses =3)
plot(d1c3$map)
plot(d2c3$map)

#calcolo della frequenza relativa alle due classi generate
freq(d1c$map)
#value  count
#[1,]     1  35322 :agricolo
#[2,]     2 305970 :foresta

#vado a vedere il numero di pixel totali
defor1
#dimensions : 478, 714, 341292, 3  (nrow, ncol, ncell, nlayers)
#infatti
s1 <-35322 + 305970

prop1 <- freq(d1c$map)/s1
#[1,] prop agricolo: 0.103495 
#[2,] prop foresta: 0.896505 


#lo stesso con la seconda immagine. ha un numero di pixel differente
defor2
#dimensions : 478, 717, 342726, 3  (nrow, ncol, ncell, nlayers)
s2 <-342726
prop2 <- freq(d2c$map)/s2
prop2
#[1,]prop agricolo: 0.4812389 
#[2,]prop foresta: 0.5229627

#costruire un dataframe
#fattori: variabili categoriche  in statistica (agricolo e foresta)
cover <- c("Foresta", "Agricolo")
percent_1992 <- c((0.896505*100), (0.103495*100))
percent_2006 <-c((0.5229627*100), (0.4812389*100))
#creo il dataframe (tabella)
percentuali <- data.frame (cover, percent_1992, percent_2006)
percentuali
#cover percent_1992 percent_2006
#1  Foresta      89.6505     52.29627
#2 Agricolo      10.3495     48.12389

#ora facciamo un grafico con ggplot
#ggplot(output, aestetics (prima colonna, seconda colonna, colori) + tipo di grafico)
plot1992 <- ggplot(percentuali, aes (x = cover, y = percent_1992, color = cover)) + geom_bar (stat= "identity", fill = "green")
#faccio lo stesso per il 2006
plot2006 <- ggplot(percentuali, aes (x = cover, y = percent_2006, color = cover)) + geom_bar (stat= "identity", fill = "red")

#metto insieme i due grafici
grid.arrange (plot1992, plot2006, nrow =1)


