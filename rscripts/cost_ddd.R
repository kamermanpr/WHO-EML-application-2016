############################################################
#                                                          #
#          Format data on the DDD costs of drugs           #
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
cost_ddd <- read_csv('./data/costs.csv')

# Clean data
############
# Create a dataframe of DDDs
ddd_foo <- data_frame(defined_daily_dose_mg = c(rep(1800, times = 5),
                                                rep(75, times = 17),
                                                rep(1000, times = 15)))

# Bind DDD df and calculate tabs per DDD and DDD unit price
cost_ddd <- cost_ddd %>%
    bind_cols(ddd_foo) %>%
    mutate(tabs_per_ddd = defined_daily_dose_mg / strength_mg,
           ddd_unit_price_USD = unit_price_USD * tabs_per_ddd) %>%
    select(drug, atc_code, who_eml, strength_mg, form, route,
           type, source, tabs_per_ddd, ddd_unit_price_USD)

# Calculate median price and high/low ratio, and
# tidy column names for tabulating
cost_ddd <- cost_ddd %>%
    group_by(drug, strength_mg, type) %>%
    summarise(comparators = n(),
              median_ddd_price_USD =
                  round(median(ddd_unit_price_USD), 4),
              high_low_ratio =
                  round(max(ddd_unit_price_USD) /
                            min(ddd_unit_price_USD), 2)) %>%
    ungroup() %>%
    mutate(ord = c(4, 5, 6, 7, 8, 9, 1, 2, 3)) %>%
    arrange(ord) %>%
    select(-ord) %>%
    rename(Drug = drug,
           `Strength (mg)` = strength_mg,
           Type = type,
           `Number of price comparator sources` = comparators,
           `Median price based on DDD (US$)` = median_ddd_price_USD,
           `High:Low DDD price ratio` = high_low_ratio)

# Save data
save(list = c('cost_ddd'),
     file = './data/cost_ddd.RData')

# Clean environment
rm(list = ls())
