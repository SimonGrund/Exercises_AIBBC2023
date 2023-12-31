#####
# Module 1.2.2.1
# Loading Data in R
#
# Simon Grund Sorensen, Jakob Skou Pedersen, Søren Besenbacher, Aarhus University
# 15/08-2023
####

#Loading necessary packages
library(tidyverse)

# In the previous exercise we loaded the pre-install 'mpg' dataset.
# Now you will learn to load our own data. We have included functions for many different
# data types below. Try running each line and see that you get the same data in the environment. 

# First we load an R-data file (rds)
d <- read_rds("Data/chd_500.rds")

# But often we will get data in a text format like csv (comma separated values)
# or tsv (tab separated values). We can load a csv file like this:
d <- read_csv("Data/chd_500.csv")

#Or a tab-seperated file
d <- read_delim("Data/chd_500.tsv", delim = "\t")

# And sometimes we need to work with excel data. That can be read into R just as easily, with the "readxl" package
library(readxl)
d = read_excel("Data/chd_500.xlsx")
# (Note that if the excel workboook has several sheets, you need to load each sheet separately.
# This can be achieved by using the "sheet" parameter in "read_excel()")

#### Exercise 1 ####
# Load the data through any of the above commands. 
# Then take a glimpse at the data and see if it looks as excpected
glimpse(d)

# A) 
# R will automatically detect what type of information there is in each coloumn.
# What are the types of the columns in our data? Chr, dbl, ...

# B)
# Did R detect the right formats? Could it be done smarter?

# C) 
# Convert "chdfate" to a logical (True/False) instead of character
d$? = as.logical(d$?)

# D) 
# Export your formatted data as a .tsv file (tab-seperated)
write.table(x = ?, file = "Data/chd_500_formatted.tsv", sep = ?, col.names = T, row.names = F)
