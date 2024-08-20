###############################################
###################### read SOCTA 2021 files
###############################################

library(readxl)
library(tidyverse)
library(rJava)
library(xlsx)


################# location of files

repository_input  <- "C:/Users/449322588/Documents/R/MatchCrimOrgSocta/Input/"  
repository_output <- "C:/Users/449322588/Documents/R/MatchCrimOrgSocta/Output/"

###List of files in the repository (single file for this purpose)
FileNames <-list.files(repository_input) 


### loop over all crimorg in column C

CrimOrgArray <- read_excel(paste(repository_input,FileNames[1],sep=""), sheet="Racketeering", range="c5:c14", col_names = FALSE)
CrimOrgArray <- CrimOrgArray[[1]]

### loop over all Modi Operandi in row 3

ModiOperandiArray <- read_excel(paste(repository_input,FileNames[1],sep=""), sheet="Racketeering", range="d3:bz3", col_names = FALSE)
ModiOperandiArray <- ModiOperandiArray[1, ] 

###initiate data frame
MatrixData <- data.frame(matrix(ncol = length(ModiOperandiArray), nrow = length(CrimOrgArray)))
colnames(MatrixData) <- ModiOperandiArray
rownames(MatrixData) <- CrimOrgArray

###for (i in 1:length(ModiOperandiArray)){
###  colnames(MatrixData) <- ModiOperandiArray[i]
###}

### Assign the value of each cell to variable 'val' 
val <- read_excel(paste(repository_input, FileNames[1], sep=""), sheet="Racketeering", range = "d5:bz38", col_names = FALSE)

### loop over all free text fields 
for (xx in 1:length(CrimOrgArray)) {
  for (yy in 1:length(ModiOperandiArray)) {
    if (!is.na(val[xx, yy])) {
      MatrixData[xx, yy] <- val[xx, yy]
    } else {
      MatrixData[xx, yy] <- "No answer"
    }
  }
}

### instantiate string with path for new markdown file SOCTAFreeText.Rmd
myCon<-paste(repository_output,"SOCTAFreeText.Rmd", sep="")

### create heading for Markdown document
cat(text='---',file=myCon, sep="\n \n",append=TRUE) 
cat(text='title: "CreateSOCTAfreeTextRmd"',file=myCon, sep="\n \n",append=TRUE) 
cat(text='output:',file=myCon, sep="\n \n",append=TRUE)
cat(text='  word_document:',file=myCon, sep="\n \n",append=TRUE)
cat(text='    reference_docx: "C:/Users/449322588/Documents/R/MatchCrimOrgSocta/All GPI Document long_NL.docx"',file=myCon, sep="\n \n",append=TRUE)
cat(text='---',file=myCon, sep="\n \n",append=TRUE)
cat(text="   ",file=myCon, sep="\n \n",append=TRUE)

## Add Title heading for Word document
cat(text='# Racketeering',file=myCon, sep="\n \n",append=TRUE) 

### loop over the columns in data frame 'MatrixData'
for (i in 1:length(colnames(MatrixData))){
  
  if (!all(MatrixData[[i]] %in% c("No answer", "X", NA))) {

  ### add the given name of each text field to the file as a title    
  cat(text=paste("## ",ModiOperandiArray[i]),file=myCon, sep="\n \n",append=TRUE)
  cat(text=" ",file=myCon, sep="\n",append=TRUE)
  
  ### loop over all the rows in each column in data frame 'MatrixData'
    for (j in 1:nrow(MatrixData)){
      
      if(MatrixData[j,i] != "No answer" & MatrixData[j,i] != "X" & MatrixData[j,i] != ""){
  
        ### add the names of the Modi Operandi as a subtitle underneath each title
        cat(text=paste("### ",CrimOrgArray[j]),file=myCon, sep="\n \n",append=TRUE)
        cat(text=" ",file=myCon, sep="\n",append=TRUE)
        
        ### add the value of each field in the data frame 'MatrixData' underneath each subtitle
        ### attention: for calling a field in a data frame use following syntax: DataFrame[Row, Column]
        cat(text=MatrixData[j,i],file=myCon, sep="\n \n",append=TRUE)
        cat(text=" ",file=myCon, sep="\n",append=TRUE)
      }
    }
  }  
  
}
