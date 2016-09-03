############################################################
#                                                          #
#            Format data on regulatory approval            #
#                                                          #
############################################################
# Load packages
library(readr)
library(dplyr)

# Preamble
##########
# Data extracted from regulatory body websites and documentation
# (FDA - USA, EMA - Europe, PMDA - Japan, TGA - Australia, Health Canada)

# Import data
#############
reg_approval <- read_csv('./data/reg_approval.csv')

# Clean data
############
reg_approval <- reg_approval %>%
    rename(`Registration authority` = registration,
           `Indicated for neuropathic pain` = indication,
           `Specifics of the indication` = specifics)

# Save data
save(list = c('reg_approval'),
     file = './data/reg_approval.RData')

# Clean environment
rm(list = ls())
