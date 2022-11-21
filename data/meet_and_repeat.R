# Author: Jue Hou
# Date: 2022-11-21
# Description: Assignment 5

library(dplyr)
library(tidyverse)

# Load the data sets (BPRS and RATS) into R using as the source the GitHub repository of MABS, where they are given in the wide form.
# Also, take a look at the data sets: check their variable names, view the data contents and structures, 
# and create some brief summaries of the variables , so that you understand the point of the wide form data.
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep=" ", header=TRUE)
glimpse(BPRS)
# BPRS contains 40 observations and 11 variables: treatment, subject and week0 to week 8
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep="", header=TRUE)
glimpse(RATS)
# RATS contains 16 observations and 13 variables: ID, Group and another 11 variables whose name start with WD

# Convert the categorical variables of both data sets to factors.
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Convert the data sets to long form. Add a week variable to BPRS and a Time variable to RATS. 

BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
          mutate(week = as.integer(substr(weeks, 5, 5))) %>%
          arrange(weeks)


RATSL <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = 'WD',
                      values_to = "Weight") %>% 
         mutate(Time = as.integer(substr(WD, 3, 4))) %>%
         arrange(Time)


# Check the variable names, view the data contents and structures, and create some brief summaries of the variables.

glimpse(BPRSL)
# BPRSL contains 360 observations and 4 variables. 
# It is converted from BPRS by collapsing "weekX" columns (360 = 40 (original obsercations) * 9 (week0~week8))
# "weeks" records the week identifier (the original weekX columns)
# "week" records the week number, which is extracted from "weeks"
# "bprs" records the value that was recorded under the original weekX columns

glimpse(RATSL)
# RATSL contains 176 observations and 5 variables. 
# It is converted from BPRS by collapsing "WDX" columns (176 = 16 (original obsercations) * 11 (num of WDX columns))
# "WD" records the WD identifier (the original WDX columns)
# "time" records the WD number, which is extracted from "WD"
# "Weight" records the value that was recorded under the original weekX columns


# Dump to csv
write_csv(BPRSL, 'bprsl.csv')
write_csv(RATSL, 'ratsl.csv')