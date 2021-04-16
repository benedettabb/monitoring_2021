
#crare un report di un codice
library(knitr)

setwd ("C:/lab/greenland_data")

#utilizzo la funzione stitch per fare il report del codice
stitch("R_time_series_greenland.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
