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
