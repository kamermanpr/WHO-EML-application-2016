############################################################
#                                                          #
#   AE withdrawals meta-analysis of gabapentin studies     #
#                                                          #
############################################################
# Load packages
library(readr)
library(dplyr)
library(metafor)

# Preamble
##########
# Data extracted from Moore et al., 2014
# Added dummy numbers: 0.01 and 0.009 to Levendoglu to allow calculation

# Import data
#############
meta_analysis <- read_csv('./data/AE_meta.analysis.csv')


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

## Low risk for allocation bias
low_risk <- filter(meta_analysis, allocation_bias == 'low risk')
low.risk_rma <- rma.mh(measure = 'RD',
                       ai = treated_outcome_n,
                       bi = treated_no.outcome_n,
                       n1i = treated_total_n,
                       ci = control_outcome_n,
                       di = control_no.outcome_n,
                       n2i = control_total_n,
                       data = low_risk,
                       slab = study)

## Unclear risk of allocation bias
unclear_risk <- filter(meta_analysis, allocation_bias == 'unclear')
unclear.risk_rma <- rma.mh(measure = 'RD',
                           ai = treated_outcome_n,
                           bi = treated_no.outcome_n,
                           n1i = treated_total_n,
                           ci = control_outcome_n,
                           di = control_no.outcome_n,
                           n2i = control_total_n,
                           data = unclear_risk,
                           slab = study)

# Plot full dataset
###################
pdf('./images/adverse_events-RR.pdf')

## Forest plot
### rows argument is used to specify exactly in
### which rows the outcomes will be plotted
forest(x = full_rma,
       showweights = TRUE,
       mlab = 'Overall fixed-effect model',
       col = 'red',
       order = order(-meta_analysis$ID),
       rows = c(3:7, 12:17),
       ylim = c(-1, 21),
       xlim = c(-1.5, 2))

## Add text for the subgroups
text(-1.5, pos = 4, c(18, 8), c("Low risk of bias",
                                "Unclear risk of bias"), font = 4)

## Change font to bold
par(font = 2)

## Add column labels
text(x = -1.5, y = 19.5, pos = 4, labels = 'Study (CONDITION)')
text(x = 1.02, y = 19.5, labels = 'Weight', font = 2)
text(x = 1.25, y = 20.5, pos = 4, labels = 'Risk Difference')
text(x = 1.4, y = 19.5, pos = 4, labels = '[95% CI]')

## Change font to italics only
par(font = 3)

## add summary polygons for the three subgroups
addpoly(low.risk_rma,
        col = 'lightblue',
        row = 10.5,
        mlab="Fixed-effect model for subgroup")
addpoly(unclear.risk_rma,
        col = 'lightblue',
        row = 1.5,
        mlab="Fixed-effect model for subgroup")

dev.off()

# Clean environment
rm(list = ls())
