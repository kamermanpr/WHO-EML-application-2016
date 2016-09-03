############################################################
#                                                          #
#          Format data on the MDD costs of drugs           #
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
cost_mdd <- read_csv('./data/costs.csv')

# Clean data
############
# Create a dataframe of DDDs
mdd_foo <- data_frame(max_daily_dose_mg = c(rep(3600, times = 5),
                                            rep(150, times = 17),
                                            rep(1200, times = 15)))

# Bind MDD df and calculate tabs per MDD and MDD unit price
cost_mdd <- cost_mdd %>%
    bind_cols(mdd_foo) %>%
    mutate(tabs_per_mdd = max_daily_dose_mg / strength_mg,
           mdd_unit_price_USD = unit_price_USD * tabs_per_mdd) %>%
    select(drug, atc_code, who_eml, strength_mg, form, route,
           type, source, tabs_per_mdd, mdd_unit_price_USD)

# Calculate median MDD price and high/low ratio, and
# tidy column names for tabulating
cost_mdd <- cost_mdd %>%
    group_by(drug, strength_mg, type) %>%
    summarise(comparators = n(),
              median_mdd_price_USD =
                  round(median(mdd_unit_price_USD), 4),
              high_low_ratio =
                  round(max(mdd_unit_price_USD) /
                            min(mdd_unit_price_USD), 2)) %>%
    ungroup() %>%
    mutate(ord = c(4, 5, 6, 7, 8, 9, 1, 2, 3)) %>%
    arrange(ord) %>%
    select(-ord) %>%
    rename(Drug = drug,
           `Strength (mg)` = strength_mg,
           Type = type,
           `Number of price comparator sources` = comparators,
           `Median price based on MDD (US$)` = median_mdd_price_USD,
           `High:Low MDD price ratio` = high_low_ratio)

# Save data
save(list = c('cost_mdd'),
     file = './data/cost_mdd.RData')

# Clean environment
rm(list = ls())
