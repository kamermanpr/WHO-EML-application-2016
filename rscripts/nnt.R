############################################################
#                                                          #
#              Number needed to treat figure               #
#                                                          #
############################################################
# Load packages
library(ggplot2)
library(scales)
library(cowplot)

# Preamble
## Data obtained from: Table 2 of Finnerup et al., (2015)
## http://www.ncbi.nlm.nih.gov/pubmed/25575710

# Generate data
nnt.data <- data.frame(Drug = c('Tricyclic\nantidepressants',
                                'Selective 5HT and NA\nreuptake inhibitors',
                                'Pregabalin',
                                'Gabapentin'),
                       NNT = c(4.3, 6.4, 7.7, 6.3),
                       LCI = c(3.6, 5.2, 6.5, 5.0),
                       UCI = c(5.3, 8.4, 9.4, 8.4),
                       Participants = c(1085, 2541, 5940, 2046))

# Plot
nnt <- ggplot(nnt.data, aes(x = NNT, y = Drug)) +
    # White background bubble points (scaled to no. of participants)
    geom_point(aes(size = Participants),
               shape = 21, colour = '#000000',
               fill = '#FFFFFF') +
    # Bubble points (scaled to no. of participants)
    geom_point(aes(size = Participants, fill = Participants),
               shape = 21, colour = '#000000', alpha = 0.7) +
    # Bubble points scaling range
    scale_size(range = c(10, 60)) +
    # Point estimate
    geom_point(aes(x = NNT, y = Drug),
               colour = '#000000', size = 5) +
    # 95% CI of the point estimate
    geom_errorbarh(aes(xmin = LCI, xmax = UCI, y = Drug),
                   colour = '#000000', size = 1.5, height = 0.2) +
    # Axis
    scale_x_continuous(limits = c(0, 12),
                       breaks = c(0, 2, 4, 6, 8, 10, 12)) +
    # Labels
    labs(y="", x="\nNumbers needed to treat") +
    # Tweak theme
    theme(legend.position = 'none',
          axis.line = element_blank(),
          axis.text=element_text(size=24),
          axis.title=element_text(size=24),
          axis.ticks = element_blank(),
          panel.grid.major = element_line(colour = 'gray70'),
          panel.background = element_blank())

# Save plot
ggsave('./images/nnt.pdf', nnt,
       width = 11, height = 9)

# Clear environment
rm(list = ls())