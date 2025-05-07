library(httr)
library(jsonlite)
library(writexl)

# Set your API key
api_key <-"YourKey"

# Define the base URL and parameters
# Insert UNITID
base_url <- "https://api.data.gov/ed/collegescorecard/v1/schools"
params <- list(
  api_key = api_key,
  fields = "school.name,latest.cost.avg_net_price.public,latest.aid.ftft_federal_loan_rate_pooled,latest.aid.median_debt.completers.overall,latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.default,latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.delinquent,latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.forbearance,latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.deferment,latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.noprogress,latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.makingprogress,latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.fullypaid,latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.discharge",
  id = "******"
)

# Build the URL with parameters
url <- modify_url(base_url, query = params)

# Make the GET request
response <- GET(url)

# Print the raw response content
print(rawToChar(response$content))

# Parse the JSON response
data <- fromJSON(rawToChar(response$content))
str(data)  # Check the structure of the parsed data

# Extract the relevant data
college_data <- data$results
str(college_data)  # Check the structure of the extracted data

# Convert the data to a data frame
college_df <- as.data.frame(college_data)

# Reorder the columns to match the correct values
college_df <- college_df[, c("school.name", "latest.cost.avg_net_price.public", "latest.aid.ftft_federal_loan_rate_pooled", "latest.aid.median_debt.completers.overall", "latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.default", "latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.delinquent", "latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.forbearance", "latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.deferment", "latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.noprogress", "latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.makingprogress", "latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.fullypaid", "latest.repayment.2_yr_bb_fed_repayment_suppressed.ugcomp.discharge")]

# Rename the columns
names(college_df) <- c("College Name", "Average Net Price", "FTIC with Fed Aid", "Median Debt", "Default Rate", "Delinquent Rate", "Forbearance Rate", "Deferment Rate", "No Progress Rate", "Making Progress Rate", "Fully Paid Rate", "Discharge Rate")

print(college_df)

# Export the data to Excel
write_xlsx(college_df, "CollegeScorecard_data.xlsx")





