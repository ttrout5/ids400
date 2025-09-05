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





