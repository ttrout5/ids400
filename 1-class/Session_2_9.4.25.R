# Agenda: we want to learn how to work with dataframes
# To work with dataframes, we use the library dplyr

# Installing libraries
install.packages("dplyr") # This only needs to be done once

# Load a library
library(dplyr) # This needs to be done every time you start a new R session

# Check working directory
getwd()

# Set working directory
setwd("~/UIC MSBA/Fall 2025/IDS 400/Repo/ids400/1-class")

# Load the file
list.files()
data <- read.csv("marketing_campaign.csv")

# Check column names
colnames(data)

# Check structure of data
str(data)
## We notice 4 potential issues: Education and Marital Status are characters not factor, ID is int not factor, and Dt_Customer is a character not a date.

data$ID <- as.factor(data$ID)
data$Marital_Status <- as.factor(data$Marital_Status)
data$Education <- as.factor(data$Education)
### We will come back to fixing the date column
str(data)

# Subsetting dataframes
data[1, 5]
data[1:3, 1:5]
data[1, ]
data[ , 1]

# Check the frequency distribution of categorical variables
table(data$Education)
table(data$Marital_Status)

# We will change marital status "Alone" to "Single"
data$Marital_Status <- as.character(data$Marital_Status)
condition1 <- data$Marital_Status == "Alone"
sum(condition1) # This returns 3 because TRUE = 1 and FALSE = 0
data[condition1, ]
data[condition1, ]$Marital_Status <- "Single"
table(data$Marital_Status)

# And we will remove the rows that have status "YOLO" or "Absurd"


##################### dplyr
# When working with dataframes, you should know the following:
# 1) How to select columns
# 2) How to filter rows
# 3) How to aggregate overall
# 4) How to group and aggregate
# 5) How to make new variables
# 6) How to sort the data

# Filtering Data
## Remove the values YOLO and Absurd from Marital_Status
data_filtered <- filter(data, Marital_Status != "YOLO", Marital_Status != "Absurd")

## Filter the data to retain customers who spent more than $500 on wines OR are single
data_temp <- filter(data, MntWines > 500 | Marital_Status == "Single")

# Select different columns from a dataframe
## Write a query that returns only the columns ID, Year_Birth, Education, Marital_Status
data_temp <- select(data, ID, Year_Birth, Education, Marital_Status)
data_temp <- select(data, ID:Marital_Status)

## Write a query that returns only the columns ID, Year_Birth, Marital_Status (so I want to exclude Education)
data_temp <- select(data, ID:Marital_Status, -Education)
## Write a query to select columns Kidhome until Recency and Complain until Response
data_temp <- select(data, Kidhome:Recency, Complain:Response)
## Write a query to return all columns starting with Mnt
data_temp <- select(data, starts_with("Mnt"))
## Write a query to return all columns ending with Purchases
data_temp <- select(data, ends_with("Purchases"))
## Write a query to return all columns that contain P
data_temp <- select(data, contains("P"))

# Data Aggregation
## Return the mean value for the column MntWines
summarize(data, mean(MntWines))
## Return the agg stats for the column MntWines
summarize(data, avgsales = mean(MntWines), minsales = min(MntWines), maxsales = max(MntWines), mediansales = median(MntWines))

# Detour --- Piping
## Calculate the average amount spent on wines by singles
data_temp <- filter(data, Marital_Status == "Single")
summarize(data_temp, mean(MntWines))

## This is a pipe --- %>%
filter(data, Marital_Status == "Single") %>%
  summarize(mean(MntWines))

## Calculate the average amount spent on wines by singles have kids at home
filter(data, Marital_Status == "Single") %>%
  filter(Kidhome > 0) %>%
  summarize(mean(MntWines))


# Grouped aggregation
## Calculate average spend on wines by Marital Status
group_by(data, Marital_Status) %>%
  summarize(mean(MntWines))
