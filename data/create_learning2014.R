# Author: Jue Hou
# Date: 2022-10-31
# Description: Assignment 2


library(dplyr)
library(tidyverse)
# Load dataset
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)


# Rescale variables
lrn14$attitude <- lrn14$Attitude / 10
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)
# Rename col
lrn14 <- rename(lrn14, points = Points, age = Age)
# Select col
keep_columns <- c("gender","age","attitude", "deep", "stra", "surf", "points")
lrn14 <- select(lrn14, one_of(keep_columns))
# Filter data
lrn14 <- filter(lrn14, points > 0)

dim(lrn14)

# Dump dataset to a csv file
write_csv(lrn14, 'learning2014.csv')
# Reload dataset from a csv file
data <- read_csv('learning2014.csv')
dim(data)
str(data)