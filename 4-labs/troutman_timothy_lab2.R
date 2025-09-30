# Troutman, Timothy IDs 400 Lab 2 -----------------------------------------

# Workspace Setup ---------------------------------------------------------
library(dplyr)
library(ggplot2)

getwd()

setwd("C:/Users/trout/OneDrive/Documents/UIC MSBA/Fall 2025/IDS 400/Repo/ids400/4-labs")

getwd()

list.files()

netflix_data <- read.csv("netflix_titles.csv")

str(netflix_data)

# dplyr Practice ----------------------------------------------------------

# 1. How many Movies and TV Shows are in the dataset?
answer1 <- netflix_data %>% 
  summarize(count = n())

answer1

# 2. Which 5 countries have the most Netflix titles? ---NEED HELP WITH THIS - THE COUNTRY FIELD CONTAINS A LIST OF COUNTRIES SOMETIMES
answer2 <- netflix_data %>% 
  group_by(country) %>% 
  summarize(count = n())

answer2

# 3. How many titles were added to Netflix since 2019?
answer3 <- 
  filter(netflix_data, release_year >= 2019) %>% 
  summarize(count = n())

answer3

# 4. What are the top 10 most common genres listed on Netflix?
answer4 <- netflix_data %>% 
  group_by(listed_in) %>% 
  summarize(count = n())

# ggplot2 Practice --------------------------------------------------------

# 5. Create a bar chart to show how many Movies and TV Shows are in the dataset.
ggplot(data = netflix_data, mapping = aes(x = type)) +
  geom_bar(fill = "red") +
  xlab("Media Type") +
  ylab("Count") +
  ggtitle("Count of Movies and TV Shows")


# 6. How many titles were released each year? Explain using a line plot.

# aggregate count of titles by year
count_of_titles_by_year <- 
  group_by(netflix_data, release_year) %>% 
  summarize(count = n())

ggplot(data = count_of_titles_by_year, mapping = aes(x = release_year, y = count)) +
  geom_line(col = "blue") +
  xlab("Release Year") +
  ylab("Count of Titles") +
  ggtitle("Count of Titles Per Release Year")


# 7. Generate a stacked bar chart to compare the distribution of ratings between Movies and TV Shows.
# type and rating
# need count of how many different ratings
rating_count <- netflix_data %>% 
  count(rating)
#15 different ratings - each bar chart will have 15 sections
ggplot(data = netflix_data, mapping = aes(x = type))


# 8. Create a violin plot showing how movie durations vary across different genres. What patterns do you notice?
# Need to separate the genres out from lists - is it okay if a movie is counted several times because it has multiple genres?


# 9. Create a horizontal bar chart to display the ten most frequent genres represented in the dataset.
# Need to separate the genres out from lists


# 10. Create a heatmap showing the number of Netflix titles by release year and content type.
count_of_titles_by_year_and_type <- 
  group_by(netflix_data, release_year, type) %>% 
  summarize(count = n())

ggplot(data = count_of_titles_by_year_and_type, aes(x = type, y = release_year, fill = count)) +
  geom_tile()





