#!/bin/bash
# processALLmonths.sh
#student: Kevin Kadak (1007522888)
#Rscript process.Covid.R $filename

# The following commands are performed in the bash terminal
for file_names in *csv # Iterate through all file names belonging to the .csv file type
do
  Rscript process.Covid.R $file_names # For each unique file name, run the R script 'process.Covid.R' in the current directory
done
