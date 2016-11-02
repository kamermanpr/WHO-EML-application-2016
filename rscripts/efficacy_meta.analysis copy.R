############################################################
#                                                          #
#     Efficacy meta-analysis of gabapentin studies         #
#                                                          #
############################################################
# Load packages
library(readr)
library(dplyr)
library(metafor)

# Preamble
##########
# NNT data extracted from data provided by N Finnerup
# Jadad blinding score extracted from data provided by N Finnerup
# Allocation bias based on Moore et al., 2014

# Import data
#############
meta_analysis <- read_csv('./data/meta_analysis.csv')


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
pdf('./images/efficacy-RR.pdf')

## Forest plot
### rows argument is used to specify exactly in
### which rows the outcomes will be plotted
forest(x = full_rma,
       showweights = TRUE,
       mlab = 'Overall fixed-effect model',
       col = 'red',
       order = order(meta_analysis$ID),
       rows = c(3:4, 9:14),
       ylim = c(-1, 18),
       xlim = c(-1.5, 2))

## Add text for the subgroups
text(-1.5, pos = 4, c(15, 5), c("Low risk of bias",
                                "Unclear risk of bias"), font = 4)

## Change font to bold
par(font = 2)

## Add column labels
text(x = -1.5, y = 16.5, pos = 4, labels = 'Study (CONDITION)')
text(x = 1.02, y = 16.5, labels = 'Weight', font = 2)
text(x = 1.25, y = 17.5, pos = 4, labels = 'Risk Difference')
text(x = 1.4, y = 16.5, pos = 4, labels = '[95% CI]')

## Change font to italics only
par(font = 3)

## add summary polygons for the three subgroups
addpoly(low.risk_rma,
        col = 'lightblue',
        row = 7.5,
        mlab="Fixed-effect model for subgroup")
addpoly(unclear.risk_rma,
        col = 'lightblue',
        row = 1.5,
        mlab="Fixed-effect model for subgroup")

dev.off()

# Clean environment
rm(list = ls())
