#####
# Module 1.3) Dimension reduction in R
#
# Simon Grund Sorensen, Jakob Skou Pedersen, Søren Besenbacher, Aarhus University
# 15/08-2023
####

#Load packages
library(tidyverse)
library(broom)
library(Rtsne)

# Read the glaucoma data set
d <- read_rds("Data/chd_500.rds")
glimpse(d)

# Create a data frame with bloodpressures, cholesterol, age, and BMI
d_num <- d %>% select(sbp, dbp, scl, age, bmi)
glimpse(?)

# Compute principal components (PCs)
pca <- prcomp(?, scale=TRUE)

# Add the PCs to the original dataframe 
d_w_pca <- augment(pca, d)
glimpse(?)

# A)
# Take a look at the d_w_pca dataframe. Use it to:
# 1) Make a scatter plot with PC1 on the x-axis and PC2 on the y-axis
# 2) Give the points different colors depending on whether the individual has congenital heart disorder (chdfate == T ) 


# B)
# We can create a dataframe with the proportion of variance explained for each PC like this:
pve <- data.frame(PC = 1:ncol(d_num), 
                  variance = pca$sdev^2) 
pve = pve %>%
  mutate(proportion_variance_explained = variance / sum(variance))

#Try and comment on what each line of the above code does. Feel free to ask for help

# C) Make a plot that plots the PC number on the x axis and proportion of variance explained on the y axis

# D) Make a plot where you show the first PC on the x-axis, the second on the y-axis, and color
#dots by chdfate (outcome)


# E) Does the PCA sepearate the two groups?

# F)
# Try to Export the data including the principal components:
# write.table(d_w_pca, "Data/d_w_pca_SAVED.tsv", sep = ?, col.names = ?,  row.names = F)


## E) Let's also try to make a T-sne plot. 
tsne_input = d_num 
tsne_out <- Rtsne(tsne_input, pca = F)

# F) Have a look at Rtsne in the help menu using ?Rtsne. Any of the parameters we want to change? Why?

# G) Have a look at the tsne_out which is the output of Rtsne (HINT: click on it in the environment).
#Most of it is just the parameters that we used when running the function. 
#The predicted coordinates can be found in tsne_out$y

# Bind the t-sne x- and -y coordinates to the original data
tsne_plot <- bind_cols(
  d,
  x = tsne_out$Y[,1],
  y = tsne_out$Y[,2])

# H) Make a plot of the output 
ggplot(tsne_plot) +
  geom_point(aes(x=x, y=y, color = ?))

# I) Try to use different parameters in Rtsne to improve the t-sne separation. You can also
#try to run Rtsne on the PCA data (Hint: Use pca$x as data input for Rtsne, and set PCA = T)
#If time and compute power allows, try running on the full data instead of just 500 samples, to see
#if it improves the separation, Hint: For big data we generally use the PCAs as input in t-sne

