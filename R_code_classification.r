library(raster)


setwd ("C:/lab/sun")
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

so
#valori che vanno da 0 a 255. non sono bande originali ma quelle utilizzate per creare l'RGB

#facciamo un plot RGB
plotRGB (so,1,2,3, stretch = "lin")

