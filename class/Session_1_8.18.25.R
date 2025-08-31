1 + 1
x = 5+9
y <- 5+7
x+y

# R is case sensitive

# TWo data structures are important
## 1) vectors (2) dataframes

x <- 1:5
y <- 5:1
z <- c(1, 5, 7)
x_new <- c(x, 5.5)

# Subsetting
## We use round brackets () for functions and square brackets [] for subsetting
z <- c(1, 5, 7, 3, 9)
z[1]
z[2]
z[2:4]
z[c(1,3)]

# Subsetting based on conditions
condition1 <- z > 5
z[condition1]

# Common Conditions
condition2 <- z < 8
condition3 <- z >= 5
condition4 <- z == 5 # Returns true when z is exactly 5

## Logical Operators
condition1 & condition2 # Returns TRUE only if all conditions are true
condition1 | condition2 # Returns TRUE if EVEN ONE condition is TRUE

# Using help files
mean(x)
?mean

x1 <- c(1, 3, NA)
mean(x1)
mean(x1, na.rm = TRUE)

# Dataframes
getwd
data <- read.csv("Boston Housing Dataset.csv")
rm(data)
data <- read.csv("Boston Housing Dataset.csv")
list.files()
str(data) # Prints out the structure of the data
colnames(data)
summary(data)

# Change data types
# In R, categorical variables are called factors
data$CHAS <- as.factor(data$CHAS)
str(data)

## Detour - factors
x <- c("Male", "male", "M", "F", "M", "F")
y <- as.factor(x)

x <- c(1,2,5,7)
y <- as.factor(x)
str(y)
z <- as.numeric(y)
z1 <- as.character(y)
z2 <- as.numeric(z1)

install.packages("rmarkdown")

bslib::bootswatch_themes()
