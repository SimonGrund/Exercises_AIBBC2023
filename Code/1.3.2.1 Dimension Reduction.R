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
glimpse(d_num)

# Compute principal components (PCs)
pca <- prcomp(?, scale=TRUE)

# Add the PCs to the original dataframe 
d_w_pca <- augment(pca, d)
glimpse(d_w_pca)

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

# C)
# Make a plot that plots the PC number on the x axis and proportion of variance explained on the y axis
PCs = dplyr::select(d_w_pca, chdfate, .fittedPC1, .fittedPC2, .fittedPC3) %>% mutate(sample = 1:nrow(d))

ggplot(PCs, aes(x = .fittedPC1, y = .fittedPC2, color = chdfate))+
  geom_point()

# D)
# Export the data including the principal components, so that we can use the data for module 1.3.
# Downloadd the saved data to your own computer so that you can uplaod it in the next module.
# (Dont worry, if for some reason this doesnt work, we have already put a copy of the 
# formatted data in the next module data folder)
#write.table(d_w_pca, "Data/d_w_pca.tsv", sep = ?, col.names = ?,  row.names = F)


## E) Let's also try to make a T-sne plot. 
tsne_input = d_num 
tsne_out <- Rtsne(tsne_input)

# Bind the t-sne x- and -y coordinates to the original data
tsne_plot <- bind_cols(
  d,
  x = tsne_out$Y[,1],
  y = tsne_out$Y[,2])


# Make a plot of the output 
ggplot(tsne_plot) +
  geom_point(aes(x=x, y=y, color = ?))

# F) What is better, PCA or t-sne?


