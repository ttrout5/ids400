# Troutman, Timothy IDS 400 Session 4 Assignment 1 Part 2

# clear Environment Variables
rm(list = ls())

install.packages("ggplot2")

# load dplyr and lubridate libraries
library(dplyr)
library(lubridate)
library(ggplot2)

# set working directory
getwd()

setwd("C:/Users/trout/OneDrive/Documents/UIC MSBA/Fall 2025/IDS 400/Repo/ids400/5-assignments")

getwd()

list.files()

tips_data <- read.csv("tips.csv")

str(tips_data)

# 1. Which day of the week has the least number of diners on average?



# 2. Create a bar chart (ggplot2) showing the average number of diners on each day?



# 3. The default bar chart displays the bars by alphabetical order (Friday, Saturday, Sun, and Thursday). Rearrange to make the bars follow the normal week day order (Thursday, Friday, Saturday, and Sunday).



# 4. How many female smokers are in the tips dataset who have dined on a Friday?



# 5. On average, who tips more? Males or Females?



# 6. Create a new variable called tipRate (tip/totbill). Add this variable to your dataset. Create a boxplot for this variable.



# 7. Using the results from questions 4 and 5 above, can we conclude that females are more generous in tipping? Explain.



# 8. What is the number of females in this dataset who paid more than 15% tips?



# 9. Create a scatter plot with totbill on the x-axis and tip on the y-axis. The chart should show data points corresponding to female customers in a different color from points corresponding to male customers.



# 10. How many of the parties had more than 2 people? (Hint: check for NA values and make sure they are not being counted). 