setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
cat("\014")



strings <- c(
  # provide a full name for the title of output documents (e.g. "[POL] Post-Distribution Monitoring")
  dataset.name = "CINM Ukraine 2024",
  # provide a short name for filenames of output documents (e.g. "POL_PDM")
  dataset.name.short = "CINM UKR",
  # this string is only used for creating titles for output documents
  dataset.date = "August 2024",
  # this one is appended to the end of filenames
  out_date = stringr::str_sub(stringr::str_remove_all(Sys.Date(), '-'), 3),
  # the file name of your data for analysis
  filename.data = "data/MSNA2403_2024_final_anonymized_data_19July2024_weighted.xlsx",
  filename.tool = "",  
  filename.daf.tabular = "", 
  filename.labels.oblasts = ""
)


params  <- c(
  # fix_sheet_names_to_match should be one of "tool", "data", or "none"
  fix_sheet_names_to_match = "data",
  combine_folder = "temp/combine/"
)

options(scipen = 999)
rm(list=ls()[!ls() %in% c("params", "strings")])

source("src_R/init.R")

names_og <- names(data.list[[1]])

source("src_R/max_lsg.R")
source("src_R/format_dataset.R")
