#time series analysis. greeenland increas of temperature. data and code from Emanuela Cosma
library(raster)
library(rasterVis)
library(rgdal)

setwd ("C:/lab/greenland_data")
#andiamo a creare uno stack di raster - da aratro, con pixel. 
#insieriamo dei dati lst (Land Surface Temperature) di copernicus, per la stima della temperatura
#sono misure medie negli anni considerati. vengono dal MODIS
#grandezza pixel 100/200m; ma altra risoluzione temporale (4immagini al giorno)

#devo utilizzare una funzione per caricare i singoli dati, non più un insieme di dat

lst_2000 <- raster ("lst_2000.tif")
lst_2005 <- raster ("lst_2005.tif")
lst_2010 <- raster ("lst_2010.tif")
lst_2015 <- raster ("lst_2015.tif")
plot (lst_2000)
plot (lst_2005)
plot (lst_2010)
plot (lst_2015)
#immagini a 8 bit (da 0 a 255)
2^8
2^16 #65535, da 0 a 65534. questa è la mia immagine
lst_2000
#vedo che i valori totali sono 4428595; la mia immagine viene convertita in bit - i valori sono meno (quindi alcuni pixel avranno valori uguali)
#con i metadati si può ripassare dai bit ai valori di riflettanza misurati

#le visualizzo tutte insieme
par (mfrow=c(2,2))
plot (lst_2000)
plot (lst_2005)
plot (lst_2010)
plot (lst_2015)

#creo una lista - il pattern è ciò che gli elementi hanno in comune
rlist <- list.files (pattern= "lst")

#aaplico la funzione lapply (alla listaX, raster). lapply è una funzione che mi permette di applicare una funzione ad una lista
import <- lapply (rlist, raster)


#unisco i file tutti insieme
TGr <- stack(import)


plotRGB (TGr, 1,2,3, stretch="Lin")
plotRGB (TGr, 4,3,2, stretch="Lin")

#IL LEVELPLOT è molto più bello. prova
#il plot normale mette su ongi mappa la legenda, le coordinate sono piccole, la gamma di colori è più più piccola
levelplot(TGr)

#metto insime l'immagine totale e quella del 2000
levelplot(TGr$lst_2000)
 
#i warnings non sono errrori. ingorali ah. qui mi fa degli warnings perchè il nome delle immagini inizia con un numero
#r non è contento, quindi inserisce una X
#stabilisco una color ramp palette
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)

#applico la colour ramp palette
levelplot(TGr, col.regions=cl,  #quando uso il level plot per applicare la palette devo scrivere col.regions
  #aggiungo un argomento: nome degli attributi, cioè delle signole immagini
  names.attr=c("July 2000","July 2005", "July 2010", "July 2015"),
  #aggiungo un secondo attributo -titolo
  main = "LST variation in time")


#quantità di scioglimento! tra il 79 e il 2007 (visto che le immagini sono dentro lo stack chiamato melt, quando le prendo devo sempre collegarle allo stack così$)
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt

#faccio una nuova palette
clb <- colorRampPalette(c("blue","white","red"))(100)

#plotto la nuova immagine
plot(melt_amount, col.regions=clb)





 


