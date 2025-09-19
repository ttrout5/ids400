# Troutman, Timothy IDS 400 Session 4 Assignment 1 Part 1

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
sales_data <- read.csv("sales_data.csv")

# check data structure
str(sales_data)

# fix data types
sales_data$region <- as.factor(sales_data$region)
sales_data$product <- as.factor(sales_data$product)
sales_data$order_date <- ymd(sales_data$order_date)



# Part A: Selecting Columns
# 1. Select all columns that start with 'cust' or 'order'.
answer1 <- select(sales_data, starts_with("cust"), starts_with("order"))

# 2. Select only columns that end with 'id'.
answer2 <- select(sales_data, ends_with("id"))

# 3. Use contains ('rev') to select all columns related to revenue (and verify the result).
answer3 <- select(sales_data, contains("rev"))


# Part B: Filtering Rows
# 4. Filter all orders where revenue > 1000.
answer4 <-
  filter(sales_data, revenue > 1000)

# 5. Filter all orders where region == 'West' AND profit > 300.
answer5 <-
  filter(sales_data, region == "West" & profit > 300)

# 6. Filter all orders placed in January 2021 (hint: use lubridate::month() and lubridate::year() on order_date).
answer6 <-
  filter(sales_data, month(order_date) == 01 &
           year(order_date) == 2021)

# Alternate answer for 6 (introducing new columns)
sales_data$year <- year(sales_data$order_date)
sales_data$month <- month(sales_data$order_date)

answer6_alt <- filter(sales_data, year == 2021, month == 1)

# Part C: Summarizing
# 7. Find the average revenue and average profit across all orders
answer7 <- summarize(sales_data,
                     avg_revenue = mean(revenue),
                     avg_profit = mean(profit))

# 8. For each region, compute total revenue and order the results from highest to lowest.
answer8 <- sales_data %>%
  group_by(region) %>%
  summarize(total_revenue = sum(revenue)) %>%
  arrange(desc(total_revenue))

# 9. For each product, computer the average profit and number of orders.
answer9 <- sales_data %>%
  group_by(product) %>%
  summarize(avg_profit = mean(profit), num_orders = n())

# Part D: Summarize All/Across
# 10. Use summarise_all(mean) to compute the mean of all numeric columns.
answer10 <- sales_data %>%
  select(revenue, profit) %>%
  summarize_all(mean)

answer10_alt <- sales_data %>%
  select_if(is.numeric) %>%
  summarize_all(mean)

answer10_alt2 <-  sales_data %>%
  summarize_if(is.numeric, mean)

# 11. Use summarise(across(where(is.numeric), max)) to find the maximum of all numeric columns.
answer11 <- sales_data %>%
  summarize(across(where(is.numeric), max))

answer11_alt <- sales_data %>%
  summarize_if(is.numeric, mean)

# 12. For each region, compute both the minimum and maximum of revenue and profit (use group_by(region) + summarise(across(...))).
answer12 <- sales_data %>%
  group_by(region) %>%
  summarize(
    min_rev = min(revenue),
    max_rev = max(revenue),
    min_profit = min(profit),
    max_profit = max(profit)
  )

# Part E: Mutate and Arrange
# 13. Create a new column profit_margin = profit/revenue, then arrange orders by highest profit_margin.
answer13 <- mutate(sales_data, profit_margin = profit / revenue) %>%
  arrange(desc(profit_margin))

# 14. Create a new column order_month using lubridate::month(order_date, label = TRUE). Summarize total revenue by month.
answer14 <- sales_data %>%
  mutate(order_month = month(order_date, label = TRUE)) %>%
  group_by(order_month) %>%
  summarize(total_revenue = sum(revenue))

# 15. Create a new column order_year using lubridate::year(order_date). Count how many orders were placed each year.
answer15 <- sales_data %>%
  mutate(order_year = year(order_date)) %>%
  group_by(order_year) %>%
  summarize(num_orders = n())
