library(writexl)

if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, readxl, writexl, openxlsx, randomcoloR, sf, anytime, DT,
               cluster, survey, srvyr, knitr, webshot, docstring, tcltk, scales, utilityR)

if(!require('utilityR')){
  if(!require('devtools')){
    install.packages('devtools')
  }
  devtools::install_github('https://github.com/REACH-WoU/utilityR', build_vignettes = T)
}

library(utilityR)

# source("src/utils/utils_analysis.R")
# source("src/utils/misc_utils.R")
# source("src/utils/utils_descriptive_analysis.R")
# source("src/utils/kobo_utils.R")
# source("src/utils/check_kobo.R")
# source("src/utils/tabular_analysis_utils.R")

na_max <- function(x){ifelse( !all(is.na(x)), max(x, na.rm=T), NA)}
na_min <- function(x){ifelse( !all(is.na(x)), min(x, na.rm=T), NA)}


options(scipen = 999)
options(dplyr.summarise.inform = FALSE)

##  LOAD DATA -------------------------------------------------------------------

cat("\n> Loading data for analysis from", strings['filename.data'], "...\n")
sheet_names <- excel_sheets(strings['filename.data'])
sheet_names[1] <- paste(sheet_names[1], "(main)")
cat("> Found the following datasheets:", paste(sheet_names, collapse = ", "), "\n")

# the first sheet is always named "main"
sheet_names[1] <- "main"
data.list <- list("main" = read_excel(strings['filename.data'], sheet=1, col_types = "text"))

for(sheet in sheet_names[-1])
  data.list[[sheet]] <- read_excel(strings['filename.data'], sheet=sheet, col_types = "text")

tool_choices <- load.tool.choices('resources/MSNA_2024_Kobo_tool_F2F.xlsx','label::English')
tool_survey <- load.tool.survey('resources/MSNA_2024_Kobo_tool_F2F.xlsx','label::English')



# load 100 km

df_km <- read.xlsx('data/MSNA2403_2024_final_anonymized_data_29July2024_weighted_new_30km_and_100km (1).xlsx') %>% 
  select(uuid,`30km_fl_rb`, prox_30_100_fl)


data.list[['main']] <- data.list[['main']] %>% select(-`30km_fl_rb`)
data.list[['main']] <- data.list[['main']] %>% left_join(df_km)








