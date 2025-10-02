############################################################
# File: troutman_timothy_lab2.R
# Author: Troutman, Timothy (650212956)
# Date: 2025-09-30
# Description: Lab 2 Assignment R Script for Netflix Titles
############################################################

# Workspace Setup ---------------------------------------------------------
# install.packages("tidytext")

library(dplyr)
library(ggplot2)
library(lubridate)
library(readr)
library(tidyr)
library(tidytext)
library(stringr)

getwd()

setwd("C:/Users/trout/OneDrive/Documents/UIC MSBA/Fall 2025/IDS 400/Repo/ids400/4-labs")

getwd()

list.files()

netflix_data <- read_csv("netflix_titles.csv")

str(netflix_data)

# dplyr Practice ----------------------------------------------------------

# 1. How many Movies and TV Shows are in the dataset?
answer1 <- netflix_data %>% 
  count(type)

answer1

# 2. Which 5 countries have the most Netflix titles?
answer2 <- netflix_data %>% 
  filter(!is.na(country)) %>%
  separate_rows(country, sep = ", ") %>% 
  count(country, sort = TRUE) %>% 
  slice_max(n, n = 5)


# 3. How many titles were added to Netflix since 2019?
answer3 <- 
  filter(netflix_data, release_year >= 2019) %>% 
  summarize(count = n())

answer3

# 4. What are the top 10 most common genres listed on Netflix?
answer4 <- netflix_data %>%
  separate_rows(listed_in, sep = ", ") %>% 
  count(listed_in, sort = TRUE) %>% 
  slice_max(n, n = 10)

answer4

# ggplot2 Practice --------------------------------------------------------

# 5. Create a bar chart to show how many Movies and TV Shows are in the dataset.
ggplot(data = netflix_data, mapping = aes(x = type)) +
  geom_bar(fill = "blue4") +
  xlab("Media Type") +
  ylab("Count") +
  ggtitle("Count of Movies and TV Shows") +
  theme(plot.title = element_text(hjust = 0.5))

# 6. How many titles were released each year? Explain using a line plot.
count_of_titles_by_year <- 
  group_by(netflix_data, release_year) %>% 
  summarize(count = n())

ggplot(data = count_of_titles_by_year, mapping = aes(x = release_year, y = count)) +
  geom_line(col = "black") +
  xlab("Release Year") +
  ylab("Count of Titles") +
  ggtitle("Count of Titles Per Release Year") +
  theme(plot.title = element_text(hjust = 0.5))

# 7. Generate a stacked bar chart to compare the distribution of ratings between Movies and TV Shows.
netflix_data %>% filter(!is.na(rating)) %>% 
  ggplot(mapping = aes(x=type, fill=rating)) +
  geom_bar() +
  labs(title = "Ratings by Content Type", x = "Type", y = "Proportion") +
  theme(plot.title = element_text(hjust = 0.5))


# 8. Create a violin plot showing how movie durations vary across different genres. What patterns do you notice?
netflix_data_modified <- netflix_data %>% 
  filter(type == "Movie", !is.na(duration), !is.na(listed_in)) %>% 
  mutate(
    duration_mins = parse_number(duration),
    main_genre = str_split(listed_in, ",") %>% sapply(`[`, 1)  %>%  str_trim())

ggplot(data = netflix_data_modified, mapping = aes(x = duration_mins, y = main_genre)) +
  geom_violin() +
  labs(title = "Duration of Different Movie Genres", x = "Duration (mins)", y = "Genre") +
  theme(plot.title = element_text(hjust = 0.5), axis.text.y = element_text(hjust = 0))

# NEED TO CREATE VIOLIN PLOT
# NEED TO ANSWER WHAT PATTERNS I NOTICE

# 9. Create a horizontal bar chart to display the ten most frequent genres represented in the dataset.
top_ten_genres <- netflix_data %>%
  separate_rows(listed_in, sep = ", ") %>% 
  count(listed_in, sort = TRUE) %>% 
  slice_max(n, n = 10)

ggplot(data = top_ten_genres, mapping = aes(x = reorder(listed_in, n), y = n)) +
  geom_col(fill = "darkgreen") +
  coord_flip() +
  labs(title = "Top 10 Netflix Genres", x = "Genre", y = "Count") +
  theme(plot.title = element_text(hjust = 0.5), axis.text.y = element_text(hjust = 0))

# 10. Create a heatmap showing the number of Netflix titles by release year and content type.
netflix_data %>% 
  filter(!is.na(release_year), release_year>=2000) %>% 
  count(release_year, type) %>% 
  ggplot(mapping = aes(x=type, y=release_year, fill = n)) +
  geom_tile() +
  scale_fill_gradient(low = "lightyellow", high = "firebrick") +
  labs(title = "Number of Titles by Year and Type", x = "Content Type", y = "Release Year", fill = "count") +
  theme(plot.title = element_text(hjust = 0.5))
