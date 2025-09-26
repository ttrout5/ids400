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

ggplot(data = df, 
       mapping = aes(x = product)) + 
        geom_bar(fill = "lightblue", col = "red") +
        xlab("Product Name") +
        ylab("Frequency") +
        ggtitle("Frequency of Product Sales")


## Numeric variable: profit
## For a univariate chart for a numeric variable - boxplots, histograms, violin plots

ggplot(data = df,
       mapping = aes(x = profit)) +
        geom_histogram(fill = "lightblue", col = "red") +
        xlab("Profit") +
        ylab("Frequency") +
        ggtitle("Distribution of Profit")

ggplot(data = df,
       mapping = aes(x = profit)) +
        geom_boxplot(fill = "lightblue", col = "red") +
        xlab("Profit") +
        ylab("Frequency") +
        ggtitle("Distribution of Profit")

ggplot(data = df,
       mapping = aes(x = profit, y = 1)) +
        geom_violin(fill = "lightblue", col = "red") +
        xlab("Profit") +
        ylab("Frequency") +
        ggtitle("Distribution of Profit")

# Bivariate Plots
# --------------------------------------------------
## Both Numeric -> x = revenue, y = profit - scatterplot
ggplot(data = df,
       mapping = aes(x = revenue, y = profit)) +
        geom_point()

ggplot(data = df,
       mapping = aes(x = revenue, y = profit)) +
        geom_point(col = "red") +
        xlab("Revenue") +
        ylab("Profit") +
        ggtitle("Distribution of Profit vs. Revenue")

## One numeric, one categorical -> profit by product
ggplot(data = df,
       mapping = aes(x = profit, y = product)) +
        geom_boxplot()














        



