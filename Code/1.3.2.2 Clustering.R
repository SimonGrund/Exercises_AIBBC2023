#####
# Module 1.3) Clustering
# 
# Simon Grund Sorensen, Jakob Skou Pedersen, Søren Besenbacher, Aarhus University
# 15/08-2023
####

#Load packages
library(tidyverse)
library(ggdendro)

#Load the data including PCs from module 1_2.
d = read_delim("Data/d_w_pca.tsv")
glimpse(d)

# A) 
# Perform k-means clustering on the PCs, with four centers.
PCs = select(d, .fittedPC1, .fittedPC2, .fittedPC3, .fittedPC4, .fittedPC5)

kk = kmeans(x = ?, centers = ?) #Use ?help(kmeans) if yu need help on how to replace the question marks

# B)
# Plot the inferred clusters with different colors on the PC1 vs PC2 plot
d$Cluster = as.factor(kk$cluster) #We see clusters as factors instead of numbers, 
# for the graph to look nice. What happens if you hashtag this line and runs the script?

ggplot(d, aes(x = .fittedPC1, y = .fittedPC2))+
  geom_point(aes(color = Cluster))

# C)
# Try visualising with different numbers of clusters (centers). 

# D) If you have additional time, you can try to perform k-means clustering on the 
# original numeric values instead of the principal components. Does this separate as well?

# PART 2: Hierarchical clustering

#First we make a distance matrix
dist_mat_PC = dist(PCs)

#Then we generate hierarchical clustering
clusters = hclust(dist_mat_PC)

#Use the ggdendro to make a nice ggplot of the clusters
ggdendrogram(clusters) 

# D) If you have additional time, you can try to perform Hierarchical clustering on the 
# original numeric values instead of the principal components. Does this separate as well?

