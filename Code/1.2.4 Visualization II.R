#####
# Module 2.2
# Visualising Data in R II
#
# Simon Grund Sorensen, Jakob Skou Pedersen, Søren Besenbacher, Aarhus University
# 15/08-2023
####

# We now begin exploring a subset of the Framingham Heart Study
# data set. The data set consists of 4,699 observations of 9 variables. You can 
# read about the data set in the uploaded PDFs and at this website:
# https://www.causeweb.org/tshs/framingham-didactic/

# We will work on a sub-sample made with the following command:
# chd_small <- slice_sample(chd_full, n = 500)

# Load the data set:
chd_500 <- read_rds("Data/chd_500.rds")

# Have a look at the data together with the pdf with the data set introduction: 
glimpse(chd_500)

# Some of the variables have been abbreviated. You can read their full name in "Framingham Didactic Data Dictionary_2.pdf".
# Here are the most important ones:
#sbp = Systolic blood pressure, mm Hg
#dbp = Diastolic blood pressure, mm Hg
#scl = Serum cholesterol, mg/100 mL
#chdfate = Patient had developed congenital heart disorder at follow-up

#Let's do some visualisations to get a better feel of the data!

# A)
# Replace the ?'s to bmi against dbp
# (Note that the ggplot object is saved and can now be reused and extended)
p <- ggplot(chd_500, aes(?, ?)) 
p + 
  geom_point()

# B)
# Add a linear model regression line by specifying smoothing method 
p + geom_point() + 
  geom_smooth(? = "lm")

# C)
# Replace the ? to make bar plot of patients enrolled per month 
ggplot(chd_500) + 
  ?(aes(month)) 

# D)
# Replace the ?'s to make a stacked bar plot patients enrolled per month by sex
ggplot(chd_500) + 
  geom_bar(aes(month, fill = ?), position = ?)

# E)
# Make box plot of sex vs bmi
ggplot(chd_500, aes(sex, bmi)) + 
  geom_?()

# F)
# Using the cheat sheet, change it to a violin plot ...

# G)
# ... and then a dotplot, where the binwidth needs to be set for it to meaningful
ggplot(chd_500, aes(sex, bmi)) + 
  geom_?(binaxis = "y", stackdir = "center", binwidth = ?)

# H)
# If time permits try some of the other geoms, selecting relevant types 
# and combinations of variables based on the cheat sheet overview .

#### Exercises part II ########################################################

# A)
# Overwrite the default color palettes using the below suggestions:
# Try these continuous color scales: scale_color_viridis_c() or scale_colour_gradientn(colours=rainbow(4))
p <- ggplot(chd_500, aes(sbp, dbp))

p + 
  geom_point(aes(color = bmi)) + 
  ?
  
  # B)
  # Try to add this discrete color scale: scale_colour_brewer(palette="Paired")
  p + 
  geom_point(aes(color = sex))

p + 
  geom_point(aes(color = month)) 

# D)
# Try to reverse the x or y scales with scale_x_reverse() or scale_y_reverse()
ggplot(chd_500, aes(sbp, dbp)) + 
  geom_point(aes(color = month)) + ?
  
  
  # D)
  # Try to add meaningful title, and labels to the x- and y-axis using xlab() and ylab(), and a ggtitle()
  ggplot(chd_500, aes(sbp, dbp)) + 
  geom_point(aes(color = month)) + ?  
  
  #### Exercises part III ########################################################

# A)
# Make a facet_wrap based on month by replacing the ?
ggplot(chd_500, aes(sbp, dbp, color = month)) + geom_point() + facet_wrap(~?)

# B)
# Adjust to using four rows (using nrow)
ggplot(chd_500, aes(sbp, dbp, color = month)) + geom_point() + facet_wrap(~month, ?)

# C)
# Adjust the number columns in facet_wrap() (using ncol)

# D)
# Make a facet_grid of sex versus chdfate replacing the ?'s
# (note that the plot will not draw until you print p by executing the second line below) 
p <- ggplot(chd_500, aes(sbp, dbp, color = month)) + geom_point() + facet_grid(?~?)
p


# F)
# If time allows:
# Try to make a plot that shows the proportion of heart disease among men and women.
# One way to achieve this, is adobt the strategy in R4DS, sect. 2.5.2:
#
# position = "fill" works like stacking, but makes each set of stacked bars 
# the same height. This makes it easier to compare proportions across groups.


#### Exercises part IV ########################################################

# the plot shown to the right can be saved with ggplot, e.g.: 
ggsave("chd_500_grid_facet.pdf", width = 20, height = 20, units = "cm", device = "pdf")

# A) Try to save a plot in pdf format
# B) Try to save a plot in png format
# C) Download the plots to your laptop


# E)
# Try to plot a map of Denmark using the below commands:
library(mapDK)
mapDK()

# F)
# How do you think data could be added to this plot. What variables would a dataframe/tibble need? 

#(G) If you have the time, you can go online and see if you can find a way to make a similar plot of India.
# (Although you might need more computing power — India is much bigger than Denmark, after all!)

