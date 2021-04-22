library(raster)
library(RStoolbox)

setwd ("C:/lab/sun")
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

so
#valori che vanno da 0 a 255. non sono bande originali ma quelle utilizzate per creare l'RGB

#facciamo un plot RGB
plotRGB (so,1,2,3, stretch = "lin")

#distinguiamo nell'immagine tre livelli energetici, tre classi, scelte da noi (potrebbero essere molte di più).
#vogliamo fare una classificazione non supervisionata
#utilizziamo la classificazione unsuperClass (img, numero di classi, 
so_c <- unsuperClass (so, nClasses = 3)

#dentro so_c ci sono molte cose, il modello con i punti usati, la parte della mappa ecc. 
#nel plottaggio quello che io voglio plottare è solo la mappa
#devo legare so_c alla mappa
plot(so_c$map)
#il training set è stato selezionato automaticamente (1000pixel) -tra pc e pc il risultato potrebbe essere diverso.
#per farei in modo che la class sia sempre uguale nel nostro pc usiamo una funzione che si chiama set.seed
set.seed(42)

#proviamo con un numero di classi molto alto
so_c20 <- unsuperClass (so, nClasses = 20)
