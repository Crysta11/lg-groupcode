install.packages("raster")
install.packages("rgdal")
require(raster)
require(rgdal)
##Assign where QRULE is saved and can be executed

Qrule_exe<-paste("C:\\Users\\nba52\\Desktop\\QRULE\\QruleV4.exe")


##Set working directory to where you want files to call from and save too

setwd("C:\\Users\\nba52\\Desktop\\QRULE\\")
path<-"C:\\Users\\nba52\\Desktop\\QRULE" 


##iterative contagion values-impacts how the cells are clustered

Hvalues<-c(.1,.2,.3,.4,.5,.6,.7,.8,.9)

##iterative amounts of habitat 

p1values<-c(.1,.2,.3,.4,.5,.6,.7,.8,.9)

##Execute all combinations of contagion and habitat probabilities
Perms<-c(1:10)      #10 Permutations per map configuration
Perms
for(k in 1:length(Perms)){
  
  for(i in 1:length(Hvalues)){
    Map<-"M"
    Level<-9
    Contagion<-Hvalues[i]
    Wrap<-"F"
    neg.seed<--634535
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
    
     }
  
  }
  
}

##import the maps int ArcMaps, then ASCII to Raster function

##convert text maps into an imagine raster
##save raster in a new folder; "Rasterized_Maps"

setwd("C:\\Users\\nba52\\Desktop\\QRULE\\Maps\\")
Maps<-list.files()
Maps
for(i in 1:length(Maps)){
  map<-raster(Maps[i])
  writeRaster(map,paste(c(getwd(),Maps[i],".img"),sep="",collapse=""),format="HFA")
}
