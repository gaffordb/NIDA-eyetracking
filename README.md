# NIDA-eyetracking

## Background
We examined data acquired from the University of Iowa’s National Advanced Driving Simulator. With this state-of-the-art simulator, they collected real-time data on drivers under the impairment of THC and/or alcohol. There were a total of 19 participants in the study, and each participant did a total of 6-test drives, representing distinct impairment conditions.This project's goal is to analyze the eyetracking data collected as part of a drugged driving study.  Our analysis aims to identify differences in attention strategies across drugged conditions. For more information on the study background, refer to [can we reference the AAAM paper or is that not fully public yet?]. 

[More here on drugged conditions and task description]

Healthy marijuana using adults were tested to see alcohol and marijuana effects on driving using University of Iowa National Advanced Driving Simulator. NIDA employed a full vehicle cab simulator with a 360° horizontal field of view and a motion base that provides realistic feedback. Each study participant attended 6 sessions, separated by washout periods greater or equal to one week. They Received treatments of cannabis (placebo, low THC, high THC) and alcohol (placebo, active) in randomized order. Participants did 45 minute drive containing varied road segments and numerous programmed events. The different road segments included rural, urban, highway, and  rural straight topgraphies. 

During the 6 individual test-drives, participants completed 3 different secondary tasks intended to measure the effects of dosing levels. The Seconday tasks included, the mirror reading task, artist search task, and message reading task. They are as follows: 

Side Mirror Task

The side-mirror task required the participant to push a button whenever a red triangle appeared in one of their side-mirrors. If ignored, the triangle disappeared after 5 seconds, resulting in an incompletion for that instance of the task. Otherwise the length of time the triangle was visible prior to completion was recorded. The side-mirror task occurred 14 times during each drive. 

Artists Search Task

The artist-search task required the participant to select the correct artist from a navigable touchscreen menu on vehicle’s console. Contained 3 pages, each listing 12 artists. The task occurred 3 times during each drive, and participants had 10 seconds to provide a correct response before failing that instance of the task. 

Message Reading Task

This task required participants to read aloud a text message shown on the car’s display. Messages were designed to be of equal difficulty. Contained an average of 18 words (min=15, max =24) and 111 characters (min = 93, max = 141). The task occurred 6 times in each drive, with each message displayed for 10 seconds.

For the purposes of this project we will only be analyzing the artist search task. The reaosn being is that this search task happens eclusivley on the interstate segement of the drive. e. We have access to estimates of the THC levels as well as blood alchohol content (BAC) for this portion of the simulation. 



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

To clean the data, type `RScript cleanData.R` into the command line at the base of this repository. 

> After this script runs, you should see the finalized data available in `Data/CleanCSV`, and it should look something like this: 
[insert screenshot of cleaned data]

To run the data analyses, you can type `RScript analyzeData.R` into the command line at the base of this repository.
> After this script runs, you should see an HTML file in `Results` showing the final analysis. Notice that this is currently a work in progress. 

## Things to note
This covers the overall structure of this project. The finalized analysis and cleaning scripts have not yet been completed, but you can see some of the current working scripts in the `Cleaning` and `Analysis` folders. The data cleaning scripts have not all been fixed, but it will mostly be a matter of fixing file paths and making sure everything flows correctly. 
