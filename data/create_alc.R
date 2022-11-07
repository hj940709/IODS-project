# Author: Jue Hou
# Date: 2022-11-06
# Description: Assignment 3



# Read both student-mat.csv and student-por.csv into R (from the data folder) and explore the structure and dimensions of the data. (1 point)
library(dplyr)
library(tidyverse)
math <- read_csv2('student-mat.csv')
por <- read_csv2('student-por.csv')

glimpse(math)
glimpse(por)

# Join the two data sets using all other variables than "failures", "paid", "absences", "G1", "G2", "G3" as (student) identifiers. Keep only the students present in both data sets. Explore the structure and dimensions of the joined data. (1 point)
free_cols <- c("failures", "paid", "absences", "G1", "G2", "G3")
join_cols <- setdiff(colnames(por), free_cols)
math_por <- inner_join(math, por, by = join_cols, suffix = c(".math", ".por"))
alc <- select(math_por, all_of(join_cols))
glimpse(alc)

# Get rid of the duplicate records in the joined data set. Either a) copy the solution from the exercise "3.3 The if-else structure" to combine the 'duplicated' answers in the joined data, or b) write your own solution to achieve this task. (1 point)

# for every column name not used for joining...
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}

# Take the average of the answers related to weekday and weekend alcohol consumption to create a new column 'alc_use' to the joined data. Then use 'alc_use' to create a new logical column 'high_use' which is TRUE for students for which 'alc_use' is greater than 2 (and FALSE otherwise). (1 point)

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)

# Glimpse at the joined and modified data to make sure everything is in order. The joined data should now have 370 observations. Save the joined and modified data set to the ‘data’ folder, using for example write_csv() function (readr package, part of tidyverse). (1 point)

glimpse(alc)
write_csv(alc, 'alc.csv')

