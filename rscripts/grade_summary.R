############################################################
#                                                          #
#         Format data for gabapentin GRADE summary         #
#                                                          #
############################################################

# Preamble
##########
# Data extracted from Finnerup et al., 2015

# Generate data
###############
grade <- data.frame(Category = c('GRADE questions',
                                 NA,
                                 'Number of placebo-controlled trials',
                                 'Number of patients included',
                                 'Comparison groups',
                                 'Number needed to treat (95\\% CI)',
                                 'Number needed to harm (95\\% CI)',
                                 'Initial GRADE quality rating',
                                 'Study limitations',
                                 'Inconsistency of results',
                                 'Imprecision',
                                 'Indirectness',
                                 'Publication bias',
                                 'Large effect size',
                                 'Dose response',
                                 'Serious adverse events',
                                 'Overall quality of evidence',
                                 'Desirable versus undesirable effects',
                                 'Variability in values and preferences',
                                 'Cost',
                                 '\\textbf{GRADE RECOMMENDATION}'),
                    Summary = c('i) In patients with neuropathic pain, is treatment with gabapentin for at least 3 weeks more likely to result in a reduction in pain intensity (primary outcome) as compared to placebo?',
                                'ii) In patients with neuropathic pain, is treatment with gabapentin for at least 3 weeks more likely to result in side effects and dropouts due to side effects as compared to placebo?',
                                14,
                                1728,
                                'Inert placebo: 14; Active placebo: 2',
                                '6.3 (5.0 to 8.3)',
                                '25.6 (15.3 to 78.6)',
                                'High \\newline \\textit{\\footnotesize{(all randomized, controlled trials)}}',
                                'No systematic or serious limitations \\newline \\textit{\\footnotesize{(overall risk of bias was low; see Appendix 2)}}',
                                'No important inconsistency \\newline \\textit{\\footnotesize{(9 positive trials and 5 negative trials, but no major discrepencies in effect sizes; see Figure 11 and Appendix 2)}}',
                                'Moderate imprecision',
                                'Direct',
                                'Low risk of publication bias \\newline \\textit{\\footnotesize{(see Figure 6 and 7)}}',
                                'No \\newline \\textit{\\footnotesize{(effect size was moderate)}}',
                                'Not studied',
                                'Low risk of serious harm',
                                'High quality evidence',
                                'Desirable > Undesirable',
                                'Low to moderate',
                                'Low to moderate',
                                '\\textbf{Strong recommendation for gabapentin}'))

# Save data
save(list = c('grade'),
     file = './data/grade_summary.RData')

# Clean environment
rm(list = ls())
