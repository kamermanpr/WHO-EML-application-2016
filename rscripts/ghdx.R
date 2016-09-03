############################################################
#                                                          #
#             Global burden of disease figure              #
#                                                          #
############################################################
# Load packages
library(readr)
library(dplyr)
library(ggplot2)
library(scales)
library(cowplot)

# Preamble
## Disability Adjusted Life Years (DALY) data on HIV/AIDS, diabetes mellitus,
## leprosy, road injuries, interpersonal violence, and forces of nature, war,
## and legal intervention for the period 1990 and 2013 were downloaded on
## 20 July 2016 from the Global Health Data Exchange: GHDx
## (http://ghdx.healthdata.org/)

# Import downloaded csv file
data <- read_csv('./data/ghdx.csv')

# Set palette
pal <- c('#1776b7', '#e17f00')

# Sorting string
DDC <- c('Developed', 'Developing')

# Subset DALY data
daly_ddc <- data %>%
    filter(location_name %in% DDC) %>%
    select(location_name, cause_name, year_name, starts_with('rt_'))

# Plot
plot <- ggplot(daly_ddc, aes(x = year_name)) +
    # 'Error-bar' ribbons
    geom_ribbon(aes(ymax = rt_upper, ymin = rt_lower, fill = location_name),
                alpha = 0.5) +
    # Point estimate lines
    geom_line(aes(y = rt_mean, colour = location_name),
              size = 1.5) +
    # Facet
    facet_wrap(~cause_name, nrow = 3, ncol = 2, scales = 'free_y') +
    # Labels
    labs(y = 'DALY (average rate per 100,000 population)\n',
         x = '\nYear') +
    # Colours/fill
    scale_colour_manual(values = pal) +
    scale_fill_manual(values = pal) +
    # Tweak theme
    theme(legend.title = element_blank(),
          legend.text = element_text(size = 18),
          legend.position = 'top',
          legend.key.size = unit(10, "mm"),
          panel.background = element_blank(),
          panel.grid.major = element_line(colour = '#888888', size = 0.2),
          axis.line = element_blank(),
          axis.ticks = element_blank(),
          axis.title = element_text(size = 20),
          axis.text = element_text(size = 18),
          strip.text = element_text(size = 16))

# Save plot
ggsave('./images/ghdx.pdf', plot,
       width = 300, height = 300, units = 'mm')

# Clear environment
rm(list = ls())
