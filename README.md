# SB-135-Data
R Scripts to download Federal Data for Ohio's SB 135 Reporting

These are 2 R Scripts that can be used to pull in data for SB 135 reporting from College Scorecard and PSEO. To use the files you will need to get an API from the Department of Education, which you can get by going to https://collegescorecard.ed.gov/data/api-documentation,
and the US Census, which you can get at https://api.census.gov/data/key_signup.html.

Note that the scripts were generated with much assistance from Microsoft Copilot and ChatGPT.

The data dictionary for the College Scorecard is at https://collegescorecard.ed.gov/files/CollegeScorecardDataDictionary.xlsx. Note that the variable names to use to download data are combinations of dev-category and developer-friendly name and are formatted as "dev-category.developer-friendly name".
PSEO are split into 2 streams Earnings and Flows. Earnings variables can be seen at https://api.census.gov/data/timeseries/pseo/earnings/variables.html while Flows varables can be seen at https://api.census.gov/data/timeseries/pseo/flows/variables.html.
