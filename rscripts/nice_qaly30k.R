############################################################
#                                                          #
#      Format data on the NICE QALY 30k cost-utility       #
#                                                          #
############################################################
# Load packages
library(readr)
library(dplyr)

# Preamble
##########
# Data extracted from Table 10 Health economic model – results of
# probabilistic sensitivity analysis
# https://www.nice.org.uk/guidance/cg173/evidence/full-guideline-191621341

# Import data
#############
nice_qaly30k <- read_csv('./data/nice_qaly30k.csv')

# Clean data
############
nice_qaly30k <- nice_qaly30k %>%
    rename(Medicine = Treatment,
           `Net monetary benefit (NMB)` = NMB,
           `Probability of greatest NMB (\\%)` = Prob1,
           `Probability of NMB being $>$ placebo (\\%)` = Prob2)

# Save data
save(list = c('nice_qaly30k'),
     file = './data/nice_qaly30k.RData')

# Clean environment
rm(list = ls())
