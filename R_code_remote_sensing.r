# My first code in R for remote sensing!!
install.packages("raster")
#installo il pacchetto esterno raster. quando il pacchetto è esterno devo utilizzare le virgolette

setwd("C:/lab/") # Windows
#apro la cartella che ho creato su C: (cartella senza maiuscole perchè R è case sensitive)
#così dico a R che nella cartella lab ci sono i dati che mi interessano

p224r63_2011 <- brick("p224r63_2011_masked.grd")
#utilizzo la funzione brick per importare i dati. il nome dell'oggetto è p224r63_2011 - da questo momento utilizzando il nome dell'oggetto richiamo la funzione

p224r63_2011
#richiamando l'oggetto ne posso vedere le specifiche (dimensione, risoluzione, estensione ecc.)

plot (p224r63_2011 )
# visualizzo le diverse bande di acquisizione dell'immagine -> B1 = rosso, B2= verde, B3 = rosso, B4 = infrarosso, B5 = infrarosso medio, B6 = infrarosso termico, B7= infrarosso ?
# a destra ho i valori di riflettanza (luce incidente/luce riflessa -> da 0 a 1)

