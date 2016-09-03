############################################################
#                                                          #
#          Format data on the unit costs of drugs          #
#                                                          #
############################################################
# Load packages
library(readr)
library(dplyr)
library(tidyr)

# Preamble
##########
# Data extracted from: Management Services for Health (MSH). International
# Drug Price Indicator Guide. Management Services for Health, USA.
# URL: http://erc.msh.org/dmpguide/pdf/DrugPriceGuide_2014.pdf.

# Import data
#############
cost_unit <- read_csv('./data/costs.csv')

# Clean data
############
# Calculate median price and high/low ratio, and tidy column names
cost_unit <-  cost_unit %>%
    group_by(drug, strength_mg, type) %>%
    summarise(comparators = n(),
              median_unit_price_USD = round(median(unit_price_USD), 4),
              high_low_ratio =
                  round(max(unit_price_USD) / min(unit_price_USD), 2)) %>%
    ungroup() %>%
    mutate(ord = c(4, 5, 6, 7, 8, 9, 1, 2, 3)) %>%
    arrange(ord) %>%
    select(-ord) %>%
    rename(Drug = drug,
           `Strength (mg)` = strength_mg,
           Type = type,
           `Number of price comparator sources` = comparators,
           `Median price per unit (US$)` = median_unit_price_USD,
           `High:Low price ratio` = high_low_ratio)

# Save data
save(list = c('cost_unit'),
     file = './data/cost_unit.RData')

# Clean environment
rm(list = ls())
