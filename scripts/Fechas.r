#install.packages("dplyr")
#install.packages("ggplot2")
#install.packages("lubridate")
#install.packages("xlsx")
library("lubridate")
#library("xlsx")
library("dplyr")
#library("ggplot2")


Inhabil<-read.table(file = "Inhabil.txt",header=TRUE,sep = "\t",stringsAsFactors = FALSE)
Inhabil$DIA <- ymd(Inhabil$DIA)
str(Inhabil)

DiaInhabil<- function(x,UNAM=TRUE,I=Inhabil,fin=TRUE,vaca=FALSE){
  if(class(x)!="Date"){
    warning("El valor no es tipo 'Date'")
    return(NA)
  }
  r<-FALSE
  r<-r[-1]
  
  for(i in 1:length(x)){
    r[i]<-FALSE
    if( (fin & (format(x[i],"%a") %in% c("Sat","Sun")) ) | (UNAM & x[i]%in%I$DIA) | (!UNAM & x[i]%in%I$DIA[I$GENERAL %in% c(1)]) |
        (vaca & x[i]%in%I$DIA[I$VACAUNAM %in% c(1)])){
      r[i]<-TRUE
      next()
    } else {
      next()
    }
  }
  return(r)
}

# Rango de fechas ####

x <- data.frame(DIA = seq(ymd("20210101"), ymd("20251231"), by = "day"))

# Fecha de entrega #####
x$habil <- !DiaInhabil(x$DIA)
x

SS <- data.frame(ENTREGA=x$DIA[x$habil])


# Fechas de inicio ####
SS$INICIO<-SS$ENTREGA

for(i in 1:dim(SS)[1]){
  j<-0
  k<-0
  while(j<10){
    k<-k+1
    if(!DiaInhabil(SS$ENTREGA[i]+k)){
      j<-j+1
    }
  }
  SS$INICIO[i]<-SS$ENTREGA[i]+k
}

# Fecha de término mínima no UNAM ####
SS$TERMINOnoUNAM<-SS$ENTREGA

for(i in 1:dim(SS)[1]){
  l<-seq(SS$INICIO[i],by="month",length.out = 7)[7]

  while(DiaInhabil(l,UNAM = FALSE)){
    l<-l+1
  }

  SS$TERMINOnoUNAM[i]<-l
}

# Fecha de término máxima no UNAM ####
SS$MAXnoUNAM<-SS$ENTREGA

for(i in 1:dim(SS)[1]){
  l<-seq(SS$INICIO[i],by="year",length.out = 2)[2]
  l<- l-1
  while( DiaInhabil(l,UNAM = FALSE) ){
    l<-l-1
  }
  
  SS$MAXnoUNAM[i]<-l
}


# Fecha de término mínima UNAM ####
SS$TERMINOUNAM<-SS$ENTREGA


for(i in 1:dim(SS)[1]){
  l<-seq(SS$INICIO[i],by="month",length.out = 7)[7]
  
  ex <- sum( DiaInhabil(seq(SS$INICIO[i],l,by="day"),fin=FALSE) )
  
  while( DiaInhabil(l) ){
    l<-l+1
  }
  
  j<-0
  k<-0
  while(j<ex){
    k<-k+1
    if(!DiaInhabil(l+k)){
      j<-j+1
    }
  }
  
  l<-l+k
  
  while( DiaInhabil(l) ){
    l<-l+1
  }
  
  SS$TERMINOUNAM[i]<-l
}

# Fecha de término máxima UNAM ####
SS$MAXUNAM<-SS$ENTREGA

for(i in 1:dim(SS)[1]){
  l<-seq(SS$INICIO[i],by="year",length.out = 2)[2]
  l<- l-1
  while( DiaInhabil(l) ){
    l<-l-1
  }
  
  SS$MAXUNAM[i]<-l
}


# Exportar fehcas ####
#write.xlsx(SS,file = paste("Fechas SS",format(SS$ENTREGA[1],"%d %b %Y"),"a",format(SS$ENTREGA[dim(SS)[1]],"%d %b %Y"),".xlsx"),
#           sheetName = "Fechas",row.names = FALSE,showNA = FALSE )

write.table(SS,file = paste("Fechas SS",format(SS$ENTREGA[1],"%d %b %Y"),"a",format(SS$ENTREGA[dim(SS)[1]],"%d %b %Y"),".txt"),
            row.names = FALSE,sep = "\t")

format(SS$ENTREGA[1],"%d %b %Y")
str(SS)


SS$INICIO %in% SS$ENTREGA
SS$ENTREGA %in% SS$INICIO

# Días hábiles ####
D_h <- data.frame(
  DIA=seq(ymd("20220131"), ymd("20270901"), by="day"))

D_h$UNAM <- as.numeric( !DiaInhabil(D_h$DIA))
D_h$NOUNAM <-as.numeric( !DiaInhabil(D_h$DIA,UNAM=FALSE) )
D_h

write.table(D_h,file = paste0("Dias habiles ",format(D_h$DIA[1],"%d %b %Y")," a ",format(D_h$DIA[dim(D_h)[1]],"%d %b %Y"),".txt"),
            row.names = FALSE,sep = "\t")

#SS$TERMINOUNAM7<-SS$ENTREGA
#for(i in 1:dim(SS)[1]){
#  l<-seq(SS$INICIO[i],by="month",length.out = 8)[8]
#  
#  while( DiaInhabil(l,UNAM = FALSE) ){
#    l<-l+1
#  }

#  SS$TERMINOUNAM7[i]<-l
#}


#SS$TERMINOUNAM120<-SS$ENTREGA


#for(i in 1:dim(SS)[1]){
#  j <- 0
#  k <- 0
#  while(j<120){
#    k<-k+1
#    if(!DiaInhabil(SS$INICIO[i]+k)){
#      j<-j+1
#    }
#  }
#  SS$TERMINOUNAM120[i]<-SS$INICIO[i]+k
#}

#SS

#j<-0
#for(i in 1:dim(SS)[1]){
#  if(SS$TERMINOUNAM7[i]<SS$TERMINOUNAM120[i]){
#    j<-j+1
#  }
#}
