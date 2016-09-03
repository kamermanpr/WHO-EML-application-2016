############################################################
#                                                          #
#      Format data on the NICE 140-day cost utility        #
#                                                          #
############################################################
# Load packages
library(readr)
library(dplyr)

# Preamble
##########
# Data extracted from Table 8 Health economic model – daily dosages and
# prices of drugs
# https://www.nice.org.uk/guidance/cg173/evidence/full-guideline-191621341

# Import data
#############
nice_cost <- read_csv('./data/nice_cost.csv')

# Clean data
############
nice_cost <- nice_cost %>%
    rename(Medicine = Treatment,
           `Average trial dosage (mg/day)` = Trial_dose,
           `Most efficient dosage delivery` = Tabs,
           `140-day cost ($\\textsterling$)` = cost_140)

# Save data
save(list = c('nice_cost'),
     file = './data/nice_cost.RData')

# Clean environment
rm(list = ls())

