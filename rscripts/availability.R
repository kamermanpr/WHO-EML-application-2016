############################################################
#                                                          #
#                Availability of gabapentin                #
#                                                          #
############################################################
# Load packages
library(readr)
library(dplyr)
library(tidyr)
library(stringr)

# Preamble
##########
# Data extracted from Martindale: The Complete Drug Reference (38th edition)
# via Micromedex Solutions (Micromedex Inc., http://micromedex.com).

# Import data
#############
# Capsules
data.cap <- read_lines('./data/availability_caps.csv') # read file
# Tablets
data.tab <- read_lines('./data/availability_tabs.csv') # read file

# Clean data
############
# Capsules
data.cap <- strsplit(data.cap, split = ' ,') # split the string
names(data.cap) <- 'V1' # fix name
data.cap.2 <- data.frame(V1 = data.cap) # convert to dataframe
data.cap.2$V1 <- as.character(data.cap.2$V1) # convert to character
data.cap.3 <- data.cap.2 %>%
    filter(!is.na(V1)) %>% # filter out any NA
    separate(col = V1,
             into = c('drug_name', 'other'),
             sep = ' \\(') %>% # separate into columns
    mutate(other = str_replace(other,
                               pattern = 'e, D',
                               replacement = 'e D')) %>% # deal with Parke, Davis issue
    separate(col = other,
             into = c('manufacturer', 'country'),
             sep = ', ') %>% # separate into columns
    mutate(country = str_replace(country,
                                 pattern = '\\)',
                                 replacement = '')) %>% # get rid of trailing ')'
    mutate(country = str_replace(country,
                                 pattern = ' ; Pfizer',
                                 replacement = '')) %>% # deal with Ger. ; Pfizer issue
    mutate_each(funs(str_trim(., side = 'both'))) %>% # trim any remaining white space
    mutate(formulation = rep('capsules', nrow(.))) # add a formulation column

# Tablets
data.tab <- strsplit(data.tab, split = ' ,') # split the string
names(data.tab) <- 'V1' # fix name
data.tab.2 <- data.frame(V1 = data.tab) # convert to dataframe
data.tab.2$V1 <- as.character(data.tab.2$V1) # convert to character
data.tab.3 <- data.tab.2 %>%
    filter(!is.na(V1)) %>% # filter out any NA
    separate(col = V1,
             into = c('drug_name', 'other'),
             sep = ' \\(') %>% # separate into columns
    mutate(other = str_replace(other,
                               pattern = 'e, D',
                               replacement = 'e D')) %>% # deal with Parke, Davis issue
    separate(col = other,
             into = c('manufacturer', 'country'),
             sep = ', ') %>% # separate into columns
    mutate(country = str_replace(country,
                                 pattern = '\\)',
                                 replacement = '')) %>% # get rid of trailing ')'
    mutate(country = str_replace(country,
                                 pattern = ' ; Pfizer',
                                 replacement = '')) %>% # deal with Ger. ; Pfizer issue
    mutate_each(funs(str_trim(., side = 'both'))) %>% # trim any remaining white space
    mutate(formulation = rep('tablets', nrow(.))) # add a formulation column

# Merge the dataframes
data.merged <- data.tab.3 %>%
    union(data.cap.3) %>% # join dataframes
    spread(key = formulation,
           value = formulation) %>% # spread the formulations column into two (tablets and capsules)
    unite(col = formulations,
          capsules, tablets,
          sep = ' / ') %>% # re-unite the columns
    select(country, drug_name, formulations, manufacturer) %>%
    filter(!grepl('Gabapentin.+', .$drug_name)) %>%
    filter(country != 'NA') %>%
    arrange(country) %>%
    rename(Country = country,
           `Trade name` = drug_name,
           `Available\nformulations` = formulations,
           Manufacturer = manufacturer)

# Change country names to full
data.merged$Country <- gsub('Arg.', 'Argentina',
                            data.merged$Country)
data.merged$Country <- gsub('Austral.', 'Australia',
                            data.merged$Country)
data.merged$Country <- gsub('Belg.', 'Belgium',
                            data.merged$Country)
data.merged$Country <- gsub('Braz.', 'Brazil',
                            data.merged$Country)
data.merged$Country <- gsub('Cz.', 'Czech Republic',
                            data.merged$Country)
data.merged$Country <- gsub('Canad.', 'Canada',
                            data.merged$Country)
data.merged$Country <- gsub('Denm.', 'Denmark',
                            data.merged$Country)
data.merged$Country <- gsub('Fin.', 'Finland',
                            data.merged$Country)
data.merged$Country <- gsub('Fr.', 'France',
                            data.merged$Country)
data.merged$Country <- gsub('Ger.', 'Germany',
                            data.merged$Country)
data.merged$Country <- gsub('Gr.', 'Greece',
                            data.merged$Country)
data.merged$Country <- gsub('Hung.', 'Hungary',
                            data.merged$Country)
data.merged$Country <- gsub('Indon.', 'Indonesia',
                            data.merged$Country)
data.merged$Country <- gsub('Irl.', 'Ireland',
                            data.merged$Country)
data.merged$Country <- gsub('Ital.', 'Italy',
                            data.merged$Country)
data.merged$Country <- gsub('Jpn', 'Japan',
                            data.merged$Country)
data.merged$Country <- gsub('Mex.', 'Mexico',
                            data.merged$Country)
data.merged$Country <- gsub('Neth.', 'Netherlands',
                            data.merged$Country)
data.merged$Country <- gsub('Norw.', 'Norway',
                            data.merged$Country)
data.merged$Country <- gsub('NZ', 'New Zealand',
                            data.merged$Country)
data.merged$Country <- gsub('Philipp.', 'Philippines',
                            data.merged$Country)
data.merged$Country <- gsub('Pol.', 'Poland',
                            data.merged$Country)
data.merged$Country <- gsub('Port.', 'Portugal',
                            data.merged$Country)
data.merged$Country <- gsub('Rus.', 'Russia',
                            data.merged$Country)
data.merged$Country <- gsub('S.Afr.', 'South Africa',
                            data.merged$Country)
data.merged$Country <- gsub('Swed.', 'Sweden',
                            data.merged$Country)
data.merged$Country <- gsub('Switz.', 'Switzerland',
                            data.merged$Country)
data.merged$Country <- gsub('Thai.', 'Thailand',
                            data.merged$Country)
data.merged$Country <- gsub('Turk.', 'Turkey',
                            data.merged$Country)
data.merged$Country <- gsub('UK', 'United Kingdom',
                            data.merged$Country)
data.merged$Country <- gsub('Ukr.', 'Ukraine',
                            data.merged$Country)
data.merged$Country <- gsub('Venez.', 'Venezuela',
                            data.merged$Country)

# Emphasize resource-poor countries
# Import list of developed countries names (from IMF)
imf_developed <- read_csv('./data/availability_imf.csv',
                          trim_ws = TRUE) %>%
    .$countries

# Create a emphasis vector
emphasis.index <- data.merged %>%
    mutate(index = 1:dim(data.merged)[1]) %>%
    select(index, Country) %>%
    filter(!Country %in% imf_developed) %>%
    .$index

# Save data
save(list = c('emphasis.index', 'data.merged'),
     file = './data/availability.RData')

# Unload objects
rm(list = ls())
