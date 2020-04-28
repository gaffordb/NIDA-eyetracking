# NIDA-eyetracking

## Background
This project's goal is to analyze the eyetracking data collected as part of a drugged driving study. 

Our analysis aims to identify differences in attention strategies across drugged conditions. For more information on the study background, refer to [can we reference the AAAM paper or is that not fully public yet?]. 

[More here on drugged conditions and task description]

[More here on background information regarding the different attention behaviors, and our hypotheses based on this information]

## Project structure
While the original data is not included in this repository, we have included an empty folder at `Data/RawData` that specifies where the data should be located to run these scripts. Additionally, you will need to replace the `put-disposition-here.xls` with the actual `disposition.xls`.

This project contains the following folders:  

* `Results`  
  * Contains the results of the data analysis.
* `Analysis`
  * Contains the helper scripts to run the data analysis.
* `Cleaning`
  * Contains the cleaning scripts to go from the raw `.mat` files to the cleaned and reduced `.csv` files. 
* `Data`
  * Contains the actual data being processed.
* `Images`
  * Contains the images that are included in this `README.md` file. 

## Usage instructions
First, you will need to include the raw data and `disposition.xls` file as specified in the Project structure section above. 

To clean the data, type `r cleanData.R` into the command line at the base of this repository. 

> After this script runs, you should see the finalized data available in `Data/CleanCSV`, and it should look something like this: 
[insert screenshot of cleaned data]

To run the data analyses, you can type `r analyzeData.R` into the command line at the base of this repository.
> After this script runs, you should see an HTML file in `Results` showing the final analysis. Notice that this is currently a work in progress. 

## Things to note
This covers the overall structure of this project. The finalized analysis and cleaning scripts have not yet been completed, but you can see some of the current working scripts in the `Cleaning` and `Analysis` folders. The data cleaning scripts have not all been fixed, but it will mostly be a matter of fixing file paths and making sure everything flows correctly. 