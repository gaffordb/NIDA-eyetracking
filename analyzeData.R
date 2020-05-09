require(dplyr)
require(ggplot2)
require(openintro)
require(lattice)
require(rmarkdown)

root = file.path(".")

print(getwd())
if(!dir.exists("Results")) {
  dir.create("Results")
}
rmarkdown::render(file.path(root, "Analysis", "exploratoryVisualizations.Rmd"), 
                  output_dir = file.path('.', 'Results'), 
                  output_file = 'visualizations.html')
