############################################################
# File: troutman_timothy_assignment2.R
# Author: Troutman, Timothy (650212956)
# Date: 2025-10-10
# Description: Analysis of life expectancy data
############################################################


# Workspace Setup ---------------------------------------------------------

library(dplyr)
library(readr)
library(ggplot2)

getwd()

setwd("C:/Users/trout/OneDrive/Documents/UIC MSBA/Fall 2025/IDS 400/Repo/ids400/5-assignments")

getwd()

list.files()

life_expectancy_data <- read_csv("life_expectancy_cleaned_dataset.csv")

str(life_expectancy_data)


# Part A - dplyr (Data Wrangling and Summaries) ---------------------------

# 1. Basic filtering: Filter the dataset to show only Developed countries in the year 2014. How many such records are there?
answer1_2014_developed <-
  filter(life_expectancy_data, Year == 2014, Status == "Developed")

View(count(answer1_2014_developed))

# 19 records

# 2. Selecting variables: Create a smaller dataset with only the columns: Country, Year, Life_expectancy, GDP, Schooling, and Status.
answer2_smaller_dataset <- 
  select(life_expectancy_data, Country, Year, Life_expectancy, GDP, Schooling, Status)

View(answer2_smaller_dataset)

# 3. Creating a new variable: Add a new column called GDP_per_capita defined as GDP / Population. (Hint: handle division by zero or missing values appropriately.)
# To handle missing or zero values, check if GDP is NA or if Population is either NA or 0. If so, assign a value of NA to GDP_per_capita.
answer3_GDP_per_capita <-
  mutate(life_expectancy_data, GDP_per_capita = ifelse(is.na(GDP) | is.na(Population) | Population == 0, NA, GDP / Population))

# 4. Grouped summary: Using group_by(Status), find the average and standard deviation of Life_expectancy, GDP, and Schooling.
answer4_groupby_status <- life_expectancy_data %>% 
  group_by(Status) %>% 
  summarize(avg_life_expectancy = mean(Life_expectancy),
            stddev_life_expectancy = sd(Life_expectancy, na.rm = TRUE),
            avg_GDP = mean(GDP),
            stddev_GDP = sd(GDP, na.rm = TRUE),
            avg_Schooling = mean(Schooling),
            stddev_Schooling = sd(Schooling, na.rm = TRUE))

# 5. Filtering and arranging: Among Developing countries in 2014, which 5 countries have the highest life expectancy?
answer5_highest_life_expectancy <- life_expectancy_data %>% 
  filter(Status == "Developing", Year == 2014) %>% 
  slice_max(Life_expectancy, n = 5)

# Greece, Chile, France, Israel, Canada

# 6. Chaining operations: Using a single pipeline, find the top 10 countries (overall) with the largest increase in life expectancy between 2000 and 2014.
answer6_top_ten_increase <- life_expectancy_data %>% 
  group_by(Country) %>% 
  summarize(life_expectancy_2000 = Life_expectancy[Year == 2000],
            life_expectancy_2014 = Life_expectancy[Year == 2014]) %>% 
  mutate(Life_expectancy_increase = life_expectancy_2014 - life_expectancy_2000) %>% 
  arrange(desc(Life_expectancy_increase)) %>% 
  head(10)

View(answer6_top_ten_increase)

# 7. Joins practice: Suppose you split the dataset into two: life_tbl (containing Country, Year, Life_expectancy) and economic_tbl (containing Country, Year, GDP, Schooling). Perform a join to recreate the full table.
# needs to be joined on Country and Year
life_tbl <- select(life_expectancy_data, Country, Year, Life_expectancy)

economic_tbl <- select(life_expectancy_data, Country, Year, GDP, Schooling)


answer7_full_tbl <- inner_join(life_tbl, economic_tbl, by = c("Country", "Year"))


# Part B - ggplot2 (Visualization and Insights) ---------------------------



















  
