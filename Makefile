# Set additional directories 'make' must search for dependencies in
VPATH = rscripts data images

# Create dummy targets to ensure all intermediate targets are 'made'
.PHONY: all

EXECSUMMARY =  	summary.pdf
APPLICATION = 	application.pdf
ACCESSORYFILES = 	diabetes.pdf ghdx.pdf nnt.pdf adverse_events-RR.pdf \
					combo-RR.pdf dizziness-RR.pdf efficacy-RR.pdf \
					somnolence-RR.pdf \
					availability.RData cost_unit.RData cost_ddd.RData \
					cost_mdd.RData nice_cost.RData nice_qaly20k.RData \
					nice_qaly30k.RData reg_approval.RData grade_summary.RData
APPENDICES = 	appendices.pdf

all: $(EXECSUMMARY) $(APPLICATION) $(ACCESSORYFILES) $(APPENDICES)

# Generate executive summary
############################
summary.pdf: summary.Rmd
	Rscript -e "rmarkdown::render(input = '$<')"

# Generate body of application
##############################
application.pdf: 	application.Rmd diabetes.pdf ghdx.pdf nnt.pdf \
					adverse_events-RR.pdf combo-RR.pdf dizziness-RR.pdf \
					efficacy-RR.pdf somnolence-RR.pdf \
					availability.RData cost_unit.RData cost_ddd.RData \
					cost_mdd.RData nice_cost.RData nice_qaly20k.RData \
					nice_qaly30k.RData reg_approval.RData grade_summary.RData
	Rscript -e "rmarkdown::render(input = '$<')"

# Generate accessory-files
##########################
# Data-driven plots
images/diabetes.pdf: diabetes.R
	Rscript "$<"
images/ghdx.pdf: ghdx.R
	Rscript "$<"
images/nnt.pdf: nnt.R
	Rscript "$<"
images/adverse_events-RR.pdf: AE_meta.analysis.R
	Rscript "$<"
images/combo-RR.pdf: combo_efficacy.R
	Rscript "$<"
images/dizziness-RR.pdf: dizziness_meta.analysis.R
	Rscript "$<"
images/efficacy-RR.pdf: efficacy_meta.analysis.R
	Rscript "$<"
images/somnolence-RR.pdf: somnolence_meta.analysis.R
	Rscript "$<"

# .RData files for tables
data/availability.RData: availability.R
	Rscript "$<"
data/cost_unit.RData: cost_unit.R
	Rscript "$<"
data/cost_ddd.RData: cost_ddd.R
	Rscript "$<"
data/cost_mdd.RData: cost_mdd.R
	Rscript "$<"
data/nice_cost.RData: nice_cost.R
	Rscript "$<"
data/nice_qaly20k.RData: nice_qaly20k.R
	Rscript "$<"
data/nice_qaly30k.RData: nice_qaly30k.R
	Rscript "$<"
data/reg_approval.RData: reg_approval.R
	Rscript "$<"
data/grade_summary.RData: grade_summary.R
	Rscript "$<"

# Generate appendices
#####################
appendices.pdf: appendices.Rmd
	Rscript -e "rmarkdown::render(input = '$<')"