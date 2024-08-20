###############################################
###################### read SOCTA 2021 files
###############################################

library(readxl)
library(tidyverse)
library(rJava)
library(xlsx)


################# location of files

repository_input  <- "C:/Users/449322588/OneDrive - Office 365 GPI/Documenten/SOCTA/Input/"  
repository_output <- "C:/Users/449322588/OneDrive - Office 365 GPI/Documenten/SOCTA/Output/"

SOCTAfileNames <-list.files(repository_input) # file names of the excel files - to loop over all of them later
# strip the file names to just the crime area - to be used as rownames later
SOCTAcrimeArea <- SOCTAfileNames %>% 
  str_remove("SOCTA_2021_QUEST_EU_BE_SOC_AREA - ") %>% 
  str_remove(".XLSX")%>% 
  str_remove(".xlsx")

################# picklists for the structured data (descriptive and threat indicators)

AssessScale <- data.frame(code=c("High","Medium","Low","Unknown","Nil"),
                          codeVal=c(7,5,2,1,0))

mySheets <-c("Resources","Demand-Supply","Evolution","Geo Dimension","Expertise","Level Cooperation","Adaptability","External Violence","LBS","Money Laundering","ID Fraud","corruption","countermeasures","financial impact","social impact","health impact","security impact","political impact","environmental impact")
myIndicator <- c("Q03a","Q04a","Q05a","Q06a","Q10a","Q11a","Q12a","Q13a","Q14a","Q15a","Q16a","Q17a","Q18a","Q22b","Q23b","Q24b","Q25b","Q26b","Q27b") 

myCellsLabelsFreeText <-c("on SOC area","National Priority","Demand & Supply","Evolution","Future Evolution","Geo Dimension HOW","Geo Dimension WHERE","Crime Areas","Links with Terro","Calculation number OCGS","Calculation number OCGS changes","Nationalities OCGS leading",
                          "Nationalities OCGS assist","Birth/Citizenship OCGS","Expertise","Cooperation","Adaptability/Flexibility","External Violence","LBS","Money Laundering","Identity/Document Fraud","Corruption","Countermeasures",
                          "Modi Operandi Main","Modi Operandi Change","Modi Operandi Change Reason","Modi Operandi Future","Modi Operandi Future Reason","Transport and Trade Infrastructure","Technology and Digital Infrastructure",
                          "Financial/Economic Impact","Financial/Economic Impact Other","Social Impact","Social Impact Other","Health Impact","Health Impact Other","Security Impact","Security Impact Other","Political Impact",
                          "Political Impact Other","Environmental Impact","Environmental Impact Other","Environmental Impact","Environmental Impact Future","Sociological Situation", "Sociological Situation Future","Geopolitical Situation",
                          "Geopolitical Situation Future","Evolution of Transport and Trade Infrastructure","Evolution of Transport and Trade Infrastructure Future","Innovation and New Technologies","Innovation and New Technologies Future",
                          "Legislation","Legislation Future","National Strategies","National Strategies Future","Law Enforcement Activity","Law Enforcement Activity Future","EU Crime Priorities Set by EU Council","EU Crime Priorities Set by EU Council Future")

myIndicatorFreeText <-c("info","Q01b","Q04b","Q05b","Q05c","Q06b","Q06e","Q07a","Q07c","Q08c","Q08d","Q09b","Q09d","Q09f","Q10b","Q11b","Q12b","Q13b","Q14b",
                        "Q15b","Q16b","Q17b","Q18b","Q19a","Q19b","Q19c","Q19d","Q19e","Q20a","Q21a","Q22c","Q22d","Q23c","Q23d","Q24c","Q24d","Q25c","Q25d",
                        "Q26c","Q26d","Q27c","Q27d","Q28a","Q28b","Q29a","Q29b","Q30a","Q30b","Q31a","Q31b","Q32a","Q32b","Q33a","Q33b","Q34a","Q34b","Q35a","Q35b","Q36a","Q36b")

################################################

### loop over all sheets (mySheets = names of picklists; all picklists are on separate sheets in each excel file)
for (xx in 1:length(mySheets)){
  
  ### use the first Excel-file [1] and put (for every sheet = for every picklist) the values of field a1 to a6 into a column  
  picklist <- read_excel(paste(repository_input,SOCTAfileNames[1],sep=""), sheet=paste("Picklist ",mySheets[xx],sep=""), range="a1:a6")
  
  ### merge the column with the other two columns defined in AssessScale
  picklist <- bind_cols(picklist,AssessScale)
  
  ### assign a name to each column
  colnames(picklist)<-paste(myIndicator[xx],c("_lab","_code","_val"),sep="")
  
  ### assign a name to the new picklist
  eval(parse(text=paste("picklist_",myIndicator[xx],"<-picklist",sep=""))) 
}



######################################
#### LOAD the data of all individual excel files
######################################

### initiation : empty data frame
SOCTAdata <- data.frame()

myCells <-c("g50","g68","g75","g84","g169","g175","g181","g187","g202","g208","g214","g220","g226","l266","l285","l306","l325","l343","l359")
myCellsFreeText <-c("L22","l29","l68","l75","g77","l84","g107","g113","l115","g127","l127","l132","l143","l154","l169","l175","l181","l187","l202","l208","l214","l220","l226","g233","g237","l237","g241","l241","g249","g255","g277","l277",
                    "g298","l298","g316","l316","g335","l335","g351","l351","g367","l367","g383","l383","g389","l389","g395","l395","g401","l401","g407","l407","g413","l413","g419","l419","g425","l425","g431","l431")


### loop over all SOCTA files in repository
for (i in 1:length(SOCTAfileNames)){
  
  ### A. loop over all cells with structured data (myCells) in each SOCTA file in repository
  for (j in 1:length(myCells)){
    
    ### Assign the value of each cell to variable 'val'     
    val <-names(read_excel(paste(repository_input,SOCTAfileNames[i],sep=""), range = paste(myCells[j],":",myCells[j],sep="")))
    
    ### Put the value of each none-empty cell into a column in the data frame     
    if(length(val)>0) {
      SOCTAdata[i,paste(myIndicator[j],"_lab",sep="")] <- val  
    } 
  }
  
  
  ### B. loop over all free text fields (myCellsFreeText) 
  for (k in 1:length(myCellsFreeText)){
    
    ### Assign the value of each cell to variable 'val' 
    val <-names(read_excel(paste(repository_input,SOCTAfileNames[i],sep=""), range = paste(myCellsFreeText[k],":",myCellsFreeText[k],sep="")))
    
    ### Put the value of each none-empty cell into a column in the data frame
    if(length(val)>0) {
      SOCTAdata[i,paste(myIndicatorFreeText[k],"_text",sep="")] <- val  
    } else {
      SOCTAdata[i,paste(myIndicatorFreeText[k],"_text",sep="")] <- "No answer"
    }
  }
  
}

######## for every picklist-value read from the Excel-file, 
######## add also the corresponding code(high, medium, low, ...) and the corresponding score (7,5,2, ...) as extra variables

for (u in 1:length(myIndicator)) {
  join_data <- eval(parse(text = paste0("picklist_", myIndicator[u])))
  join_column <- paste0(myIndicator[u], "_lab")
  SOCTAdata <- SOCTAdata %>% 
    left_join(join_data, by = join_column)
}


##################################################################################
### EXPORT STRUCTURED DATA
##################################################################################
# each row contains info of one excel document, one crime area. Assign as rowname the crime area
rownames(SOCTAdata) <-SOCTAcrimeArea

### split the info over 3 separate dataframes: scores (7,5,2, ...), codes (high, medium, low, ...), and the original label in the picklist 
SOCTAdata_scores                 <- SOCTAdata[,str_detect(colnames(SOCTAdata),"_val")]
SOCTAdata_scores_codes           <- SOCTAdata[,str_detect(colnames(SOCTAdata),"_code")]
SOCTAdata_scores_labels            <- SOCTAdata[,str_detect(colnames(SOCTAdata),"_lab")]

### name the columns in the new data frame according to the names of the picklists
colnames(SOCTAdata_scores)       <- mySheets
colnames(SOCTAdata_scores_codes) <- mySheets
colnames(SOCTAdata_scores_labels)  <- mySheets

###write_csv(SOCTAdata_scores, "C:/Users/449322588/OneDrive - Office 365 GPI/Documenten/SOCTA/Output/test.csv")
### Export the data to one Excel file with 4 sheets

## Create new Excel workbook 'wb'
wb      <- createWorkbook()

## Create four new sheets in workbook 'wb'
sheet1  <- createSheet(wb, "scores")
sheet2  <- createSheet(wb, "codes")
sheet3  <- createSheet(wb, "lab")
sheet4  <- createSheet(wb, "all_info")

## Add data to new sheets
addDataFrame(SOCTAdata_scores,         sheet=sheet1, startColumn=1, row.names=TRUE)
addDataFrame(SOCTAdata_scores_codes,   sheet=sheet2, startColumn=1, row.names=TRUE)
addDataFrame(SOCTAdata_scores_labels,  sheet=sheet3, startColumn=1, row.names=TRUE)
addDataFrame(SOCTAdata,                sheet=sheet4, startColumn=1, row.names=TRUE)

## Remove letters from indicators (i.e. Q03a → Q03)
myIndicator_nr <- str_remove_all(myIndicator,"[abcd]")

######################################Old code
##for (i in 1:length(myIndicator_nr)){
##  Question_group <- SOCTAdata[,str_detect(colnames(SOCTAdata),myIndicator_nr[i])]
##  eval(parse(text= paste("sheet_",myIndicator_nr[i]," <- createSheet(wb,paste(myIndicator_nr[i],mySheets[i]))",sep="")))
##  eval(parse(text= paste("addDataFrame(Question_group,   sheet=sheet_",myIndicator_nr[i]," , startColumn=1, row.names=TRUE)",sep="")))          
##}
######################################New code
## loop over array myIndicator (seq_along is better alternative for 1:length(array) as it disregards empty arrays)
for (i in seq_along(myIndicator_nr)) {
  
  ## assign each column with data from one indicator (Q03, Q04, Q05,...) from data frame SOCTAdata to a new data frame 'Question_group'
  Question_group <- SOCTAdata[, str_detect(colnames(SOCTAdata), myIndicator_nr[i])]
  
  ## new name for each sheet (i.e. "Q03 Resources") as temporary variable
  sheet_name <- paste(myIndicator_nr[i], mySheets[i])
  
  ## assign new sheet in workbook 'wb' to new variable 'sheet' 
  sheet <- createSheet(wb, sheet_name)
  
  ## assign new name to sheet 'sheet' (i.e. sheet_03a)
  assign(paste0("sheet_", myIndicator_nr[i]), sheet, envir = .GlobalEnv)
  
  ## assign each data frame 'Question_group' to a sheet
  addDataFrame(Question_group, sheet = sheet, startColumn = 1, row.names = TRUE)
}

saveWorkbook(wb, paste(repository_output,"SOCTAdata.structured.xlsx"))

##################################################################################
### EXPORT UNSTRUCTURED DATA (open questions)
##################################################################################
### assign all the values related to the free text fields in the large data frame 'SOCTAdata' to new data frame 'SOCTAdata_text' 

SOCTAdata_text <- SOCTAdata[,str_detect(colnames(SOCTAdata),"_text")]

### name the columns in the new data frame according to the names of the open ended questions
colnames(SOCTAdata_text) <- myCellsLabelsFreeText

### new variable for the number of columns in new dataframe 'SOCTAdata_text'
n_items <- length(colnames(SOCTAdata_text))

### instantiate string with path for new markdown file SOCTAFreeText.Rmd
myCon<-paste(repository_output,"SOCTAFreeText.Rmd", sep="")

### create heading for Markdown document
cat(text='---',file=myCon, sep="\n \n",append=TRUE) 
cat(text='title: "CreateSOCTAfreeTextRmd"',file=myCon, sep="\n \n",append=TRUE) 
cat(text='output:',file=myCon, sep="\n \n",append=TRUE)
cat(text='  word_document:',file=myCon, sep="\n \n",append=TRUE)
cat(text='    reference_docx: "C:/Users/449322588/OneDrive - Office 365 GPI/Documenten/SOCTA/All GPI Document long_NL.docx"',file=myCon, sep="\n \n",append=TRUE)
cat(text='---',file=myCon, sep="\n \n",append=TRUE)
cat(text="   ",file=myCon, sep="\n \n",append=TRUE)

## Add Title heading for Word document
cat(text='# SOCTA 2021',file=myCon, sep="\n \n",append=TRUE) 

### loop over the columns in data frame 'SOCTAdata_text'
for (i in 1:length(colnames(SOCTAdata_text))){
  
  ### add the given name of each text field to the file as a title    
  cat(text=paste("## ",myCellsLabelsFreeText[i]),file=myCon, sep="\n \n",append=TRUE)
  cat(text=" ",file=myCon, sep="\n",append=TRUE)
  
  ### loop over all the rows in each column in data frame 'SOCTAdata_text'
  for (j in 1:nrow(SOCTAdata_text)){
    
    ### add the names of the phenomena as a subtitle underneath each title
    cat(text=paste("### ",SOCTAcrimeArea[j]),file=myCon, sep="\n \n",append=TRUE)
    cat(text=" ",file=myCon, sep="\n",append=TRUE)
    
    ### add the value of each field in the data frame 'SOCTAdata_text' underneath each subtitle
    ### attention: for calling a field in a data frame use following syntax: DataFrame[Row, Column]
    cat(text=SOCTAdata_text[j,i],file=myCon, sep="\n \n",append=TRUE)
    cat(text=" ",file=myCon, sep="\n",append=TRUE)
  }
}








