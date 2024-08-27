data.list$main <- data.list$main %>% 
  rename(ccia = ccia_v4,
         lsg_wash = lsg_wash_v4,
         lsg_livelihoods=lsg_livelihoods_v4,
         lsg_education = lsg_education_v4,
         lsg_health = lsg_health_v6)


vars <- setdiff(names(data.list$main)[970:ncol(data.list$main)],c('income_quantity_v5','needs_met_unmet'))

df_vars <- data.frame(
  variable = vars,
  variable_label = c(
    'Income source', 'Income quantity','Income quantity2', 'Income quantity3','Income quantity4','Coping strategy',
    'Safety','Barriers','Needs','Legal assistance','Child separation', 'Education critical 1', 
    'Education critical 2', 'Education critical 3', 'Shelter type','Shelter issues','Security tenure', 'electricity',
    'Utility','Domestic','NFI', 'Health critical 1', 'Health critical 2', 'Health critical 3', 
    'Health critical 4', 'Health critical 5', 'Health critical 6','Wash critical 1','Wash critical 2','Wash critical 3',
    'Wash critical 4','Wash critical 5','Wash critical 7','LSG livelyhoods','LSG WASH','LSG Education',
    'LSG Shelter','LSG Protection','LSG Health','LSG Food security','CCIA'
    
  )
)

df <- read.xlsx('resources/disaggs - MS.xlsx')
df <- rbind(c(NA,NA),df)

# df <- data.frame(
#   disaggregations = c("displ_gp", "hoh_educ", "disability_level_3_4", "register_disability", 
#                       "resp_age", "resp_gender", "hh_employed", "hoh_age", 
#                       "elderly_hhs", "hh_elderly_gender", "hh_conscripted_members", 
#                       "hh_income_source", "hh_income", "resp_ethnicity_minor", "hh_govern_cuts", 
#                       "hh_crescent", "hh_size", "hh_children", "hh_many_children", 
#                       "hh_infants", "hh_school_age",NA),
#   disaggregations_label = c('Displacement group', 'Head of household education','Disability level','Disability registration',
#                             'Respondent age','Respondent gender', 'Household employment status',
#                             'Head of household age','Household with elderly','Household elderly gender',
#                             'Household conscription status','Household income source','Household income',
#                             'Ethnic minority',
#                             'Household experienced government cuts','Household in crescent oblasts',
#                             'Household size','Households with children','Households with many children',
#                             'Households with infants','Household with school-age children',NA)
#     )
df2 <- data.frame(
  admin = c('overall','macroregion','macroregion2','oblast','raion'))


daf <- cross_join(df,df2) %>% 
  mutate(func = 'select_one',
         join = NA,
         calculation = 'add_total'
  ) %>% 
  cross_join(df_vars) %>% 
  arrange(factor(variable, levels = vars))

daf$ID <- 1:nrow(daf)

daf <- daf[,c('ID',"variable","variable_label","func",'calculation','admin',"disaggregations","disaggregations_label",'join')]

daf_ls <- list(main = daf,
               filter = data.frame(variable =NA, value = NA, operation =NA, ID =NA))

write.xlsx(daf_ls,'resources/DAF_Final.xlsx')


