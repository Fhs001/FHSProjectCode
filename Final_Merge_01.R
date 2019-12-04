### R script of Data Merge ### 

### Read files into objects ----

    Spinal_Clinical_Data <- read.csv("~/Documents/University/FHS/Data/ws4_spinal_clinical_data.orig.csv") 
    Grampian_Clinical_Data <- read.csv("~/Documents/University/FHS/Data/Grampian_060619.csv")
    
    Focus1_Irinotecan_Baseline <- read.csv("~/Documents/University/FHS/Data/FOCUS1_Irinotecan_clinicaldata (1)/clinical_patient_raw_ws2_focus_irinotican_baseline.csv")
    Focus1_Irinotecan_Progression_fu <- read.csv("~/Documents/University/FHS/Data/FOCUS1_Irinotecan_clinicaldata (1)/clinical_patient_raw_ws2_focus_irinotican_progression_fu.csv")
    Focus1_Irinotecan_Survival <- read.csv("~/Documents/University/FHS/Data/FOCUS1_Irinotecan_clinicaldata (1)/clinical_patient_raw_ws2_focus_irinotican_survival.csv")
    Focus1_Irinotecan_Toxicity <- read.csv("~/Documents/University/FHS/Data/FOCUS1_Irinotecan_clinicaldata (1)/clinical_patient_raw_ws2_focus_irinotican_toxicity.csv")
    Focus1_Irinotican_Treatment <- read.csv("~/Documents/University/FHS/Data/FOCUS1_Irinotecan_clinicaldata (1)/clinical_patient_raw_ws2_focus_irinotican_treatment.csv")
    Focus1_Irinotecan_More <- read.csv("~/Documents/University/FHS/Data/FOCUS1_Irinotecan_clinicaldata (1)/FOCUS1_Irinotecan_ClinicalPrimary_240619-1.csv")
    
    Focus1_Clinical_Updated <- read.csv("~/Documents/University/FHS/Data/FOCUS1_Irinotecan_clinicaldata (1)/FOCUS1_Clinical_Updated_130519.csv")
    
    Old_Final_Merge <- read.csv("~/Documents/University/FHS/Data/Final_Merge_Clinical_Data.csv", row.names=1)
    
    NGS_Summary_Cols_Ordered <- read.csv("~/Documents/University/FHS/Data/Work_in_R/FHS/NGS_Summary_Cols_Ordered.cvs", row.names=1,)
    
    RNA_Expression_Signatures <- read.csv("~/Documents/University/FHS/Data/panSCORT_RNAexpr_signatures_220719.csv")
    Gene_CN_Data <- read.csv("~/Documents/University/FHS/Data/SCORT_CNA_200719.csv")
    NGS_Summary <- read.csv("~/Documents/University/FHS/Data/NGS_summary_210619_Laura.csv")
    
    Updated_Scort_Data <- read.csv("~/Downloads/panSCORT_271119.csv",  row.names =1,)
   
    
### Install packages ----
    
    # install.packages("dplyr")
    library(dplyr)
    # install.packages("plyr")
    library(plyr)
    # install.packages("Amelia")
    library(Amelia)
    
### Create consistent column orders ----
    
    Col_Order_Clinical <- c("Scort_ID", "Cohort", "Patient_ID", "Block_Source", "Sample_Type", "Gender", "Age", "WHO",
                            "Primary_Location", "Distant_Metastasis", "Liver_Met", "Nodal_Met", "Lung_Met", "Brain_Met",
                            "Peritoneal_Met", "Other_Met", "Specify_Met", "Treatment", "Primary_Radiotherapy", "Primary_Chemo",
                            "T_Stage", "N_Stage", "M_Stage", "Met_Surgery", "Met_Chemo", "OS_Status", "OS_Time", "PFS_Status",
                            "PFS_Time", "Response")
    
### Spinal clinical data ----
    
    ## Column headings, creating new columns where necessary
    
        colnames(Spinal_Clinical_Data) <- gsub("scort_id", "Scort_ID", colnames(Spinal_Clinical_Data))
        Spinal_Clinical_Data$Scort_ID <- as.character(Spinal_Clinical_Data$Scort_ID)
        
        Spinal_Clinical_Data$Cohort <- c("SPINAL")
        
        colnames(Spinal_Clinical_Data) <- gsub("patient_id", "Patient_ID", colnames(Spinal_Clinical_Data))
        Spinal_Clinical_Data$Patient_ID <- as.character(Spinal_Clinical_Data$Patient_ID)
        
        colnames(Spinal_Clinical_Data) <- gsub("sample_type", "Sample_Type", colnames(Spinal_Clinical_Data))
        Spinal_Clinical_Data$Sample_Type <- as.character(Spinal_Clinical_Data$Sample_Type)
        
        colnames(Spinal_Clinical_Data) <- gsub("WHOPS", "WHO", colnames(Spinal_Clinical_Data))
        Spinal_Clinical_Data$WHO <- as.character(Spinal_Clinical_Data$WHO)
        
        colnames(Spinal_Clinical_Data) <- gsub("Curated_site_of_tumour", "Primary_Location", colnames(Spinal_Clinical_Data))
        Spinal_Clinical_Data$Primary_Location <- as.character(Spinal_Clinical_Data$Primary_Location)
        
        colnames(Spinal_Clinical_Data) <- gsub("Curated_MET_Call", "Metastasis", colnames(Spinal_Clinical_Data))
        Spinal_Clinical_Data$Metastasis <- as.character(Spinal_Clinical_Data$Metastasis)
        
        Spinal_Clinical_Data$Distant_Metastasis <- ""
        
        colnames(Spinal_Clinical_Data) <- gsub("LiverMet", "Liver_Met", colnames(Spinal_Clinical_Data))
        Spinal_Clinical_Data$Liver_Met <- as.character(Spinal_Clinical_Data$Liver_Met)
        
        colnames(Spinal_Clinical_Data) <- gsub("NodeMet", "Nodal_Met", colnames(Spinal_Clinical_Data))
        Spinal_Clinical_Data$Nodal_Met <- as.character(Spinal_Clinical_Data$Nodal_Met)
        
        colnames(Spinal_Clinical_Data) <- gsub("LungMet", "Lung_Met", colnames(Spinal_Clinical_Data))
        Spinal_Clinical_Data$Lung_Met <- as.character(Spinal_Clinical_Data$Lung_Met)
        
        Spinal_Clinical_Data$Brain_Met <- c("")
        
        colnames(Spinal_Clinical_Data) <- gsub("PeritoneumMet", "Peritoneal_Met", colnames(Spinal_Clinical_Data))
        Spinal_Clinical_Data$Peritoneal_Met <- as.character(Spinal_Clinical_Data$Peritoneal_Met)
        
        Spinal_Clinical_Data$Other_Met <- ("")
        
        colnames(Spinal_Clinical_Data) <- gsub("OtherMet", "Specify_Met", colnames(Spinal_Clinical_Data))
        Spinal_Clinical_Data$Specify_Met <- as.character(Spinal_Clinical_Data$Specify_Met)
    
        # Rename data for consistency
        
        Spinal_Clinical_Data$Specify_Met <- gsub("N", "No", Spinal_Clinical_Data$Specify_Met)
        
        Spinal_Clinical_Data$Specify_Met <- gsub("Prostate cancer local progression", "Prostate", Spinal_Clinical_Data$Specify_Met)
        Spinal_Clinical_Data$Specify_Met <- gsub("Vaginal", "Vagina", Spinal_Clinical_Data$Specify_Met)
        Spinal_Clinical_Data$Specify_Met <- gsub("Ovarries", "Ovaries", Spinal_Clinical_Data$Specify_Met)
        Spinal_Clinical_Data$Specify_Met <- gsub("Noo", "No", Spinal_Clinical_Data$Specify_Met)
        Spinal_Clinical_Data$Specify_Met <- gsub("Omental", "Omentum", Spinal_Clinical_Data$Specify_Met)
        Spinal_Clinical_Data$Specify_Met <- gsub("No", "", Spinal_Clinical_Data$Specify_Met)
        
        ## Add Yes into Other_Met if Specify_Met has data
        
        Spinal_Clinical_Data$Other_Met <- ("")
        Spinal_Clinical_Data$Other_Met[Spinal_Clinical_Data$Specify_Met == "Y"
                         |Spinal_Clinical_Data$Specify_Met == "Bone"
                         |Spinal_Clinical_Data$Specify_Met == "Omentum "
                         |Spinal_Clinical_Data$Specify_Met == "Vagina"
                         |Spinal_Clinical_Data$Specify_Met == "Ovaries"
                         |Spinal_Clinical_Data$Specify_Met == "Soft tissue mass"
                         |Spinal_Clinical_Data$Specify_Met == "BOE METS I PELVIS"
                         |Spinal_Clinical_Data$Specify_Met == "Adrenal"
                         |Spinal_Clinical_Data$Specify_Met == "MEDISTIUM"
                         |Spinal_Clinical_Data$Specify_Met == "boney-vertebrae, rib, ilium, ischium, R iliac cres"
                         |Spinal_Clinical_Data$Specify_Met == "Skin and kidney"
                         |Spinal_Clinical_Data$Specify_Met == "Right 12th Rib"
                         |Spinal_Clinical_Data$Specify_Met == "R iliac fossa"
                         |Spinal_Clinical_Data$Specify_Met == "right hemipelvis"
                         |Spinal_Clinical_Data$Specify_Met == "Pre sacral local recurrence"
                         |Spinal_Clinical_Data$Specify_Met == "Pelvic mass, local recurrence"
                         |Spinal_Clinical_Data$Specify_Met == "Prostate"
                         |Spinal_Clinical_Data$Specify_Met == "certain"] <- "Yes"
        Spinal_Clinical_Data$Other_Met[!(Spinal_Clinical_Data$Other_Met == "Yes")] <- ""
        
        Spinal_Clinical_Data$Treatment <- c("")
        Spinal_Clinical_Data$Primary_Radiotherapy <- c("")
        
        Spinal_Clinical_Data$Primary_Chemo <- c("")
        
      ## Inserting relevant data into Primary_Chemo column based on Treatment column
        
        Spinal_Clinical_Data$Primary_Chemo[Spinal_Clinical_Data$Block_Source == "COIN"] <- "Yes"
        
        
        colnames(Spinal_Clinical_Data) <- gsub("pT", "T_Stage", colnames(Spinal_Clinical_Data))
        Spinal_Clinical_Data$T_Stage <- as.character(Spinal_Clinical_Data$T_Stage)
        
        colnames(Spinal_Clinical_Data) <- gsub("pN", "N_Stage", colnames(Spinal_Clinical_Data))
        Spinal_Clinical_Data$N_Stage <- as.character(Spinal_Clinical_Data$N_Stage)
        
        colnames(Spinal_Clinical_Data) <- gsub("pM", "M_Stage", colnames(Spinal_Clinical_Data))
        Spinal_Clinical_Data$M_Stage <- as.character(Spinal_Clinical_Data$M_Stage)
        
        Spinal_Clinical_Data$Met_Surgery <- c("")
        Spinal_Clinical_Data$Met_Chemo <- c("")
        
        colnames(Spinal_Clinical_Data) <- gsub("OS", "OS_Time", colnames(Spinal_Clinical_Data))
        Spinal_Clinical_Data$OS_Time <- Spinal_Clinical_Data$OS_Time/365.25
        
        colnames(Spinal_Clinical_Data) <- gsub("Death", "OS_Status", colnames(Spinal_Clinical_Data))
        Spinal_Clinical_Data$OS_Status <- as.character(Spinal_Clinical_Data$OS_Status)
        
        Spinal_Clinical_Data$PFS_Status <- c("")
        Spinal_Clinical_Data$PFS_Time <- c("")
        Spinal_Clinical_Data$Response <- c("")
        
        
    ## Rename data contents for consistency
        
        # Primary tumour location
        
        Spinal_Clinical_Data$Primary_Location <- gsub("Sigmoid colon", "Colon", Spinal_Clinical_Data$Primary_Location)
        Spinal_Clinical_Data$Primary_Location <- gsub("Not known", "", Spinal_Clinical_Data$Primary_Location)
        
        
    ## Select desired data columns
        
        library(dplyr)
        Spinal_Clinical_Data <- select(Spinal_Clinical_Data, "Scort_ID", "Cohort", "Patient_ID", "Block_Source", "Sample_Type", "Gender", "Age", "WHO", 
                         "Primary_Location", "Distant_Metastasis", "Liver_Met", "Nodal_Met", "Lung_Met", "Brain_Met", "Peritoneal_Met", 
                         "Other_Met", "Specify_Met", "Treatment", "Primary_Radiotherapy", "Primary_Chemo", "T_Stage", "N_Stage", "M_Stage", 
                         "Met_Surgery", "Met_Chemo", "OS_Status", "OS_Time", "PFS_Status", "PFS_Time", "Response")
        
    
### Grampian clinical data ----
    
    ## Column heasings, creating new where necessary
        
        colnames(Grampian_Clinical_Data) <- gsub("biopsy_scort_id", "Scort_ID", colnames(Grampian_Clinical_Data))
        Grampian_Clinical_Data$Scort_ID <- as.character(Grampian_Clinical_Data$Scort_ID)
        
        Grampian_Clinical_Data$Cohort <- c("GRAMPIAN")
        
        colnames(Grampian_Clinical_Data) <- gsub("patient_id", "Patient_ID", colnames(Grampian_Clinical_Data))
        
        Grampian_Clinical_Data$Block_Source <- c("")
        
        Grampian_Clinical_Data$Sample_Type <-c("")
        
        Grampian_Clinical_Data$WHO <- c("")
        
        colnames(Grampian_Clinical_Data) <- gsub("SITE", "Primary_Location", colnames(Grampian_Clinical_Data))
        
        Grampian_Clinical_Data$Metastasis <- ""
        Grampian_Clinical_Data$Distant_Metastasis <- ""
        Grampian_Clinical_Data$Liver_Met <- ""
        Grampian_Clinical_Data$Nodal_Met <- ""
        Grampian_Clinical_Data$Lung_Met <- ""
        Grampian_Clinical_Data$Brain_Met <- ""
        Grampian_Clinical_Data$Peritoneal_Met <- ""
        Grampian_Clinical_Data$Other_Met <- ""
        
        colnames(Grampian_Clinical_Data) <- gsub("MET_LOCATION", "Specify_Met", colnames(Grampian_Clinical_Data))
        
        Grampian_Clinical_Data$Specify_Met <- gsub("liver", "Liver", Grampian_Clinical_Data$Specify_Met)
        Grampian_Clinical_Data$Specify_Met <- gsub("lymph nodes", "Nodal", Grampian_Clinical_Data$Specify_Met)
        Grampian_Clinical_Data$Specify_Met <- gsub("lung", "Lung", Grampian_Clinical_Data$Specify_Met)
        Grampian_Clinical_Data$Specify_Met <- gsub("pelvic recurrence", "Pelvic recurrence", Grampian_Clinical_Data$Specify_Met)
        Grampian_Clinical_Data$Specify_Met <- gsub("brain", "Brain", Grampian_Clinical_Data$Specify_Met)
        
    ## Inserting relevant data into metastasis columns from Specify_Met column
        
        #Metastasis (Yes/No) 
        
        Grampian_Clinical_Data$Other_Met <- ("")
        Grampian_Clinical_Data$Specify_Met[is.na(Grampian_Clinical_Data$Specify_Met)] <- ""
        Grampian_Clinical_Data$Metastasis[Grampian_Clinical_Data$Specify_Met == "Liver"|Grampian_Clinical_Data$Specify_Met == "Lung"|Grampian_Clinical_Data$Specify_Met == "Nodal"|Grampian_Clinical_Data$Specify_Met == "Pelvic recurrence"|Grampian_Clinical_Data$Specify_Met == "Brain"] <- "Yes"
        Grampian_Clinical_Data$Metastasis[!(Grampian_Clinical_Data$Metastasis == "Yes")] <- ""
        
        #Liver_Met (Yes/No) 
        
        Grampian_Clinical_Data$Liver_Met[Grampian_Clinical_Data$Specify_Met == "Liver"] <- "Yes"
        Grampian_Clinical_Data$Liver_Met[!(Grampian_Clinical_Data$Liver_Met == "Yes")] <- ""
        
        #Nodal_Met (Yes/No) 
        
        Grampian_Clinical_Data$Nodal_Met[Grampian_Clinical_Data$Specify_Met == "Nodal"] <- "Yes"
        Grampian_Clinical_Data$Nodal_Met[!(Grampian_Clinical_Data$Nodal_Met == "Yes")] <- ""
        
        #Lung_Met (Yes/No) 
        
        Grampian_Clinical_Data$Lung_Met[Grampian_Clinical_Data$Specify_Met == "Lung"] <- "Yes"
        Grampian_Clinical_Data$Lung_Met[!(Grampian_Clinical_Data$Lung_Met == "Yes")] <- ""
        
        #Brain_Met (Yes/No) 
        
        Grampian_Clinical_Data$Brain_Met[Grampian_Clinical_Data$Specify_Met == "Brain"] <- "Yes"
        Grampian_Clinical_Data$Brain_Met[!(Grampian_Clinical_Data$Brain_Met == "Yes")] <- ""
        
        #Peritoneal_Met (Yes/No) 
        
        Grampian_Clinical_Data$Peritoneal_Met[Grampian_Clinical_Data$Specify_Met == "Peritoneal"] <- "Yes"
        Grampian_Clinical_Data$Peritoneal_Met[!(Grampian_Clinical_Data$Peritoneal_Met == "Yes")] <- ""
        
        #Other_Met (Yes/No) 
        
        Grampian_Clinical_Data$Other_Met[Grampian_Clinical_Data$Specify_Met == "Pelvic recurrence"|Grampian_Clinical_Data$Specify_Met == "Brain"] <- "Yes"
        Grampian_Clinical_Data$Other_Met[!(Grampian_Clinical_Data$Other_Met == "Yes")] <- ""
        
        
        colnames(Grampian_Clinical_Data) <- gsub("Treatment_Arm", "Treatment", colnames(Grampian_Clinical_Data))
        Grampian_Clinical_Data$Treatment <- as.character(Grampian_Clinical_Data$Treatment)
        
        Grampian_Clinical_Data$Primary_Radiotherapy <- c("Yes")
        
        Grampian_Clinical_Data$Primary_Chemo <- c("")
        
    ## Inserting relevant data into Primary_Chemo column based on Treatment column
        
        Grampian_Clinical_Data$Primary_Chemo[Grampian_Clinical_Data$Treatment == "Standard Cap RT"] <- "Yes"
        Grampian_Clinical_Data$Primary_Chemo[Grampian_Clinical_Data$Treatment == "oxali/cape/rt - the Socrates regimen"] <- "Yes"
        Grampian_Clinical_Data$Primary_Chemo[Grampian_Clinical_Data$Treatment == "no concurrent chemo -  25Gy/5#s with delay"] <- "No"
        Grampian_Clinical_Data$Primary_Chemo[Grampian_Clinical_Data$Treatment == "no concurrent chemo - 50Gy/25#s"] <- "No"
        
        colnames(Grampian_Clinical_Data) <- gsub("PRE_T_STAGE", "T_Stage", colnames(Grampian_Clinical_Data))
        Grampian_Clinical_Data$T_Stage <- as.character(Grampian_Clinical_Data$T_Stage)
        
        colnames(Grampian_Clinical_Data) <- gsub("PRE_N_STAGE_ADJUSTED", "N_Stage", colnames(Grampian_Clinical_Data))
        Grampian_Clinical_Data$N_Stage <- as.character(Grampian_Clinical_Data$N_Stage)
        
        colnames(Grampian_Clinical_Data) <- gsub("PRE_M_STAGE", "M_Stage", colnames(Grampian_Clinical_Data))
        Grampian_Clinical_Data$M_Stage <- as.character(Grampian_Clinical_Data$M_Stage)
        
        Grampian_Clinical_Data$Met_Surgery <- c("")
        Grampian_Clinical_Data$Met_Chemo <-c("")
        
        colnames(Grampian_Clinical_Data) <- gsub("OS_STATUS", "OS_Status", colnames(Grampian_Clinical_Data))
        Grampian_Clinical_Data$OS_Status <- as.character(Grampian_Clinical_Data$OS_Status)
        
        colnames(Grampian_Clinical_Data) <- gsub("OS_MONTHS", "OS_Time", colnames(Grampian_Clinical_Data))
        Grampian_Clinical_Data$OS_Time <- Grampian_Clinical_Data$OS_Time/12
        
        colnames(Grampian_Clinical_Data) <- gsub("DFS_STATUS", "PFS_Status", colnames(Grampian_Clinical_Data))
        
        colnames(Grampian_Clinical_Data) <- gsub("DFS_MONTHS", "PFS_Time", colnames(Grampian_Clinical_Data))
        Grampian_Clinical_Data$PFS_Time <- Grampian_Clinical_Data$PFS_Time/12
        
        colnames(Grampian_Clinical_Data) <- gsub("RESPONSE", "Response", colnames(Grampian_Clinical_Data))
        Grampian_Clinical_Data$Response <- as.character(Grampian_Clinical_Data$Response)
        
     ## Alter data contents for consistency
        
        Grampian_Clinical_Data$Primary_Location <- gsub("rectum", "Rectum", Grampian_Clinical_Data$Primary_Location)
        
        Grampian_Clinical_Data$OS_Status <- gsub("LIVING", "0", Grampian_Clinical_Data$OS_Status)
        Grampian_Clinical_Data$OS_Status <- gsub("DECEASED", "1", Grampian_Clinical_Data$OS_Status)
        
        Grampian_Clinical_Data$PFS_Status <- gsub("DiseaseFree", "0", Grampian_Clinical_Data$PFS_Status)
        Grampian_Clinical_Data$PFS_Status <- gsub("Recurred/Progressed", "1", Grampian_Clinical_Data$PFS_Status)
        
        
    ## Select desired columns
        
        library(dplyr)
        Grampian_Clinical_Data <- select(Grampian_Clinical_Data, "Scort_ID", "Cohort", "Patient_ID", "Block_Source", "Sample_Type", "Gender", "Age", "WHO", 
                           "Primary_Location", "Distant_Metastasis", "Liver_Met", "Nodal_Met", "Lung_Met", "Brain_Met", "Peritoneal_Met", 
                           "Other_Met", "Specify_Met", "Treatment", "Primary_Radiotherapy", "Primary_Chemo", "T_Stage", "N_Stage", "M_Stage", 
                           "Met_Surgery", "Met_Chemo", "OS_Status", "OS_Time", "PFS_Status", "PFS_Time", "Response")
        
        

### Focus1_Irinotecan clinical data ----
    
    ## Focus1_Irinotecan_Baseline
        
        ## Rename columns for consistency
        ## Create columns where necessary
        ## Make column data consistent
        
        colnames(Focus1_Irinotecan_Baseline) <- gsub("SCNumber", "Scort_ID", colnames(Focus1_Irinotecan_Baseline))
        Focus1_Irinotecan_Baseline$Scort_ID <- as.character(Focus1_Irinotecan_Baseline$Scort_ID)
        
        Focus1_Irinotecan_Baseline$Block_Source <- c("")
        
        colnames(Focus1_Irinotecan_Baseline) <- gsub("trial", "Cohort", colnames(Focus1_Irinotecan_Baseline))
        Focus1_Irinotecan_Baseline$Cohort <- as.character(Focus1_Irinotecan_Baseline$Cohort)
        Focus1_Irinotecan_Baseline$Cohort <- gsub("FOCUS", "FOCUS1_IRINOTECAN", Focus1_Irinotecan_Baseline$Cohort)
        
        colnames(Focus1_Irinotecan_Baseline) <-gsub("patid", "Patient_ID", colnames(Focus1_Irinotecan_Baseline))
        Focus1_Irinotecan_Baseline$Patient_ID <- as.character(Focus1_Irinotecan_Baseline$Patient_ID)
        
        Focus1_Irinotecan_Baseline$Sample_Type <- c("")
        
        colnames(Focus1_Irinotecan_Baseline) <-gsub("sex", "Gender", colnames(Focus1_Irinotecan_Baseline))
        Focus1_Irinotecan_Baseline$Gender <- as.character(Focus1_Irinotecan_Baseline$Gender)
        
        #Gender (Male = M; Female = F)
        Focus1_Irinotecan_Baseline$Gender <- gsub("Male", "M", Focus1_Irinotecan_Baseline$Gender)
        Focus1_Irinotecan_Baseline$Gender <- gsub("Female", "F", Focus1_Irinotecan_Baseline$Gender)
        
        colnames(Focus1_Irinotecan_Baseline) <-gsub("site", "Primary_Location", colnames(Focus1_Irinotecan_Baseline))
        Focus1_Irinotecan_Baseline$Primary_Location <- as.character(Focus1_Irinotecan_Baseline$Primary_Location)
        
        colnames(Focus1_Irinotecan_Baseline) <-gsub("who", "WHO", colnames(Focus1_Irinotecan_Baseline))
        Focus1_Irinotecan_Baseline$WHO <- as.character(Focus1_Irinotecan_Baseline$WHO)
        
        colnames(Focus1_Irinotecan_Baseline) <-gsub("stat", "Current_Status", colnames(Focus1_Irinotecan_Baseline))
        Focus1_Irinotecan_Baseline$Current_Status <- as.character(Focus1_Irinotecan_Baseline$Current_Status)
        
        colnames(Focus1_Irinotecan_Baseline) <-gsub("mets", "Metastasis", colnames(Focus1_Irinotecan_Baseline))
        Focus1_Irinotecan_Baseline$Metastasis <- as.character(Focus1_Irinotecan_Baseline$Metastasis)
        
        colnames(Focus1_Irinotecan_Baseline) <-gsub("liv", "Liver_Met", colnames(Focus1_Irinotecan_Baseline))
        Focus1_Irinotecan_Baseline$Liver_Met <- as.character(Focus1_Irinotecan_Baseline$Liver_Met)
        
        colnames(Focus1_Irinotecan_Baseline) <-gsub("nod", "Nodal_Met", colnames(Focus1_Irinotecan_Baseline))
        Focus1_Irinotecan_Baseline$Nodal_Met <- as.character(Focus1_Irinotecan_Baseline$Nodal_Met)
        
        colnames(Focus1_Irinotecan_Baseline) <-gsub("lung", "Lung_Met", colnames(Focus1_Irinotecan_Baseline))
        Focus1_Irinotecan_Baseline$Lung_Met <- as.character(Focus1_Irinotecan_Baseline$Lung_Met)
        
        Focus1_Irinotecan_Baseline$Brain_Met <- c("")
        
        colnames(Focus1_Irinotecan_Baseline) <-gsub("peri", "Peritoneal_Met", colnames(Focus1_Irinotecan_Baseline))
        Focus1_Irinotecan_Baseline$Peritoneal_Met <- as.character(Focus1_Irinotecan_Baseline$Peritoneal_Met)
        
        colnames(Focus1_Irinotecan_Baseline) <-gsub("oth", "Other_Met", colnames(Focus1_Irinotecan_Baseline))
        Focus1_Irinotecan_Baseline$Other_Met <- as.character(Focus1_Irinotecan_Baseline$Other_Met)
        
        colnames(Focus1_Irinotecan_Baseline) <-gsub("spmet", "Specify_Met", colnames(Focus1_Irinotecan_Baseline))
        Focus1_Irinotecan_Baseline$Specify_Met <- as.character(Focus1_Irinotecan_Baseline$Specify_Met)
        
        colnames(Focus1_Irinotecan_Baseline) <-gsub("trt", "Treatment", colnames(Focus1_Irinotecan_Baseline))
        
        colnames(Focus1_Irinotecan_Baseline) <-gsub("xrt", "Primary_Radiotherapy", colnames(Focus1_Irinotecan_Baseline))
        Focus1_Irinotecan_Baseline$Primary_radiotherapy <- as.character(Focus1_Irinotecan_Baseline$Primary_Radiotherapy)
        
        colnames(Focus1_Irinotecan_Baseline) <-gsub("chemo", "Primary_Chemo", colnames(Focus1_Irinotecan_Baseline))
        Focus1_Irinotecan_Baseline$Primary_Chemo <- as.character(Focus1_Irinotecan_Baseline$Primary_Chemo)
        
        colnames(Focus1_Irinotecan_Baseline) <-gsub("site", "Primary_Location", colnames(Focus1_Irinotecan_Baseline))
        Focus1_Irinotecan_Baseline$Primary_Location <- as.character(Focus1_Irinotecan_Baseline$Primary_Location)
        
        colnames(Focus1_Irinotecan_Baseline) <- gsub("age", "Age", colnames(Focus1_Irinotecan_Baseline))
        
        colnames(Focus1_Irinotecan_Baseline) <-gsub("psur", "Met_Surgery", colnames(Focus1_Irinotecan_Baseline))
        Focus1_Irinotecan_Baseline$Met_Surgery <- as.character(Focus1_Irinotecan_Baseline$Met_Surgery)
        
        colnames(Focus1_Irinotecan_Baseline) <-gsub("pchem", "Met_Chemo", colnames(Focus1_Irinotecan_Baseline))
        Focus1_Irinotecan_Baseline$Met_Chemo <- as.character(Focus1_Irinotecan_Baseline$Met_Chemo)
        
        Focus1_Irinotecan_Baseline$T_Stage <- c("")
        Focus1_Irinotecan_Baseline$N_Stage <- c("")
        Focus1_Irinotecan_Baseline$M_Stage <- c("")
        
        ## Select desired columns
        
        library(dplyr)
        Focus1_Irinotecan_Baseline <- select(Focus1_Irinotecan_Baseline, "Scort_ID", "Cohort", "Patient_ID", "Block_Source", "Sample_Type", "Gender", "Age", "WHO", 
                                             "Primary_Location", "Metastasis", "Liver_Met", "Nodal_Met", "Lung_Met", "Brain_Met", "Peritoneal_Met", 
                                             "Other_Met", "Specify_Met", "Treatment", "Primary_Radiotherapy", "Primary_Chemo", "T_Stage", "N_Stage", "M_Stage", 
                                             "Met_Surgery", "Met_Chemo")
        
        
        
        
    ## Focus1_Irinotecan_More (updated)
        
        ## Rename columns for consistency
        ## Create columns where necessary
        ## Make sure column data is consistent
        
        colnames(Focus1_Irinotecan_More) <- gsub("scort_id", "Scort_ID", colnames(Focus1_Irinotecan_More))
        Focus1_Irinotecan_More$Scort_ID <- as.character(Focus1_Irinotecan_More$Scort_ID)
        
        colnames(Focus1_Irinotecan_More) <- gsub("trialno", "Patient_ID", colnames(Focus1_Irinotecan_More))
        Focus1_Irinotecan_More$Patient_ID <- as.character(Focus1_Irinotecan_More$Patient_ID)
        
        Focus1_Irinotecan_More$Block_Source  <- c("")
        
        colnames(Focus1_Irinotecan_More) <- gsub("Location_updated", "Primary_Location", colnames(Focus1_Irinotecan_More))
        Focus1_Irinotecan_More$Primary_Location <- as.character(Focus1_Irinotecan_More$Primary_Location)
        
        colnames(Focus1_Irinotecan_More) <- gsub("OS_STATUS", "OS_Status", colnames(Focus1_Irinotecan_More))
        Focus1_Irinotecan_More$OS_Status <- as.character(Focus1_Irinotecan_More$OS_Status)
        
        colnames(Focus1_Irinotecan_More) <- gsub("OS_MONTHS_FROM_PRIMARY_DIAGNOSIS", "OS_Time", colnames(Focus1_Irinotecan_More))
        Focus1_Irinotecan_More$OS_Time <- Focus1_Irinotecan_More$OS_Time/12
        
        colnames(Focus1_Irinotecan_More) <- gsub("T.Stage", "T_Stage", colnames(Focus1_Irinotecan_More))
        Focus1_Irinotecan_More$T_Stage <- as.character(Focus1_Irinotecan_More$T_Stage)
        
        colnames(Focus1_Irinotecan_More) <- gsub("N.Stage", "N_Stage", colnames(Focus1_Irinotecan_More))
        Focus1_Irinotecan_More$N_Stage <- as.character(Focus1_Irinotecan_More$N_Stage)
        
        colnames(Focus1_Irinotecan_More) <- gsub("M.Stage", "M_Stage", colnames(Focus1_Irinotecan_More))
        Focus1_Irinotecan_More$M_Stage <- as.character(Focus1_Irinotecan_More$M_Stage)
        
        Focus1_Irinotecan_More$PFS_Status <- ""
        Focus1_Irinotecan_More$PFS_Time <- ""
        Focus1_Irinotecan_More$Response <- ""
        
        
  ### JOIN FOCUS1_IRINOTECAN_BASELINE and FOCUS1_IRINOTECAN_MORE 
        
        ## Select desired columns
        
        library(dplyr)
        
        Focus1_Irinotecan_Baseline <- select(Focus1_Irinotecan_Baseline, "Scort_ID", "Cohort", "Patient_ID", "Block_Source", 
                                             "Sample_Type", "Gender", "Age", "WHO", 
                                             "Liver_Met", "Nodal_Met", "Lung_Met", "Brain_Met", "Peritoneal_Met", 
                                             "Other_Met", "Specify_Met", "Treatment", "Primary_Radiotherapy", "Primary_Chemo", 
                                             "Met_Surgery", "Met_Chemo")
        
        Focus1_Irinotecan_More <- select(Focus1_Irinotecan_More, "Scort_ID", "Primary_Location",
                                         "Distant_Metastasis", "OS_Status", "OS_Time", "PFS_Status", "PFS_Time", "T_Stage", "N_Stage", "M_Stage", "Response")
        
        
        ## Merge data frames by Scort_ID 
        ## Put columns into consistent order
        
        Focus1_Irinotecan_Clinical_Data <- left_join(Focus1_Irinotecan_Baseline, Focus1_Irinotecan_More, by= "Scort_ID")
        
        Focus1_Irinotecan_Clinical_Data <- Focus1_Irinotecan_Clinical_Data[,Col_Order_Clinical]
        
        

### Updated Focus1 (Not Irinotecan) clinical data ----
        
        ## Rename columns for consistency 
        ## Create columns where needed
        
        colnames(Focus1_Clinical_Updated) <- gsub("scort_id", "Scort_ID", colnames(Focus1_Clinical_Updated))
        
        Focus1_Clinical_Updated$Block_Source <- c("")
        
        colnames(Focus1_Clinical_Updated) <- gsub("Cancer_Sample_Type", "Sample_Type", colnames(Focus1_Clinical_Updated))
        Focus1_Clinical_Updated$Sample_Type <- as.character(Focus1_Clinical_Updated$Sample_Type)
        
        colnames(Focus1_Clinical_Updated) <- gsub("Location_updated", "Primary_Location", colnames(Focus1_Clinical_Updated))
        Focus1_Clinical_Updated$Primary_Location <- as.character(Focus1_Clinical_Updated$Primary_Location)
        
        colnames(Focus1_Clinical_Updated) <- gsub("Treatment_Arm", "Treatment", colnames(Focus1_Clinical_Updated))
        Focus1_Clinical_Updated$Treatment <- as.character(Focus1_Clinical_Updated$Treatment)
        
        colnames(Focus1_Clinical_Updated) <- gsub("T.Stage", "T_Stage", colnames(Focus1_Clinical_Updated))
        Focus1_Clinical_Updated$T_Stage <- as.character(Focus1_Clinical_Updated$T_Stage)
        
        colnames(Focus1_Clinical_Updated) <- gsub("N.Stage", "N_Stage", colnames(Focus1_Clinical_Updated))
        Focus1_Clinical_Updated$N_Stage <- as.character(Focus1_Clinical_Updated$N_Stage)
        
        colnames(Focus1_Clinical_Updated) <- gsub("M.Stage", "M_Stage", colnames(Focus1_Clinical_Updated))
        Focus1_Clinical_Updated$M_Stage <- as.character(Focus1_Clinical_Updated$M_Stage)
        
        colnames(Focus1_Clinical_Updated) <- gsub("OS_STATUS_TRIAL", "OS_Status", colnames(Focus1_Clinical_Updated))
        Focus1_Clinical_Updated$OS_Status <- as.character(Focus1_Clinical_Updated$OS_Status)
        
        colnames(Focus1_Clinical_Updated) <- gsub("OS_MONTHS_TRIAL", "OS_Time", colnames(Focus1_Clinical_Updated))
        
        
        colnames(Focus1_Clinical_Updated) <- gsub("PFS_STATUS_TRIAL", "PFS_Status", colnames(Focus1_Clinical_Updated))
        Focus1_Clinical_Updated$PFS_Status <- as.character(Focus1_Clinical_Updated$PFS_Status)
        
        colnames(Focus1_Clinical_Updated) <- gsub("PFS_MONTHS_TRIAL", "PFS_Time", colnames(Focus1_Clinical_Updated))
        
        
        ## Make data consistent
        
        # Gender (M/F)
        
        Focus1_Clinical_Updated$Gender <- gsub("Male", "M", Focus1_Clinical_Updated$Gender)
        Focus1_Clinical_Updated$Gender <- gsub("Female", "F", Focus1_Clinical_Updated$Gender)
        
        # OS_ and PFS_Time_Months into Years
        
        Focus1_Clinical_Updated$OS_Time <- Focus1_Clinical_Updated$OS_Time/12
        Focus1_Clinical_Updated$PFS_Time <- Focus1_Clinical_Updated$PFS_Time/12
        
        # OS_Status (LIVING = 0, DECEASED = 1)
        
        Focus1_Clinical_Updated$OS_Status <- gsub("LIVING", "0", Focus1_Clinical_Updated$OS_Status)
        Focus1_Clinical_Updated$OS_Status <- gsub("DECEASED", "1", Focus1_Clinical_Updated$OS_Status)
        
        # PFS_Status (DiseaseFree = 0, Recurred/Progressed = 1)
        
        Focus1_Clinical_Updated$OS_Status <- gsub("DiseaseFree", "0", Focus1_Clinical_Updated$OS_Status)
        Focus1_Clinical_Updated$PFS_Status <- gsub("Recurred/Progressed", "1", Focus1_Clinical_Updated$PFS_Status)
        
        
        ## Select desired columns
        
        library(dplyr)
        Focus1_Clinical_Updated <- select(Focus1_Clinical_Updated, "Scort_ID", "Block_Source", "Sample_Type", "Gender", "Age", "WHO", 
                                          "Primary_Location", "Distant_Metastasis", "Treatment", "T_Stage", "N_Stage", "M_Stage", 
                                          "OS_Status", "OS_Time", "PFS_Status", "PFS_Time", "Response")
        
        
### Join updated Focus1 (Not Irinotecan) clinical data to non-updated Focus1 clincal data ----
        
        colnames(Old_Final_Merge) <- gsub("Liver", "Liver_Met", colnames(Old_Final_Merge))
        colnames(Old_Final_Merge) <- gsub("Nodal", "Nodal_Met", colnames(Old_Final_Merge))
        colnames(Old_Final_Merge) <- gsub("Lung", "Lung_Met", colnames(Old_Final_Merge))
        colnames(Old_Final_Merge) <- gsub("Brain", "Brain_Met", colnames(Old_Final_Merge))
        colnames(Old_Final_Merge) <- gsub("Peritoneal", "Peritoneal_Met", colnames(Old_Final_Merge))
        
        
        ## Select desired columns (those that were not updated)
        
        library(dplyr)
        Old_Final_Merge2 <- select(Old_Final_Merge, "Scort_ID", "Cohort", "Patient_ID",
                                                    "Liver_Met", "Nodal_Met", "Lung_Met", "Brain_Met", "Peritoneal_Met", 
                                                    "Other_Met", "Specify_Met", "Primary_Radiotherapy", "Primary_Chemo", 
                                                    "Met_Surgery", "Met_Chemo")
        
        
        ## Join old and updated data
        
        Focus1_Clinical_Data_Updated2 <- left_join(Focus1_Clinical_Updated, Old_Final_Merge2, by= "Scort_ID")
        Focus1_Clinical_Data_Updated2 <- Focus1_Clinical_Data_Updated2[,Col_Order_Clinical]   
        
        
### Merge above cohorts' clinical data into single dataframe ----
        
        Merged_Clinical_Data <- rbind(Spinal_Clinical_Data, Grampian_Clinical_Data, Focus1_Irinotecan_Clinical_Data, Focus1_Clinical_Data_Updated2)
        
        
        ## Make data consistent
        
        Merged_Clinical_Data$T_Stage <- gsub("T0", "0", Merged_Clinical_Data$T_Stage)
        Merged_Clinical_Data$T_Stage <- gsub("T1", "1", Merged_Clinical_Data$T_Stage)
        Merged_Clinical_Data$T_Stage <- gsub("T2", "2", Merged_Clinical_Data$T_Stage)
        Merged_Clinical_Data$T_Stage <- gsub("T3", "3", Merged_Clinical_Data$T_Stage)
        Merged_Clinical_Data$T_Stage <- gsub("T4", "4", Merged_Clinical_Data$T_Stage)
        
        Merged_Clinical_Data$N_Stage <- gsub("N0", "0", Merged_Clinical_Data$N_Stage)
        Merged_Clinical_Data$N_Stage <- gsub("N1", "1", Merged_Clinical_Data$N_Stage)
        Merged_Clinical_Data$N_Stage <- gsub("N2", "2", Merged_Clinical_Data$N_Stage)
        Merged_Clinical_Data$N_Stage <- gsub("N3", "3", Merged_Clinical_Data$N_Stage)
        Merged_Clinical_Data$N_Stage <- gsub("N4", "4", Merged_Clinical_Data$N_Stage)
        
        Merged_Clinical_Data$M_Stage <- gsub("M0", "0", Merged_Clinical_Data$M_Stage)
        Merged_Clinical_Data$M_Stage <- gsub("M1", "1", Merged_Clinical_Data$M_Stage)
        
        
        
### Join with old clinical data merge  -----
        
        Old_Final_Merge$Block_Source <- c("")
        
        colnames(Old_Final_Merge) <- gsub("Tumour_location", "Primary_Location", colnames(Old_Final_Merge))
        Old_Final_Merge$Primary_Location <- as.character(Old_Final_Merge$Primary_Location)
        
        
        colnames(Old_Final_Merge) <- gsub("Specify_other_met", "Specify_Met", colnames(Old_Final_Merge))
        
        
        ## As Laura's merge has the updated FOCUS clinical data, so de-select FOCUS from Julia's dataframe
        
        Old_Final_Merge_No_Focus <- Old_Final_Merge[ which(Old_Final_Merge$Cohort != "FOCUS"),]
        
        
        
        ## Select only clinical data from Julia's final merge
        
        library(dplyr)
        
        Old_Final_Merge_No_Focus <- select(Old_Final_Merge_No_Focus, "Scort_ID", "Cohort", "Patient_ID", 
                                                   "Block_Source", "Sample_Type", "Gender", "Age", "WHO", 
                                                   "Primary_Location", "Distant_Metastasis", "Liver_Met", "Nodal_Met", 
                                                   "Lung_Met", "Brain_Met", "Peritoneal_Met", 
                                                   "Other_Met", "Specify_Met", "Treatment", "Primary_Radiotherapy", "Primary_Chemo", 
                                                   "T_Stage", "N_Stage", "M_Stage", "Met_Surgery", "Met_Chemo", "OS_Status", 
                                                   "OS_Time", "PFS_Status", "PFS_Time", "Response")
        
        
        ## Bind with recent clinical data
        
        Merged_Clinical_Data2 <- rbind(Merged_Clinical_Data, Old_Final_Merge_No_Focus)  
        
    
### NGS mutation data -----
     
        ## Rename columns for consistency
        ## Create columns where necessary
        ## Make column data consistent
        
        colnames(NGS_Summary) <- gsub("scort_id", "Scort_ID", colnames(NGS_Summary))
        NGS_Summary$Scort_ID <- as.character(NGS_Summary$Scort_ID)
        
        colnames(NGS_Summary) <- gsub("trial", "Cohort", colnames(NGS_Summary))
        NGS_Summary$Cohort <- as.character(NGS_Summary$Cohort)
        
        colnames(NGS_Summary) <- gsub("Total_coding_muts", "Total_Mutations", colnames(NGS_Summary))
        NGS_Summary$Total_Mutations <- as.character(NGS_Summary$Total_Mutations)
        
        colnames(NGS_Summary) <- gsub("NGS_MSI", "MSI", colnames(NGS_Summary))
        NGS_Summary$MSI <- as.character(NGS_Summary$MSI)
        
        NGS_Summary$FAM123B <- ""
        
        colnames(NGS_Summary) <- gsub("KRAS_other", "KRAS_others", colnames(NGS_Summary))
        NGS_Summary$KRAS_others <- as.character(NGS_Summary$KRAS_others)
        
        colnames(NGS_Summary) <- gsub("BRAF_other", "BRAF_others", colnames(NGS_Summary))
        NGS_Summary$BRAF_others <- as.character(NGS_Summary$BRAF_others)
        
        colnames(NGS_Summary) <- gsub("PIK3CA_other", "PIK3CA_others", colnames(NGS_Summary))
        NGS_Summary$PIK3CA_others <- as.character(NGS_Summary$PIK3CA_others)   
    
### Add NGS mutation data -----
        
      ## Add to all SCORT cohorts (not Victor and Quasar 2)
        
        
        Merged_Clinical_Data_Scort <- subset(Merged_Clinical_Data2, subset = (Cohort == "BELFAST"
                                                                                     |Cohort == "COIN"
                                                                                     |Cohort == "COPERNICUS"
                                                                                     |Cohort == "FOCUS"
                                                                                     |Cohort == "FOCUS1_IRINOTECAN"
                                                                                     |Cohort == "FOCUS2"
                                                                                     |Cohort == "FOXTROT"
                                                                                     |Cohort == "GRAMPIAN"
                                                                                     |Cohort == "NEW EPOC"
                                                                                     |Cohort == "SPINAL"))
        table(Merged_Clinical_Data_Scort$Cohort)
        
        Merged_Scort_Clinical_and_Mut_Data <- left_join(Merged_Clinical_Data_Scort, NGS_Summary, by= "Scort_ID")
        
        
        Merged_Scort_Clinical_and_Mut_Data  <- Merged_Scort_Clinical_and_Mut_Data[,col_order_merge4]
        
        ## Add both clinical and mutation data for Victor and Quasar 2
        
        V_and_Q_Data <- subset(Old_Final_Merge, subset =(Cohort == "QUASAR2" |Cohort == "VICTOR"))
        Not_V_and_Q_Data <- subset(Old_Final_Merge, subset =(Cohort != "QUASAR2" |Cohort != "VICTOR"))
        colnames(V_and_Q_Data) <- gsub("Cohort", "Cohort.x", colnames(V_and_Q_Data))
        V_and_Q_Data$work_strand <- ""
        V_and_Q_Data$Cohort.y <- ""
        V_and_Q_Data$POLE_signature <- ""
        V_and_Q_Data$KRAS_c61 <- ""
        V_and_Q_Data$NRAS_c1213 <- ""
        V_and_Q_Data$NRAS_c61 <- ""
        V_and_Q_Data$NRAS_other <- ""
        V_and_Q_Data$ACVR1B <- ""
        V_and_Q_Data$AKT1 <- ""
        V_and_Q_Data$AMER1 <- ""
        V_and_Q_Data$ATR <- ""
        V_and_Q_Data$AXIN2 <- ""
        V_and_Q_Data$B2M <- ""
        V_and_Q_Data$BCL9L <- ""
        V_and_Q_Data$BMPR2 <- ""
        V_and_Q_Data$BUB1B <- ""
        V_and_Q_Data$CASP8 <- ""
        V_and_Q_Data$CD58 <- ""
        V_and_Q_Data$CDC27 <- ""
        V_and_Q_Data$CDK8 <- ""
        V_and_Q_Data$CDKN2A <- ""
        V_and_Q_Data$CREBBP <- ""
        V_and_Q_Data$CTNNB1 <- ""
        V_and_Q_Data$ELF3 <- ""
        V_and_Q_Data$EP300 <- ""
        V_and_Q_Data$ERBB2 <- ""
        V_and_Q_Data$ERBB3 <- ""
        V_and_Q_Data$FGFR3 <- ""
        V_and_Q_Data$FLT3 <- ""
        V_and_Q_Data$GNAS <- ""
        V_and_Q_Data$HDLBP <- ""
        V_and_Q_Data$HLA.A <- ""
        V_and_Q_Data$HLA.B <- ""
        V_and_Q_Data$HRAS <- ""
        V_and_Q_Data$IDH1 <- ""
        V_and_Q_Data$IGF2 <- ""
        V_and_Q_Data$IRS2  <- ""
        V_and_Q_Data$MAP2K4<- ""
        V_and_Q_Data$MBD6 <- ""
        V_and_Q_Data$MET <- ""
        V_and_Q_Data$MLH1 <- ""
        V_and_Q_Data$MSH2 <- ""
        V_and_Q_Data$MSH3 <- ""
        V_and_Q_Data$MSH6 <- ""
        V_and_Q_Data$NF1 <- ""
        V_and_Q_Data$PCBP1 <- ""
        V_and_Q_Data$PIK3R1 <- ""
        V_and_Q_Data$PMS2 <- ""
        V_and_Q_Data$POLE <- ""
        V_and_Q_Data$PPP2R1A<- ""
        V_and_Q_Data$RAF1 <- ""
        V_and_Q_Data$RBM10 <- ""
        V_and_Q_Data$SMAD2 <- ""
        V_and_Q_Data$SMAD3 <- ""
        V_and_Q_Data$SMARCA4 <- ""
        V_and_Q_Data$TCF7L2 <- ""
        V_and_Q_Data$TGIF1 <- ""
        V_and_Q_Data$WBP1 <- ""
        
        
        V_and_Q_Data <- select(V_and_Q_Data, "Scort_ID", "Cohort.x", "Patient_ID", "Block_Source", "Sample_Type",         
                                "Gender", "Age", "WHO", "Primary_Location", "Distant_Metastasis",
                                "Liver_Met", "Nodal_Met",  "Lung_Met", "Brain_Met",  "Peritoneal_Met" ,     
                                "Other_Met", "Specify_Met",         "Treatment", "Primary_Radiotherapy", "Primary_Chemo",      
                                "T_Stage", "N_Stage", "M_Stage", "Met_Surgery", "Met_Chemo", "OS_Status","OS_Time","PFS_Status","PFS_Time", "Response",           
                                "Cohort.y", "work_strand", "Total_Mutations","MSI", "POLE_signature",     
                                "KRAS_c1213", "KRAS_c61", "KRAS_others", "BRAF_V600E", "BRAF_others", "PIK3CA_ex9", "PIK3CA_ex20", "PIK3CA_others", "NRAS_c1213"   ,        "NRAS_c61"  ,          
                                "NRAS_other", "ACVR1B"      ,         "ACVR2A"    ,           "AKT1"      ,  "AMER1"   ,  "APC"        , "ARID1A" , "ATM" ,  "ATR" ,  "AXIN2"  ,    "B2M"          ,        "BCL9L"    ,  "BMPR2"   ,   "BRAF"       ,          "BUB1B"  ,             
                                "CASP8","CD58","CDC27"    ,            "CDK8"        ,         "CDKN2A" ,  "CREBBP"         ,      "CTNNB1"    ,           "ELF3"    ,             "EP300"         ,       "ERBB2"  ,   "ERBB3" ,      "FBXW7"        ,        "FGFR3"      ,          "FLT3"     ,            "GNAS"  ,              
                                "HDLBP"      ,  "HLA.A"         ,       "HLA.B"    ,            "HRAS"     ,            "IDH1" ,               
                                "IGF2"  ,               "IRS2"             ,    "KRAS"       ,          "MAP2K4"   ,            "MBD6" ,               
                                "MET"  ,  "MLH1"  ,   "MSH2"         ,        "MSH3"   ,   "MSH6" ,  "NF1"   ,  "NRAS" ,   "PCBP1"       ,         "PIK3CA"   ,            "PIK3R1" ,             
                                "PMS2", "POLE"  ,       "PPP2R1A"  ,    "PTEN"    ,  "RAF1", "RBM10", "RNF43", "SMAD2",  "SMAD3", "SMAD4", "SMARCA4", "SOX9", "TCF7L2", "TGIF1", "TP53", "WBP1", "ZFP36L2", "FAM123B")
        
        V_and_Q_Data <- V_and_Q_Data[, col_order_merge4]
        
        Merged_Clinical_and_Mut_Data <- rbind(Merged_Scort_Clinical_and_Mut_Data, V_and_Q_Data)
        
        ## Remove duplicate "Cohort.y" column
        
        Merged_Clinical_and_Mut_Data <- Merged_Clinical_and_Mut_Data[, !(colnames(Merged_Clinical_and_Mut_Data) == "Cohort.y")]
        colnames(Merged_Clinical_and_Mut_Data) <- gsub("Cohort.x", "Cohort", colnames(Merged_Clinical_and_Mut_Data))
        
        
        ### Make all data consistent 
        
        # Gender (F/M)
        
        Merged_Clinical_and_Mut_Data$Gender <- gsub("Female", "F", Merged_Clinical_and_Mut_Data$Gender)
        Merged_Clinical_and_Mut_Data$Gender <- gsub("Male", "M", Merged_Clinical_and_Mut_Data$Gender)
        
        # T_Stage
        
        Merged_Clinical_and_Mut_Data$T_Stage <- gsub("T1", "1", Merged_Clinical_and_Mut_Data$T_Stage)
        Merged_Clinical_and_Mut_Data$T_Stage <- gsub("T2", "2", Merged_Clinical_and_Mut_Data$T_Stage)
        Merged_Clinical_and_Mut_Data$T_Stage <- gsub("T3", "3", Merged_Clinical_and_Mut_Data$T_Stage)
        Merged_Clinical_and_Mut_Data$T_Stage <- gsub("T4", "4", Merged_Clinical_and_Mut_Data$T_Stage)
        Merged_Clinical_and_Mut_Data$T_Stage <- gsub("no MRI", "", Merged_Clinical_and_Mut_Data$T_Stage)
        
        # N_Stage
        
        Merged_Clinical_and_Mut_Data$N_Stage <- gsub("N0", "0", Merged_Clinical_and_Mut_Data$N_Stage)
        Merged_Clinical_and_Mut_Data$N_Stage <- gsub("N1", "1", Merged_Clinical_and_Mut_Data$N_Stage)
        Merged_Clinical_and_Mut_Data$N_Stage <- gsub("N2", "2", Merged_Clinical_and_Mut_Data$N_Stage)
        Merged_Clinical_and_Mut_Data$N_Stage <- gsub("N3", "3", Merged_Clinical_and_Mut_Data$N_Stage)
        
        # M_Stage
        
        Merged_Clinical_and_Mut_Data$M_Stage <- gsub("M0", "0", Merged_Clinical_and_Mut_Data$M_Stage)
        Merged_Clinical_and_Mut_Data$M_Stage <- gsub("M1", "1", Merged_Clinical_and_Mut_Data$M_Stage)
        Merged_Clinical_and_Mut_Data$M_Stage <- gsub("MX", "X", Merged_Clinical_and_Mut_Data$M_Stage)
        Merged_Clinical_and_Mut_Data$M_Stage <- gsub("Mx", "X", Merged_Clinical_and_Mut_Data$M_Stage)
        Merged_Clinical_and_Mut_Data$M_Stage <- gsub("x", "X", Merged_Clinical_and_Mut_Data$M_Stage)
        Merged_Clinical_and_Mut_Data$M_Stage <- gsub("Not Stated", "", Merged_Clinical_and_Mut_Data$M_Stage)
        Merged_Clinical_and_Mut_Data$M_Stage <- gsub("no data", "", Merged_Clinical_and_Mut_Data$M_Stage)
        
        # Primary Location
        
        Merged_Clinical_and_Mut_Data$Primary_Location <- gsub("Not Known", "", Merged_Clinical_and_Mut_Data$Primary_Location)
        
        
### Add RNA expression and Gene copy number data ----
        
        ## Make Scort_ID data headings consistent
        
        
        colnames(RNA_Expression_Signatures) <- gsub("scort_id", "Scort_ID", colnames(RNA_Expression_Signatures))
        colnames(Gene_CN_Data) <- gsub("scort_id", "Scort_ID", colnames(Gene_CN_Data))
        
        ## Join to merged clinical and mutation data
        
        Merge_With_RNA_Expression <- left_join(Merged_Clinical_and_Mut_Data, RNA_Expression_Signatures, by = "Scort_ID")
        Final_Merge_01 <- left_join(Merge_With_RNA_Expression, Gene_CN_Data, by = "Scort_ID")

        
### Further edits  -----
        
        colnames(Final_Merge_01) <- gsub("work_strand", "Work_Strand", colnames(Final_Merge_01))
        Final_Merge_01$Work_Strand <- as.character(Final_Merge_01$Work_Strand)
        
       
        ## Make COIN and FOCUS2 Block_Source with Cohort as QC_SET
        
        Final_Merge_01$Cohort <- gsub("COIN", "QC_SET", Final_Merge_01$Cohort)
        Final_Merge_01$Block_Source[Final_Merge_01$Cohort == "QC_SET"] <- "COIN"
        
        Final_Merge_01$Block_Source[Final_Merge_01$Cohort == "FOCUS2"] <- "FOCUS2"
        Final_Merge_01$Cohort <- gsub("FOCUS2", "QC_SET", Final_Merge_01$Cohort)
        
        ### Add columns for sideness and fill data
        
        Final_Merge_01$Sidedness <- ""
        
        Final_Merge_01$Sidedness[Final_Merge_01$Primary_Location == "Ascending colon"
                                    |Final_Merge_01$Primary_Location == "Transverse colon"
                                    |Final_Merge_01$Primary_Location == "Right colon n_s"
                                    |Final_Merge_01$Primary_Location == "Caecum"
                                    |Final_Merge_01$Primary_Location == "Caecal cavity"
                                    |Final_Merge_01$Primary_Location == "Caecum_appendix"] <- "Right"
        
        Final_Merge_01$Sidedness[Final_Merge_01$Primary_Location == "Rectum"
                                    |Final_Merge_01$Primary_Location == "Rectosigmoid Junction"
                                    |Final_Merge_01$Primary_Location == "Descending colon"
                                    |Final_Merge_01$Primary_Location == "Hepatic flexure"
                                    |Final_Merge_01$Primary_Location == "Splenic flexure"
                                    |Final_Merge_01$Primary_Location == "Sigmoid colon"
                                    |Final_Merge_01$Primary_Location == "Left colon n_s"
                                    |Final_Merge_01$Primary_Location == "Junction  of  descending and sigmoid"
                                    |Final_Merge_01$Primary_Location == "Distal"] <- "Left"
        
        table(Final_Merge_01$Sidedness)
        
        ## Fill data for M_Stage of NEW EPOC, QUASAR2, VICTOR, AND GRAMPIAN
        
        Final_Merge_01$M_Stage[Final_Merge_01$Cohort == "NEW EPOC"] <- "1"
        
        Final_Merge_01$M_Stage[Final_Merge_01$Cohort == "QUASAR2"
                                  |Final_Merge_01$Cohort == "VICTOR"
                                  |Final_Merge_01$Cohort == "GRAMPIAN"] <- "0"
        
        
        ## Make another M_stage column (M_Stage2), where MX -> MO
        
        Final_Merge_01$M_Stage2 <- c("")
        
        Final_Merge_01$M_Stage2[Final_Merge_01$M_Stage == "0"
                                   |Final_Merge_01$M_Stage == "X"] <- "0"
        
        Final_Merge_01$M_Stage2[Final_Merge_01$M_Stage == "1"] <- "1"
        
### Write merge into csv file -----
        
        write.csv(Final_Merge_01, "/Users/laurahudson/Documents/Final_Merge_01.csv")
        
        write.csv(Final_Merge_01, "/Users/laurahudson/Desktop/FHS_Data01/Merge/Final_Merge_01.csv")
        
        colnames(Final_Merge_01)
        
### *** END of first merge attempt *** ----
        
### *** START of updated  merge *** ----
        
### Exclude data not needed from updated Scort data  -----
        
        ## Exclude repeated FOCUS QC_Set data (N=21) 
        
        Updated_Scort_Data$Exclude[Updated_Scort_Data$trial == "FOCUS" & Updated_Scort_Data$work_strand == "QC"] <- "Exclude"
        Updated_Scort_Data$Exclude[is.na(Updated_Scort_Data$Exclude)] <- "Keep"
        
        table(Updated_Scort_Data$Exclude) # Shows N=21 for exclude
        
        Updated_Scort_Data <- Updated_Scort_Data[Updated_Scort_Data$Exclude == "Keep",]
        Updated_Scort_Data$Exclude <- NULL
        
        
        ## Exclude NEW EPOC data with sample type of liver met (as only need primary CRC)
        
        Updated_Scort_Data$Exclude2[Updated_Scort_Data$trial == "NEW EPOC" & Updated_Scort_Data$sample_type == "Liver metastasis"] <- "Exclude"
        Updated_Scort_Data$Exclude2[is.na(Updated_Scort_Data$Exclude2)] <- "Keep"
        
        table(Updated_Scort_Data$Exclude2) # Shows N=149 for exclude
        
        Updated_Scort_Data <- Updated_Scort_Data[Updated_Scort_Data$Exclude2 == "Keep",]
        Updated_Scort_Data$Exclude2 <- NULL
        
### Keep non-scort (Quasar2, Victor, QC_Set) data needed from Final_Merge_01 ----
        
        table(Final_Merge_01$Cohort)
        
        Q2_V_QC_Data <- Final_Merge_01[Final_Merge_01$Cohort == "QUASAR2" | Final_Merge_01$Cohort == "VICTOR" | Final_Merge_01$Cohort == "QC_SET",]
        
        colnames(Q2_V_QC_Data)
        table(Q2_V_QC_Data$Cohort)
        
        ## Make column headings consistent 
        
        Q2_and_V_Data$Block_Source <- c("")
        
        colnames(Q2_and_V_Data) <- gsub("Tumour_location", "Primary_Location", colnames(Q2_and_V_Data))
        Q2_and_V_Data$Primary_Location <- as.character(Q2_and_V_Data$Primary_Location)
        
        colnames(Q2_and_V_Data) <- gsub("OS_Time", "OS_Time_Years", colnames(Q2_and_V_Data))
        Q2_and_V_Data$OS_Time_Years <- as.character(Q2_and_V_Data$OS_Time_Years)
        
        colnames(Q2_and_V_Data) <- gsub("OS_Time", "PFS_Time_Years", colnames(Q2_and_V_Data))
        Q2_and_V_Data$PFS_Time_Years <- as.character(Q2_and_V_Data$PFS_Time_Years)
        
        # Metastasis sites
        
        colnames(Q2_and_V_Data)
        
        colnames(Q2_and_V_Data) <- gsub("Liver", "Liver_Met", colnames(Q2_and_V_Data))
        Q2_and_V_Data$Liver_Met <- as.character(Q2_and_V_Data$Liver_Met)
        
        colnames(Q2_and_V_Data) <- gsub("Nodal", "Node_Met", colnames(Q2_and_V_Data))
        Q2_and_V_Data$Node_Met <- as.character(Q2_and_V_Data$Node_Met)
        
        colnames(Q2_and_V_Data) <- gsub("Lung", "Lung_Met", colnames(Q2_and_V_Data))
        Q2_and_V_Data$Lung_Met <- as.character(Q2_and_V_Data$Lung_Met)
        
        colnames(Q2_and_V_Data) <- gsub("Peritoneal", "Peritoneum_Met", colnames(Q2_and_V_Data))
        Q2_and_V_Data$Peritoneum_Met <- as.character(Q2_and_V_Data$Peritoneum_Met)
        
        colnames(Q2_and_V_Data) <- gsub("Brain", "Brain_Met", colnames(Q2_and_V_Data))
        Q2_and_V_Data$Peritoneum_Met <- as.character(Q2_and_V_Data$Peritoneum_Met)
        
        
        colnames(Q2_and_V_Data)
        
### Make column headings and data consistent (for updated Scort data) -----
        
        colnames(Updated_Scort_Data) <- gsub("scort_id", "Scort_ID", colnames(Updated_Scort_Data))
        Updated_Scort_Data$Scort_ID <- as.character(Updated_Scort_Data$Scort_ID)
        
        colnames(Updated_Scort_Data) <- gsub("patient_id", "Patient_ID", colnames(Updated_Scort_Data))
        Updated_Scort_Data$Patient_ID <- as.character(Updated_Scort_Data$Patient_ID)
        
        colnames(Updated_Scort_Data) <- gsub("sample_type", "Sample_Type", colnames(Updated_Scort_Data))
        Updated_Scort_Data$Sample_Type <- as.character(Updated_Scort_Data$Sample_Type)
        
        colnames(Updated_Scort_Data) <- gsub("trial", "Block_Source", colnames(Updated_Scort_Data))
        Updated_Scort_Data$Block_Source <- as.character(Updated_Scort_Data$Block_Source)
        
        colnames(Updated_Scort_Data) <- gsub("work_strand", "Work_Strand", colnames(Updated_Scort_Data))
        Updated_Scort_Data$Work_Strand <- as.character(Updated_Scort_Data$Work_Strand)
        
        colnames(Updated_Scort_Data) <- gsub("Location", "Primary_Location", colnames(Updated_Scort_Data))
        Updated_Scort_Data$Primary_Location <- as.character(Updated_Scort_Data$Primary_Location)
        
        colnames(Updated_Scort_Data) <- gsub("OS_STATUS", "OS_Status", colnames(Updated_Scort_Data))
        Updated_Scort_Data$OS_Status <- as.character(Updated_Scort_Data$OS_Status)
        
        colnames(Updated_Scort_Data) <- gsub("OS_MONTHS", "OS_Time_Years", colnames(Updated_Scort_Data))
        Updated_Scort_Data$OS_Time_Years <- Updated_Scort_Data$OS_Time_Years/12
        
        colnames(Updated_Scort_Data) <- gsub("DFS_STATUS", "DFS_Status", colnames(Updated_Scort_Data))
        Updated_Scort_Data$DFS_Status <- as.character(Updated_Scort_Data$DFS_Status)
        
        colnames(Updated_Scort_Data) <- gsub("DFS_MONTHS", "DFS_Time_Years", colnames(Updated_Scort_Data))
        Updated_Scort_Data$DFS_Time_Years <- Updated_Scort_Data$DFS_Time_Years/12
        
        colnames(Updated_Scort_Data) <- gsub("PROGRESSION_FREE_SURVIVAL_STATUS", "PFS_Status", colnames(Updated_Scort_Data))
        Updated_Scort_Data$PFS_Status <- as.character(Updated_Scort_Data$PFS_Status)
        
        colnames(Updated_Scort_Data) <- gsub("PROGRESSION_FREE_SURVIVAL_MONTHS", "PFS_Time_Years", colnames(Updated_Scort_Data))
        Updated_Scort_Data$PFS_Time_Years <- Updated_Scort_Data$PFS_Time_Years/12
        
        
        ### Primary tumour staging columns
        
        colnames(Updated_Scort_Data) <- gsub("pT", "T_Stage", colnames(Updated_Scort_Data))
        Updated_Scort_Data$T_Stage <- as.character(Updated_Scort_Data$T_Stage)
        
        colnames(Updated_Scort_Data) <- gsub("pN", "N_Stage", colnames(Updated_Scort_Data))
        Updated_Scort_Data$N_Stage <- as.character(Updated_Scort_Data$N_Stage)
        
        colnames(Updated_Scort_Data) <- gsub("pM", "M_Stage", colnames(Updated_Scort_Data))
        Updated_Scort_Data$M_Stage <- as.character(Updated_Scort_Data$M_Stage)
        
        ### Metastasis columns
        
        colnames(Updated_Scort_Data) <- gsub("LiverMet", "Liver_Met", colnames(Updated_Scort_Data))
        Updated_Scort_Data$Liver_Met <- as.character(Updated_Scort_Data$Liver_Met)
        
        colnames(Updated_Scort_Data) <- gsub("NodeMet", "Node_Met", colnames(Updated_Scort_Data))
        Updated_Scort_Data$Node_Met <- as.character(Updated_Scort_Data$Node_Met)
        
        colnames(Updated_Scort_Data) <- gsub("LungMet", "Lung_Met", colnames(Updated_Scort_Data))
        Updated_Scort_Data$Lung_Met <- as.character(Updated_Scort_Data$Lung_Met)
        
        colnames(Updated_Scort_Data) <- gsub("PeritoneumMet", "Peritoneum_Met", colnames(Updated_Scort_Data))
        Updated_Scort_Data$Peritoneum_Met <- as.character(Updated_Scort_Data$Peritoneum_Met)
        
        Updated_Scort_Data$Brain_Met <- ""
        
        colnames(Updated_Scort_Data) <- gsub("OtherMet", "Other_Met", colnames(Updated_Scort_Data))
        Updated_Scort_Data$Other_Met <- as.character(Updated_Scort_Data$Other_Met)
        
        ### Other 
        
        colnames(Updated_Scort_Data) <- gsub("MSI_SCORT_Call", "MSI", colnames(Updated_Scort_Data))
        Updated_Scort_Data$MSI <- as.character(Updated_Scort_Data$MSI)
        
        colnames(Updated_Scort_Data) <- gsub("Total_coding_muts", "Total_Mutations", colnames(Updated_Scort_Data))
        Updated_Scort_Data$Total_Mutations <- as.character(Updated_Scort_Data$Total_Mutations)
       
        colnames(Updated_Scort_Data) <- gsub("Metachronous_Synchronous", "Distant_Metastasis", colnames(Updated_Scort_Data))
        Updated_Scort_Data$Distant_Metastasis <- as.character(Updated_Scort_Data$Distant_Metastasis)
        
        colnames(Updated_Scort_Data) <- gsub("BRAF_other", "BRAF_others", colnames(Updated_Scort_Data))
        Updated_Scort_Data$BRAF_others <- as.character(Updated_Scort_Data$BRAF_others)
        
        colnames(Updated_Scort_Data) <- gsub("KRAS_other", "KRAS_others", colnames(Updated_Scort_Data))
        Updated_Scort_Data$KRAS_others <- as.character(Updated_Scort_Data$KRAS_others)
        
        colnames(Updated_Scort_Data) <- gsub("PIK3CA_other", "PIK3CA_others", colnames(Updated_Scort_Data))
        Updated_Scort_Data$PIK3CA_others <- as.character(Updated_Scort_Data$PIK3CA_others)
        
        
        
### Organise cohort, block source, and workstrand columns (for updated Scort data) -----
        
        table(Updated_Scort_Data$Cohort)
        
        ## Cohorts
        
        Updated_Scort_Data$Cohort <- gsub("QC", "QC_Set", Updated_Scort_Data$Cohort)
        
        Updated_Scort_Data$Cohort <- gsub("FT2", "COPERNICUS", Updated_Scort_Data$Cohort)
        
        Updated_Scort_Data$Cohort <- gsub("WS2 FOCUS", "FOCUS", Updated_Scort_Data$Cohort)
        Updated_Scort_Data$Cohort <- gsub("WS2 FOXTROT", "FOXTROT", Updated_Scort_Data$Cohort)
        
        Updated_Scort_Data$Cohort <- gsub("WS3 GRAMPIAN", "GRAMPIAN", Updated_Scort_Data$Cohort)
        Updated_Scort_Data$Cohort <- gsub("WS3 TREC", "TREC", Updated_Scort_Data$Cohort)
        
        Updated_Scort_Data$Cohort <- gsub("WS4 POLYPS", "POLYPS", Updated_Scort_Data$Cohort)
        Updated_Scort_Data$Cohort <- gsub("WS4 PT1s", "PT1_BELFAST", Updated_Scort_Data$Cohort)
        Updated_Scort_Data$Cohort <- gsub("WS4 SPINAL", "SPINAL", Updated_Scort_Data$Cohort)
        
        Updated_Scort_Data$Cohort <- gsub("WS5 FOCUS4C", "FOCUS_4C", Updated_Scort_Data$Cohort)
        Updated_Scort_Data$Cohort <- gsub("WS5 NEW EPOC", "NEW EPOC", Updated_Scort_Data$Cohort)
        
        Updated_Scort_Data$Cohort <- gsub("FOCUS IRI", "FOCUS_IRINOTECAN", Updated_Scort_Data$Cohort)
        
        ## Workstrands
        
        Updated_Scort_Data$Work_Strand <- gsub("QC", "QC_Set", Updated_Scort_Data$Work_Strand)
        Updated_Scort_Data$Work_Strand <- gsub("2", "WS2", Updated_Scort_Data$Work_Strand)
        Updated_Scort_Data$Work_Strand <- gsub("3", "WS3", Updated_Scort_Data$Work_Strand)
        Updated_Scort_Data$Work_Strand <- gsub("4", "WS4", Updated_Scort_Data$Work_Strand)
        Updated_Scort_Data$Work_Strand <- gsub("5", "WS5", Updated_Scort_Data$Work_Strand)
        Updated_Scort_Data$Work_Strand <- gsub("7", "WS7", Updated_Scort_Data$Work_Strand)
        Updated_Scort_Data$Work_Strand <- gsub("FTWS2", "FT2", Updated_Scort_Data$Work_Strand)
        
### Make column headings and data consistent (for Final_Merge_01) -----
       
        colnames(Final_Merge_01) <- gsub("work_strand", "Work_Strand", colnames(Final_Merge_01))
        Final_Merge_01$Work_Strand <- as.character(Final_Merge_01$Work_Strand)
        
        colnames(Final_Merge_01) <- gsub("Nodal_Met", "Node_Met", colnames(Final_Merge_01))
        Final_Merge_01$Node_Met <- as.character(Final_Merge_01$Node_Met)
        
        colnames(Final_Merge_01) <- gsub("Peritoneal_Met", "Peritoneum_Met", colnames(Final_Merge_01))
        Final_Merge_01$Peritoneum_Met <- as.character(Final_Merge_01$Peritoneum_Met)
        
        Final_Merge_01$Other_Met <- NULL
        colnames(Final_Merge_01) <- gsub("Specify_Met", "Other_Met", colnames(Final_Merge_01))
        Final_Merge_01$Other_Met <- as.character(Final_Merge_01$Other_Met)
        
        colnames(Final_Merge_01) <- gsub("OS_Time", "OS_Time_Years", colnames(Final_Merge_01))
        colnames(Final_Merge_01) <- gsub("PFS_Time", "PFS_Time_Years", colnames(Final_Merge_01))
        
        Final_Merge_01$M_Stage2 <- NULL
        
### Join updated Scort data and non-updated non-Scort data ----
    
        table(Updated_Scort_Data$Cohort)
        
        table(Final_Merge_01$Cohort)
        
        
      
        Q2_V_QC_Data <- Final_Merge_01[Final_Merge_01$Cohort == "QUASAR2" | Final_Merge_01$Cohort == "VICTOR" | Final_Merge_01$Cohort == "QC_SET",]
        Updated_Scort_Data <- Updated_Scort_Data[Updated_Scort_Data$Cohort == "COPERNICUS"
                                           | Updated_Scort_Data$Cohort == "FOCUS"
                                           | Updated_Scort_Data$Cohort == "FOCUS_4C"
                                           | Updated_Scort_Data$Cohort == "FOCUS_IRINOTECAN"
                                           | Updated_Scort_Data$Cohort == "FOXTROT"
                                           | Updated_Scort_Data$Cohort == "GRAMPIAN"
                                           | Updated_Scort_Data$Cohort == "NEW EPOC"
                                           | Updated_Scort_Data$Cohort == "POLYPS"
                                           | Updated_Scort_Data$Cohort == "PT1_BELFAST"
                                           | Updated_Scort_Data$Cohort == "SPINAL"
                                           | Updated_Scort_Data$Cohort == "TREC",]
        
        ## Join 
        
        colnames(Updated_Scort_Data)
        
        colnames(Q2_V_QC_Data)
        
        Final_Merge_02 <- rbind.fill(Updated_Scort_Data, Q2_V_QC_Data)
        
        colnames(Final_Merge_02)
        
### Further edits -----
      
      # Sidedness - Copernicus and Trec are rectal cancers  (so both "right")
        
        Final_Merge_02$Sidedness[Final_Merge_02$Cohort == "COPERNICUS"
                                 |Final_Merge_02$Cohort == "TREC"] <- "Right" 

### Plots of data
        
        library(Amelia)
        missmap(Final_Merge_02, main = "Missingness map of merged data", 
                col = c("red","blue"), rank.order = FALSE)
        
### Write oject into file -----    
    
    write.csv(Final_Merge_02, "/Users/laurahudson/Desktop/FHS_Data01/Merge/Final_Merge_02.csv")      
        
        
### *** END *** -----
        
        
