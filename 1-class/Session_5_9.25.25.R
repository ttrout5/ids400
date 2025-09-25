# clear Environment Variables
rm(list = ls())

# load dplyr and lubridate libraries
library(dplyr)
library(lubridate)

# set working directory
getwd()

setwd(
  "C:/Users/trout/OneDrive/Documents/UIC MSBA/Fall 2025/IDS 400/Repo/ids400/1-class"
)

getwd()

# list the files
list.files()

# load data
df <- read.csv("sales_data.csv")

# check data structure
str(sales_data)

# fix data types
sales_data$region <- as.factor(sales_data$region)
sales_data$product <- as.factor(sales_data$product)
sales_data$order_date <- ymd(sales_data$order_date)

str(sales_data)

library(ggplot2)

# Number of variables to plot - univariate, bivariate, multivariate
# Type of variables - categorical, numeric, date

# Univariate Visualizations
# ------------------------------
## Categorical variable: Product
## For a univariate chart for a categorical variable - bar charts

ggplot(data = df, 
      mapping = aes(x = product)) + geom_bar()
