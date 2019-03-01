# Create the R scripts files

knitr::purl(input="R/R-session-03-data_wrangling.Rmd", 
     output="R/R-session-03-data_wrangling.R", 
     documentation=1)

knitr::purl(input="R/R-session-04-data_visualization.Rmd", 
     output="R/R-session-04-data_visualization.R", 
     documentation=1)

# Regular expression to clean the code
#   -\s[^-]+-  replace by --