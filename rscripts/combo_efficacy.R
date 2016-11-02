############################################################
#                                                          #
#   Efficacy meta-analysis of gabapentin vs TCA studies    #
#                                                          #
############################################################
# Load packages
library(readr)
library(dplyr)
library(metafor)

# Preamble
##########
# NNT data extracted from Moore et al., 2014

# Import data
#############
meta_analysis <- read_csv('./data/combo_meta.analysis.csv')


# Fixed effect model (MH method)
################################
## All groups
full_rma <- rma.mh(measure = 'RD',
                   ai = treated_outcome_n,
                   bi = treated_no.outcome_n,
                   n1i = treated_total_n,
                   ci = control_outcome_n,
                   di = control_no.outcome_n,
                   n2i = control_total_n,
                   data = meta_analysis,
                   slab = study)

# Plot full dataset
###################
pdf('./images/combo-RR.pdf')

## Forest plot
### rows argument is used to specify exactly in
### which rows the outcomes will be plotted
forest(x = full_rma,
       showweights = TRUE,
       mlab = 'Overall fixed-effect model',
       col = 'red',
       order = order(meta_analysis$ID),
       ylim = c(-1, 5),
       xlim = c(-1.5, 1.5))

## Change font to bold
par(font = 2)

## Add column labels
text(x = -1.5, y = 3.2, pos = 4, labels = 'Study (CONDITION)')
text(x = 0.62, y = 3.2, labels = 'Weight', font = 2)
text(x = 0.88, y = 3.5, pos = 4, labels = 'Risk Difference')
text(x = 1, y = 3.2, pos = 4, labels = '[95% CI]')

dev.off()

# Clean environment
rm(list = ls())
