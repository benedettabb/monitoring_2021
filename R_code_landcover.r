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
d1c <-unsuperClass (defor1, nClasses =3)
