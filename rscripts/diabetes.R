############################################################
#                                                          #
#          Estimated and projected prevalences of          #
#  diabetes mellitus and painful diabetic polyneuropathy   #
#                                                          #
############################################################
# Load packages
library(ggplot2)
library(scales)
library(cowplot)

# Preamble
## Data extracted from: Veves A et al., (2007)
## https://dx.doi.org/10.1111/j.1526-4637.2007.00347.x
## Guariguata et al., (2013)
## https://dx.doi.org/10.1016/j.diabres.2013.11.002.

# Generate the data
dm.data<-data.frame(idvar = factor(rep(c('DM', 'NePUpper', 'NePLower'),
                                       each = 4)),
                    timevar = rep(c(1985, 1995, 2013, 2035),
                                  times = 3),
                    Count = c(75, 140, 382, 592, # Prevalence of DM
                              # Upper (20%) & lower (10%) DPN bounds
                              75 * 0.2, 140 * 0.2, 382 * 0.2, 592  *0.2,
                              75 * 0.1, 140 * 0.1, 382 * 0.1, 592 * 0.1))

# Create plot dataframe for DM cases
point <- dm.data[dm.data$idvar == 'DM',]

# Create plot dataframe for range of NeP cases
time <- dm.data[dm.data$idvar=='NePUpper', 2]
ymax <- dm.data[dm.data$idvar=='NePUpper', 3]
ymin <- dm.data[dm.data$idvar=='NePLower',3]
ribbon <- data.frame(time = time, .ymax = ymax, .ymin = ymin)

# Dummy dataframe for legend
dummy <- data.frame(points = c('one', 'one', 'two', 'two'),
                    y.values = ymin)

# Plot
diabetes <- ggplot(data = ribbon, aes(x = time)) +
    # Legend
    geom_point(data = dummy, aes(y = y.values, colour = points)) +
    scale_colour_manual(labels = c('Diabetes mellitus', 'Neuropathic pain'),
                        values = c('#1776b7', '#e17f00')) +
    guides(colour = guide_legend(override.aes = list(size = 5))) +
    # DPN points, lines and ribbon
    geom_ribbon(aes(ymin = .ymin, ymax = .ymax),
                fill = '#e17f00', alpha = 0.5) +
    geom_point(aes(y = .ymax),
               size = 5, colour = '#e17f00') +
    geom_line(aes(y=.ymax),
              size = 1.5, colour = '#e17f00') +
    geom_point(aes(y = .ymin),
               size = 5, colour = '#e17f00') +
    geom_line(aes(y = .ymin),
              size = 1.5, colour = '#e17f00') +
    # DM points and line
    geom_point(data = point, aes(y = Count),
               size = 5, colour = '#1776b7') +
    geom_line(data = point, aes(y = Count),
              size = 1.5, colour = '#1776b7') +
    scale_y_continuous(limits = c(0, 600),
                       breaks = c(0, 100, 200, 300, 400, 500, 600)) +
    # labels
    labs(y = 'Cases (millions)\n', x = '\nYear') +
    # Tweak theme
    theme(legend.title = element_blank(),
          legend.text = element_text(size = 18),
          legend.position = 'top',
          legend.key.size = unit(10, 'mm'),
          panel.background = element_blank(),
          panel.grid.major = element_line(colour = '#888888', size = 0.2),
          axis.line = element_blank(),
          axis.ticks = element_blank(),
          axis.title = element_text(size = 20),
          axis.text = element_text(size = 18),
          strip.text = element_text(size = 16))

# Save plot
ggsave('./images/diabetes.pdf', diabetes,
       width = 200, height = 180, units = 'mm')

# Unload objects
rm(list = ls())

