### IDS 400 Troutman Assignment 1 ###

### SETUP Workspace ###

# clear Environment Variables
rm(list = ls())

# install needed packages: readr, dplyr, and janitor
install.packages(c("readr", "dplyr", "janitor"))

# load the libraries for use
library(readr)
library(dplyr)
library(janitor)

# get working directory
getwd()

# set working directory
setwd("C:/Users/trout/OneDrive/Documents/UIC MSBA/Fall 2025/IDS 400/Repo/ids400/5-assignments")

# confirm working directory and list files
getwd()
list.files()

# read csv data and clean names
pokemon_data <- read_csv("Pokemon.csv") %>% 
  clean_names()

# check structure and summary of data
str(pokemon_data)
summary(pokemon_data)

View(pokemon_data)

# 1. Calculate the average Attack, Defense, and Speed for each primary type (Type 1). Which primary type has the highest average Speed?
answer1 <- pokemon_data %>% 
  group_by(type_1) %>% 
  summarize(avg_attack = mean(attack),
            avg_defense = mean(defense),
            avg_speed = mean(speed)) %>% 
  arrange(desc(avg_speed))

# ANSWER: The primary type with the highest average speed is Flying at 102.5

  
  
# 2. How many missing values are there in each column? Which column has the most missing values?
answer2 <- pokemon_data %>%
  summarize_all(~sum(is.na(.)))

answer2_alt <- sapply(pokemon_data, function(x) sum(is.na(x)))
  
answer2_alt
  
# ANSWER: type_2 has the most missing values with 386

  
# 3. Which non-Legendary Water-type Pokémon (Type 1 = “Water”) have Attack > 90? List their Name, Type 1, Attack, and Generation?
answer3 <- pokemon_data %>% 
  filter(type_1 == "Water", attack > 90, !legendary) %>% 
  select(name, type_1, attack, generation)
  
  
# 4. Find which primary type (Type 1) appears most often in the dataset. How many times does it appear?
answer4 <- pokemon_data %>% 
  count(type_1, sort = TRUE)
  
# ANSWER: The primary type that appears most often in the dataset is "Water". It appears 112 times.
  
  
# 5. Which five Pokémon have the highest Speed? List their Name, Type 1, Type 2, Speed, and Legendary status.
answer5 <- pokemon_data %>% 
  select(name, type_1, type_2, speed, legendary) %>% 
  arrange(desc(speed))

View(head(answer5, 5))
  

# 6. For each (Type 1, Generation) pair, how many Pokémon are there? Within each generation, which pairs have the largest counts?
answer6 <- pokemon_data %>% 
  count(type_1, generation)

leaders <- answer6 %>% 
  group_by(generation) %>% 
  slice_max(n)

View(leaders)
  
  
# 7. For each Type 1, which Pokémon have Sp. Def strictly above their type’s average Sp. Def, and what are their Name, Type 1, and Sp. Def?
  
  
  
# 8. Compare Legendary and non-Legendary average Totals by Generation. Which Generation has the widest gap?
  
  
  
# 9. In each Generation, what number of Pokémon have a non-missing Type 2?Which generation has the highest share of dual-type Pokémon?
  
  
  
# 10. For each Type 1, return the Pokémon with the greatest Attack (include all ties), with columns Type 1, Name, Attack.



# 11. Which Type 1 has the biggest share of Legendary Pokémon?



# 12. Which Generation has the highest median Speed?



# 13. Which Type 1 shows the largest gap between average Sp. Atk and average Attack?





