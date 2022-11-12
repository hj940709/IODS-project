# Author: Jue Hou
# Date: 2022-11-12
# Description: Assignment 4

library(dplyr)
library(tidyverse)

# Read in the “Human development” and “Gender inequality” data sets.
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")


# Explore the datasets: see the structure and dimensions of the data. Create summaries of the variables.

str(hd)
summary(hd)

str(gii)
summary(gii)
# Look at the meta files and rename the variables with (shorter) descriptive names.
colnames(hd) <- c('HDI.Rank', 'Country', 'HDI', 'Life.Exp', 'Edu.Exp', 'Edu.Mean', 'GNI', 'GNI-HDI.Rank')
colnames(gii) <- c('GII.Rank', 'Country', 'GII', 'Mat.Mor', 'Ado.Birth', 'Parli', 'Edu2.F', 'Edu2.M', 'Lab.F', 'Lab.M')


# Mutate the “Gender inequality” data and create two new variables. The first one should be the ratio of Female and Male populations with secondary education in each country. (i.e. edu2F / edu2M). The second new variable should be the ratio of labor force participation of females and males in each country (i.e. labF / labM). 
gii <- mutate(gii, Edu2.FM = gii$Edu2.F / gii$Edu2.M, Lab.FM = gii$Lab.F / gii$Lab.M)

# Join together the two datasets using the variable Country as the identifier. Keep only the countries in both data sets (Hint: inner join). The joined data should have 195 observations and 19 variables. Call the new joined data "human" and save it in your data folder.
human = inner_join(hd, gii, by = 'Country')
str(human)

write_csv(human, 'human.csv')