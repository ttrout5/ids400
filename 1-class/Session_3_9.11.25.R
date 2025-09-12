# Refresher
# To get started with R you need to do the following:
# 1) Download and install R - available on the posit website or you can google R for Windows or Mac
# 2) AFTER installing R - install Rstudio - also available on posit website or again just google it.

install.packages("dplyr")
library(dplyr)

marketing_data <- read.csv("marketing_campaign.csv")

getwd()

setwd("C:/Users/trout/OneDrive/Documents/UIC MSBA/Fall 2025/IDS 400/Repo/ids400/1-class")

str(marketing_data)
summary(marketing_data)

## Write a piece of code to return the average amount spent on individual categories i.e. wines, fruits, meat products, fish products, sweet products and gold products. Aggregate the data by education level but do not include customers who have kids at home.

dplyr::filter

## Method 1 - do it step by step
data_nokids <-  dplyr::filter(marketing_data, Kidhome == 0)

## Next, we can reduce the number of columns and only keep what we need
data_nokids_mntcolumns <- select(data_nokids, Education, MntWines,
                                 MntFruits, MntMeatProducts, MntFishProducts,
                                 MntSweetProducts, MntGoldProds)

data_nokids_mntcolumns_alt <- select(data_nokids, Education, starts_with("Mnt"))

## We need to tell R that I want to aggregate my data by groups based on Education
data_nokids_mntcolumns_grouped <- group_by(data_nokids_mntcolumns, Education)

## Summarize the data
data_final <- summarize(data_nokids_mntcolumns_grouped, 
                        avg_wine_spend = mean(MntWines),
                        avg_fruit_spend = mean(MntFruits),
                        avg_meat_spend = mean(MntMeatProducts),
                        avg_fish_spend = mean(MntFishProducts),
                        avg_sweet_spend = mean(MntSweetProducts),
                        avg_gold_spend = mean(MntGoldProds))

## Alternatively
data_final_alt <- summarize_all(data_nokids_mntcolumns_grouped, mean)

## We can do all of this in one go through piping
data_final_piping <- 
  filter(marketing_data, Kidhome == 0) %>% 
  select(Education, starts_with("Mnt")) %>% 
  group_by(Education) %>% 
  summarize_all(mean)

## Practice Question
## Write a piece of code to return the average number of purchases made via different channels i.e. Deals, Web, Catalog, Store. Aggregate the data by marital status but do not include customers born after 1980.

data_practice_question <- 
  filter(marketing_data, Year_Birth <= 1980) %>% 
  select(Marital_Status, ends_with("Purchases")) %>% 
  group_by(Marital_Status) %>% 
  summarize_all(mean)

data_practice_question

## Practice Question
## Write a piece of code to return the average number of purchases made via different channels i.e. Deals, Web, Catalog, Store. Aggregate the data by marital status but do not include customers born after 1980. Show results only for marital statuses where the avg number of purchases from web are greater than the avg number of purchases from deals.

data_practice_question_expanded <- 
  filter(marketing_data, Year_Birth <= 1980) %>% 
  select(Marital_Status, ends_with("Purchases")) %>% 
  group_by(Marital_Status) %>% 
  summarize_all(mean) %>% 
  filter(NumWebPurchases > NumDealsPurchases)


## Detour
## slice_max
slice_max_example <- slice_max(marketing_data, Year_Birth)

## is.na
x <- c(1,2,NA,5,6)
condition1 <- is.na(x)
x[!condition1]

data_practice_question_expanded[1,2] <- NA
condition2 <- is.na(data_practice_question_expanded$NumDealsPurchases)
filter(data_practice_question_expanded, !condition2)

## Back to main material
# In dplyr, we now know the following:
# Select, filter, group_by, summarize

# There are two commands left:
# arrange, mutate

# arrange(data, column) arranges your data by the column
data_arranged <- arrange(marketing_data, Year_Birth)
data_arranged2 <- arrange(marketing_data, Marital_Status, Year_Birth)
data_arranged3 <- arrange(marketing_data, Marital_Status, desc(Year_Birth))
data_arranged4 <- arrange(marketing_data, desc(Marital_Status), desc(Year_Birth))

# mutate(data, expression) creates a new column in your dataset
# Create a new variable in your data that is a ratio of Number of web visits to number of web purchases

data_newvar <- mutate(marketing_data, WebPurchaseRatio = NumWebPurchases/NumWebVisitsMonth)


# Working with dates
str(marketing_data)
install.packages("lubridate")
library(lubridate)

# There are many date formats:
# dmy, mdy, ymd, dmy hh:mm, dmy hh:mm:ss, hh:mm etc.
# With dplyr - you need to know the format of your date
# We observe that there is a date written as "21/08/2013" -> "dd/mm/yy"
# So to convert it to date we will do the following:
marketing_data$Dt_Customer <- dmy(marketing_data$Dt_Customer)
str(marketing_data)

# So once you have converted the character to a date, you can use many date functions on it.

# Create a new variables in your dataset containing the different elements of the date i.e. I want a column for year, a column for month, a column for day, and a column for weekday

data_data_vars <- mutate(marketing_data, 
                         Dt_Customer_year = year(Dt_Customer),
                         Dt_Customer_month = month(Dt_Customer),
                         Dt_Customer_day = day(Dt_Customer),
                         Dt_Customer_weekday = wday(Dt_Customer))

View(data_data_vars)

data_data_vars_v2 <- mutate(marketing_data, 
                         Dt_Customer_year = year(Dt_Customer),
                         Dt_Customer_month = month(Dt_Customer, abbr = T, label = T),
                         Dt_Customer_day = day(Dt_Customer),
                         Dt_Customer_weekday = wday(Dt_Customer, abbr = F, label = T))

View(data_data_vars_v2)
