install.packages("raster")
install.packages("rgdal")
require(raster)
require(rgdal)
##Assign where QRULE is saved and can be executed

Qrule_exe<-paste("C:\\Users\\Nathan\\Desktop\\LDGProject\\QRULE\\QruleV4.exe")


##Set working directory to where you want files to call from and save too

setwd("C:\\Users\\Nathan\\Desktop\\LDGProject\\QRULE\\")
path<-"C:\\Users\\Nathan\\Desktop\\LDGProject\\QRULE" 


##iterative contagion values-impacts how the cells are clustered

Hvalues<-c(.2,.5,.8)

##iterative amounts of habitat 

p1values<-c(.2,.5,.8)

##Execute all combinations of contagion and habitat probabilities
Perms<-c(2:10)      #10 Permutations per map configuration
Perms
for(z in 1:length(Perms)){

  for(i in 1:length(Hvalues)){
    Map<-"M"
    Level<-9
    Contagion<-Hvalues[i]
    Wrap<-"F"
    neg.seed<--z^z^z
    neighbor<-2
    MapClass<-1

      for(j in 1:length(p1values)){
        p1<-p1values[j]
        p2<-1-p1values[j]
        reps<-1
        MapOut<-"G"
        Name<-paste(c("Trial",Perms[k],"Cont",Hvalues[i],"Hab",p1values[j]),sep="",collapse="")
        Analysis<-"N"
        Res<-30
    
        Qinput<-c(Map,Level,Contagion,Wrap,neg.seed,neighbor,MapClass,
                  p1,p2,reps,MapOut,paste(c(Name,".txt"),sep="",collapse=""),Analysis,Res)
    
        system(Qrule_exe,input=Qinput)
    
    ## rename the arcgrid.map file so that it won't be overwritten
    
    file.rename("arcgrid.map", paste("Maps\\",Name,sep="",collapse=" "))
Name    
     }
  
  }
  
}

##import the maps int ArcMaps, then ASCII to Raster function

##convert text maps into an imagine raster
##save raster in a new folder; "Rasterized_Maps"

setwd("C:\\Users\\Nathan\\Desktop\\LDGProject\\QRULE\\Maps\\")
Maps<-list.files()
Maps
for(i in 1:length(Maps)){
  map<-raster(Maps[i])
  writeRaster(map,paste(c(getwd(),Maps[i],".img"),sep="",collapse=""),format="HFA")
}
