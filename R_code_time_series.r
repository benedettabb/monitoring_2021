#time series analysis. greeenland increas of temperature. data and code from Emanuela Cosma
library(raster)
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
rlist

#aaplico la funzione lapply (alla listaX, raster). lapply è una funzione che mi permette di applicare una funzione ad una lista
import <- lapply (rlist, raster)
