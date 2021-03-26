# My first code in R for remote sensing!!
install.packages("raster")
#installo il pacchetto esterno raster. quando il pacchetto è esterno devo utilizzare le virgolette!!!!!

setwd("C:/lab/") # Windows
#apro la cartella che ho creato su C: (cartella senza maiuscole perchè R è case sensitive)
#così dico a R che nella cartella lab ci sono i dati che mi interessano

p224r63_2011 <- brick("p224r63_2011_masked.grd")
#utilizzo la funzione brick per importare i dati. il nome dell'oggetto è p224r63_2011 - da questo momento utilizzando il nome dell'oggetto richiamo la funzione

p224r63_2011
#richiamando l'oggetto ne posso vedere le specifiche (dimensione, risoluzione, estensione ecc.)

plot (p224r63_2011)
# visualizzo le diverse bande di acquisizione dell'immagine 
# a destra ho i valori di riflettanza (luce incidente/luce riflessa -> da 0 a 1)

cl <- colorRampPalette (c("black", "grey", "light grey")) (100)
#cambio il colore associato ai valori di riflettanza. inserisco il nero, il grigio e il bianco.
#utilizzo un vettore o array per connettere i tre colori - questi infatti sono diversi elementi per lo stesso argomento, ossia il colore.
#per raggrupparli devo mettere una funzione dedicata solo a loro. i colori sono una serie di caratteri -> si inserisce una c ("","","")
#c= array
#100 sono i livelli intermedi tra il nero, il grigio e il grigio chiaro 
#associo un nome alla funzione -cl come colour

plot (p224r63_2011, col=cl)
#la funzione ha due argomenti: l'immagine che voglio plottare e il colore che voglio dare alle bande (argomento colore = col = alla mia palette)

#dev.off() -> serve per disattivare l'interfaccia grafica, cancella quelle aperte

cl1 <- colorRampPalette (c("blue","red", "yellow", "green", "dark green")) (100)
plot (p224r63_2011, col=cl1)

#BANDE LANDSAT --> B1_sre (SpectralREflectance)
#B1=banda blu; 
#B2=banda verde; 
#B3=banda rosso; 
#B4=infrarosso vicino; 
#B5=infrarosso medio;
#B6=infrarosso termico;
#B7=infrarosso medio.

#dev.of() ripulisce la finestra grafica /clean the curren graph
dev.of()
#$ questo simbolo è sempre usato in R per legare due blocchi - llo utilizzo per legare l'immagine generale alla banda 1
#utilizzo la funzione plot
plot (p224r63_2011$B1_sre)

#ora plotto la banda 1 con una scala di colori scelta
plot (p224r63_2011$B1_sre, col=cl1) 

#multiframe (mf) = visualizzo le due bande una accanto all'altra)
#per farlo utilizzo la funzione par()
#voglio anche una riga e due colone -- par(mfrow= c(1,2))
#il vettore o array è una serie di caratteri nel linguaggio informatico - si indica con c

#par mi fa decidere come voglio fare il plottaggio
par (mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#ora faccio 2 righe e 1 colonna
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre, col=cl1)
plot(p224r63_2011$B2_sre, col=cl1)

#posso anche scegliere di avere prima le colonne e poi le righe
par(mfcol=c(2,1))
plot(p224r63_2011$B1_sre, col=cl1)
plot(p224r63_2011$B2_sre, col=cl1)

#ora associo ogni banda ad una colorRampPalette che me la ricorda. Creo le palette
clB <- colorRampPalette(c("dark blue","blue","light blue"))(100)
clG <- colorRampPalette(c("dark green","green","light green"))(100)
clR <- colorRampPalette(c("dark red","red","pink"))(100)
clNIR <- colorRampPalette(c("red","orange","yellow"))(100)

par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre, col=clB)
plot(p224r63_2011$B2_sre, col=clG)
plot(p224r63_2011$B3_sre, col=clR)
plot(p224r63_2011$B4_sre, col=clNIR)

#visualizzo l'immagine in RGB
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") #immagine in true colour
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") #immagine a falsi colori
#con la funzione stretch redistribuisco i valori in maniera lineare per visualizzarli meglio
#r g b sono integer!! posso anche non inserirli perchè il comando è stato pensato così

par(mfrow=c(2,2))
> plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
> plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
> plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
> plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")


#ora creo un pdf - richiamo la funzione pdf
pdf("il_mio_pdf") #può avere il nome che vuoi!
par(mfrow=c(2,2)) #copi tutto
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off() #a questo punto il pdf è creato nella cartella


#posso provare anche stretch diversi
#provo stretch histagram
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

# par natural colours, flase colours, and false colours with histogram stretching
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")
#questo mi permette di andare a visualizzare situazioni di diversità all'interno della stessa vegetazione, anche dove tutto sembra omogeneo


#COLORIST - metto tre immagini nelle tre bande in tempi diversi, ad esempio un'immagine di gennario nel R, di maggio nel V, di dicembre in B
#a seconda che l'immagine diventa più r v oppure b posso campire quando quella vegetazione è più sviluppata.

#PCA analisi delle componenti principali

