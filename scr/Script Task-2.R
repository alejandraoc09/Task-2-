

#Taller de R: estadistica y programacion
#Lunes, 26 de abril del 2021
#----------------------------------------------------------------------------------
#Nombres y codigos:
#                  -> Alejandra Orellanos Camargo // 201913577
#                  -> Maria Jose Rivera Chavez // 201914133
#----------------------------------------------------------------------------------

#Cargar y / o instalar paquetes
pacman :: p_load(readxl,haven,dplyr,plyr,data.table) 


##Punto 1.0
#Cargamos la lista con la funcion readRDS
#file.choose() con esta orden orden obtenemos el directorio del archivo 

lista_df <- readRDS(file ="C:\\Users\\ALEJANDRA ORELLANOS\\Desktop\\QUINTO SEMESTRE\\TALLER DE R\\lista.rds" )
length(lista_df)

##Punto 1.1
#Creamos una funcion que nos ayude a:
#                                       -> Elimar las filas con NA
#                                       -> Renombrar cada elemento de la lista
#                                       -> Dejar los nombres de las variables 
#                                       -> Pasar a miniscula en nombre de las
#                                          variables
   
J <- function(x){
            x = filter(x,!is.na(...2)) ; #Borramos las filas con NA
            Nombres = as.vector(x[1,]) ; #Tomamos y convertimos la fila 1
                                         #en un vector, para renombrar las 
                                         #variables.
            Nombres = tolower(Nombres);  #Convertimos los nombres a miniscula
            names(x) = Nombres;          #Renombramos las columnas
            x = x[-1,]                   #Borramos la primera fila
            return(x)}

#Usamos la funcion lapply, para aplicar la anterior funci�n a cada elemento de 
#la lista

lista_df_1 <- lapply(lista_df,function(x) J(x))
lista_df_1[[66]] #Observamos un elemento de la lista

##Punto 1.2
#Obtenemos el nombre de cada elemento de la lista en un vector
Delitos <- as.vector(names(lista_df_1))
Delitos #Visualizamos el tipo de delitos en la consola

#Creamos un ciclo para agregar la variable tipo delito a cada elemento de 
#la lista

##Inicializamos una lista sin elementos del tama�o del vector delitos
lista_df_2 <- vector("list", length(Delitos))

##Creamos un ciclo para crear la variable en cada elemento de la lista
for (i in seq_along(Delitos)) {
  lista_df_2[[i]] <- mutate(lista_df_1[[i]],tipo_delito = Delitos[[i]])
}

lista_df_2[[66]] #Obervamos un elemento

##Punto 1.3
#vamos a revisar, si todos los elementos de la lista son de la misma dimensi�n
lapply(lista_df_2,dim)

#Dado que no tienen las mismas dimensiones, agregamos la opci�n
#use.names y fill en la funcion rbindlist, para unir por nombres y completar con NA
#las columnas faltantes

df <- rbindlist (lista_df_2,use.names = TRUE,fill = TRUE)
dim(df) #Verificamos la dimension del data frame

#2.Familia apply (30% nota)
##Punto 2.1. 
lapply(df,table) #Con esto imprimimos las tablas de frecuencia en la
                 #consola.

#3. Lapply 

##Punto 3.1

JJ <- function(x){
                   if (is.character(x) == TRUE) # Si es un car�cter
                  {
                    x = tolower(x) #Convierte a minusculas el vector
                    return(x)      #Retorna nuevo vector x creado.
                    }  
                    if (is.character(x) == FALSE) # Si no es un caracter
                    
                 {
                   x = x #Retorna el mismo vector sin transformar
                    }
}

##Punto 3.2
df_2 <- df #Creo una copia del data frame original, para poder comparar

#Usando un ciclo, aplicamos a cada columna la funcion JJ
for (i in seq_along(df)) {
  df_2[[i]] <- JJ(df[[i]])
}

head(df_2) #Variables de caracter en minuscula
head(df)   #Variables originales





















