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
str(df)

# fix data types
df$region <- as.factor(df$region)
df$product <- as.factor(df$product)
df$order_date <- ymd(df$order_date)

str(df)

library(ggplot2)

# Number of variables to plot - univariate, bivariate, multivariate
# Type of variables - categorical, numeric, date

# Univariate Visualizations
# ------------------------------
## Categorical variable: Product
## For a univariate chart for a categorical variable - bar charts

ggplot(data = df, mapping = aes(x = product)) + geom_bar()

ggplot(data = df, mapping = aes(x = product)) +
  geom_bar(fill = "lightblue", col = "red") +
  xlab("Product Name") +
  ylab("Frequency") +
  ggtitle("Frequency of Product Sales")


## Numeric variable: profit
## For a univariate chart for a numeric variable - boxplots, histograms, violin plots

ggplot(data = df, mapping = aes(x = profit)) +
  geom_histogram(fill = "lightblue", col = "red") +
  xlab("Profit") +
  ylab("Frequency") +
  ggtitle("Distribution of Profit")

ggplot(data = df, mapping = aes(x = profit)) +
  geom_boxplot(fill = "lightblue", col = "red") +
  xlab("Profit") +
  ylab("Frequency") +
  ggtitle("Distribution of Profit")

ggplot(data = df, mapping = aes(x = profit, y = 1)) +
  geom_violin(fill = "lightblue", col = "red") +
  xlab("Profit") +
  ylab("Frequency") +
  ggtitle("Distribution of Profit")

# Bivariate Plots
# --------------------------------------------------
## Both Numeric -> x = revenue, y = profit - scatterplot
ggplot(data = df, mapping = aes(x = revenue, y = profit)) +
  geom_point()

ggplot(data = df,
       mapping = aes(x = revenue, y = profit, col = product)) +
  geom_point() +
  xlab("Revenue") +
  ylab("Profit") +
  ggtitle("Distribution of Profit vs. Revenue")

## One numeric, one categorical -> profit by product
ggplot(data = df, mapping = aes(x = profit, y = product)) +
  geom_boxplot()

ggplot(data = df, mapping = aes(x = profit, y = product)) +
  geom_violin()

## One date variable and one numeric

ggplot(data = df, mapping = aes(x = order_date, y = profit)) +
  geom_line()
#### You need to aggregate first
data_summarized_by_date <- group_by(df, order_date) %>%
  summarize(total_profit = sum(profit))

View(data_summarized_by_date)

ggplot(data = data_summarized_by_date,
       mapping = aes(x = order_date, y = total_profit)) +
  geom_line(col = "red")


## Make multiple histograms in the same chart
ggplot(data = df, mapping = aes(x = profit, fill = product)) +
  geom_histogram(alpha = 0.6)

## Make different line charts showing avg profit per month for each year - don't add variables this way - use mutate instead
profit_by_year_and_month <- group_by(df, year = year(order_date), month = (month(order_date)) %>% 
  summarize(totalprofit = sum(profit))

# profit_by_year_and_month <- mutate(df,
#                                    year = year(order_date)),
#                                   month = month(order_date)

# group_by(df, year = year(order_date), month = month(order_date)) %>% 
#   summarize(totalprofit = sum(profit))

month <- mutate(df, month(order_date))

ggplot(data = profit_by_year_and_month,
       mapping = aes(x = month, y = totalprofit, col = factor(year))) +
  geom_line()

# Multivariate Plots
# ------------------------------------------------
## Plot the average profit
profit_by_product_and_region <- 
        group_by(df, product, region) %>% 
        summarize(avgprofit = mean(profit))

ggplot(data = profit_by_product_and_region,
       mapping = aes(x = product,
                     y = region,
                     fill = avgprofit)) + 
                      geom_tile() +
                      scale_fill_gradient(low = "red", high = "green")



# Faceting ----------------------------------------------------------------
## Create a different chart for each year showing revenue by month
ggplot(data = profit_by_year_and_month,
       mapping = aes(x = month, y = totalprofit)) +
  geom_line() +
  facet_grid(~year)

ggplot(data = profit_by_year_and_month,
       mapping = aes(x = month, y = totalprofit)) +
  geom_line() +
  facet_grid(region~year)

## Create a different chart for each year and each region showing revenue by month
profit_by_year_month_and_region <- 
  mutate(df,
         year = factor(year(order_date)),
         month = month(order_date)) %>% 
  group_by(year, month, region) %>% 
  summarize(totalprofit = sum(profit))

ggplot(data = profit_by_year_month_and_region,
       mapping = aes(x = month, y = totalprofit)) +
        geom_line() +
        facet_grid(region~year)
                      
