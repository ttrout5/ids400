### IDS 400 Lab 1 ###

# clear Environment Variables
rm(list = ls())

# install needed packages: readr, dplyr, and janitor
install.packages(c("readr", "dplyr", "janitor"))

# load above packages for use
library(readr)
library(dplyr)
library(janitor) # used to clean names - clean_names() function standardizes column names in dataframe. Handles problematic names by converting them to consistent format.

# get current working directory
getwd()

# set working directory to work with data
setwd("C:/Users/trout/OneDrive/Documents/UIC MSBA/Fall 2025/IDS 400/Repo/ids400/4-labs")

# ensure working directory is correct with files
getwd()
list.files()

# load pokemon data for use and pipe to clean_names() function from janitor library to format/standardize/clean names
pokemon_data <- read.csv("Pokemon.csv") %>% 
  clean_names()
