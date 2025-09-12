### IDS 400 Lab 1 ###

# clear Environment Variables
rm(list = ls())

# install needed packages: readr, dplyr, and janitor
# install.packages(c("readr", "dplyr", "janitor"))

install.packages(
  c("readr", "dplyr", "janitor"),
  repos = "https://cloud.r-project.org"
)

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
pokemon_data <- read_csv("Pokemon.csv") %>% 
  clean_names()

# 1. Calculate the average Attack, Defense, and Speed for each primary type (Type 1). Which primary type has the highest average Speed? Functions used: group_by, summarize, head

average_metrics <- pokemon_data %>%
  group_by(type_1) %>%
  summarize(
    avg_attack = mean(attack),
    avg_defense = mean(defense),
    avg_speed = mean(speed)
  )

print(average_metrics)

max_speed <- average_metrics %>%
  arrange(desc(avg_speed))

## The primary type with the highest average speed is Flying (102). ##
head(max_speed, 1)


# 2. How many missing values are there in each column? Which column has the most missing values?
missing_column_values <- sapply(pokemon_data, function(x) sum(is.na(x)))


## type_2 has the most missing values
missing_column_values
sort(missing_column_values, decreasing = TRUE)


#  3. Which non-Legendary Water-type Pokémon (Type 1 = “Water”) have Attack > 90? List their Name, Type 1, Attack, and Generation?
ans3 <- pokemon_data %>%
  filter(!legendary) %>%
  filter(type_1 == "Water") %>% 
  filter(attack > 90) %>%
  select(name, type_1, attack, generation)

ans3 <- pokemon_data %>% 
  filter(!legendary, type_1 == "Water", attack > 90) %>% 
  select(name, type_1, attack, generation)

print(ans3, n = 36)

#  4. Find which primary type (Type 1) appears most often in the dataset. How many times does it appear?
ans4 <- pokemon_data %>% 
  count(type_1, sort = TRUE)

ans4


#  5. Which five Pokémon have the highest Speed? List their Name, Type 1, Type 2, Speed, and Legendary status.
ans5 <- pokemon_data %>% 
  arrange(desc(speed)) %>% 
  select(name, type_1, type_2, speed, legendary)

head(ans5, 5)


# 6. For each (Type 1, Generation) pair, how many Pokémon are there? Within each generation, which pairs have the largest counts?
ans6 <- pokemon_data %>% 
  count(type_1, generation)

leaders <- ans6 %>% 
  group_by(generation) %>% 
  slice_max(n, n=2)

leaders


#  7. For each Type 1, which Pokémon have Sp. Def strictly above their type’s average Sp. Def, and what are their Name, Type 1, and Sp. Def?

ans7 <- pokemon_data %>% 
  group_by(type_1) %>% 
  filter(sp_def > mean(sp_def)) %>% 
  select(name, type_1, sp_def)

ans7


#  8. Compare Legendary and non-Legendary average Totals by Generation. Which Generation has the widest gap?

ans8 <- pokemon_data %>% 
  group_by(generation) %>% 
  summarize(avg_legendary = mean(total[legendary]),
            avg_non_legendary = mean(total[!legendary]),
            gap = abs(avg_legendary - avg_non_legendary)) %>% 
  arrange(desc(gap))

ans8
              


#  9. In each Generation, what number of Pokémon have a non-missing Type 2? Which generation has the highest share of dual-type Pokémon?

ans9 <- pokemon_data %>% 
  summarize(n_dual = sum(!is.na(type_2)), .by = generation) %>% 
  arrange(desc(n_dual))

ans9
  

#  10. For each Type 1, return the Pokémon with the greatest Attack (include all ties), with columns Type 1, Name, Attack.

ans10 <- pokemon_data %>% 
  group_by(type_1) %>% 
  slice_max(attack, n=1, with_ties = TRUE) %>% 
  select(name, type_1, attack) %>% 
  arrange(type_1, desc(attack), name)

ans10


# 11. Which Type 1 has the biggest share of Legendary Pokémon?

ans11 <- pokemon_data %>% 
  filter(legendary) %>% 
  count(type_1) %>% 
  slice_max(n, n=1)

ans11


#  12. Which Generation has the highest median Speed?

ans12 <- pokemon_data %>% 
  group_by(generation) %>% 
  summarize(median_speed = median(speed)) %>% 
  slice_max(median_speed, n=1)

ans12


#  13. Which Type 1 shows the largest gap between average Sp. Atk and average Attack?

ans13 <- pokemon_data %>% 
  group_by(type_1) %>% 
  summarize(avg_sp_attack = mean(sp_atk),
            avg_attack = mean(attack),
            gap = abs(avg_sp_attack - avg_attack)) %>% 
  arrange(desc(gap))

ans13
  




