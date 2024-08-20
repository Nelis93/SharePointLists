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
##  str_remove("SOCTA_2021_QUEST_EU_BE_SOC_AREA - ") %>% 
  str_remove("SOCTA_2025_QUEST_EU_MS_SOC_AREA_") %>% 
  str_remove(".XLSX")%>% 
  str_remove(".xlsx")

################# picklists for the structured data (descriptive and threat indicators)

AssessScale <- data.frame(code=c("High","Medium","Low","Unknown","Nil"),
                          codeVal=c(7,5,2,1,0))

mySheets <-c("Resources","Demand-Supply","Evolution","Geo Dimension","Expertise","Level Cooperation","Adaptability","LBS","Money Laundering","ID Fraud","corruption","Violence","countermeasures","financial impact","social impact","health impact","security impact","political impact","environmental impact")

myCellsLabelsFreeText <-c("Type of information used","National Priority","Investigations 2020","Investigations 2021","Investigations 2022","Investigations 2023","Modi Operandi","Modi Operandi: Crime-as-a-Service","Modi Operandi: Underage suspects",
                          "Modi Operandi: Changes","Modi Operandi: Changes - Reason","Modi Operandi: Future Changes","Modi Operandi: Future Changes - Reason","Demand & Supply","Evolution of the Crime Area","Geographical Distribution",
                          "Geographical Distribution - Crime Hotspots","Geographical Distribution - Other Countries","Links to other Crime Areas","Links to other Crime Areas - Terrorism","Links to other Crime Areas - Hybrid threats",
                          "Number of Criminal Networks Active in the Crime Area - Changes","Leading members of the main criminal networks","Criminal network members with facilitating roles","Country of birth differs from nationality",
                          "Sophistication of the Expertise","Cooperation of the Criminal Networks active in the Crime Area","Adaptability of the Criminal Networks in the Crime Area","Types of LBS","Abuse of different types of LBS",
                          "LBS - Countries and key locations","Money Laundering Techniques","Money Laundering - Countries and key locations","Use of identity/document fraud in the crime area","Corruptive techniques by type of target",
                          "Violence and/or intimidation in the crime area","Violence and/or intimidation in the crime area - Countries and key locations","Countermeasures","Use of logistical infrasturcture","Use of Technologiecal and Digital infrasturcture",
                          "Economic situation - Changes","Economic situation - Future Changes","Sociological situation - Changes","Sociological situation - Future Changes","Geopolitical situation - Changes","Geopolitical situation - Future Changes",
                          "Transport and Trade infrastructure - Changes","Transport and Trade infrastructure - Future Changes","Innovation and new Technologies - Changes", "Innovation and new Technologies - Future Changes","Legislation - Changes",
                          "Legislation - Future Changes","National Strategies","National Strategies - Future Changes","Law Enforcement Activity","Law Enforcement Activity - Future Changes","Financial/Economic Impact","Social Impact","Health Impact",
                          "Security Impact","Political Impact","Impact on the Physical Environment")

myIndicator <- c("Q04a","Q05a","Q06a","Q07a","Q11a","Q12a","Q13a","Q14a","Q15a","Q16a","Q17a","Q18a","Q19a","Q31b","Q32b","Q33b","Q34b","Q35b","Q36b") 

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

myCells <-c("g73","g90","g96","g103","g186","g192","g198","g207","g226","g248","g254","g262","g276","l357","l376","l397","l415","l433","l449")

myCellsFreeText <-c("L22","l29","l36","l38","l40","l42","G51","G55","K59","G63","K63","G67","K67","K90","K96","K103","G121","G123","K129","K133","K135","L148",
                    "K154","K165","K176","K186","K192","K198","K207","K209","K211","K228","K232","K248","G256","K262","G270","K276","G282","G288","G297",
                    "L297","G303","L303","G309","L309","G315","L315","G321","L321","G327","L327","G333","L333","G339","L339","G368","G389","G407","G425","G441","G457")

myIndicatorFreeText <-c("info","Q01b","Q02b","Q02d","Q02f","Q02h","Q03a","Q03b","Q03d","Q03e","Q03f","Q03g","Q03h","Q05b","Q06b","Q07b","Q07e","Q07f","Q08b","Q08d","Q08f","Q09f",
                        "Q10b","Q10d","Q10f","Q11b","Q12b","Q13b","Q14b","Q14c","Q14e","Q15c","Q15e","Q16b","Q17b","Q17c","Q18b","Q18d","Q19b","Q20","Q21","Q22a","Q22b","Q23a","Q23b",
                        "Q24a","Q24b","Q25a","Q25b","Q26a","Q26b","Q27a","Q27b","Q28a","Q28b","Q29a","Q29b","Q30a","Q31c","Q32c","Q33c","Q34c","Q35c","Q36c")
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

## Remove letters from indicators (i.e. Q03a ==> Q03)
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

saveWorkbook(wb, paste(repository_output,"SOCTAdataStructured.xlsx"))

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
cat(text='# SOCTA 2025',file=myCon, sep="\n \n",append=TRUE) 

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








