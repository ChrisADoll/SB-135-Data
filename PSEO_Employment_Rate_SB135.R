library(httr)
library(jsonlite)
library(openxlsx)  # for Excel output

api_key <- "YourKey"

# Set up request for Flows data
base_url <- "https://api.census.gov/data/timeseries/pseo/flows"

params <- list(
  get = "Y1_GRADS_EMP,Y1_GRADS_NME,INSTITUTION,DEGREE_LEVEL,GRAD_COHORT,GRAD_COHORT_YEARS",
  INSTITUTION = "01104600",
  GRAD_COHORT = "2016",
  GRAD_COHORT_YEARS="5",
  `for` = "us:*",
  key = api_key
)

url <- modify_url(base_url, query = params)

response <- GET(url)
response_content <- content(response, "text")
print(response_content)

if (status_code(response) == 200) {
  data <- fromJSON(response_content)
  df <- as.data.frame(data[-1,])
  colnames(df) <- data[1,]
  
  # Convert relevant columns to numeric
  df$Y1_GRADS_EMP <- as.numeric(df$Y1_GRADS_EMP)
  df$Y1_GRADS_NME <- as.numeric(df$Y1_GRADS_NME)
  
  # Calculate employment rate
  df$Employment_Rate <- with(df, Y1_GRADS_EMP / (Y1_GRADS_EMP + Y1_GRADS_NME))
  
  # View a few rows
  head(df)
  
  # Export to Excel
  write.xlsx(df, file = "employment_rate_output_SP_25.xlsx", sheetName = "EmploymentRates", overwrite = TRUE)
  print("✅ Excel file written: employment_rate_output.xlsx")
  
} else {
  print(paste("Error:", status_code(response)))
}

