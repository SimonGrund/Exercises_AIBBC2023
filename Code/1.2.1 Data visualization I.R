#####
# Module 2.1
# R-programming and Visualising Data in R I
#
# Simon Grund Sorensen, Jakob Skou Pedersen, Søren Besenbacher, Aarhus University
# 15/08-2023
####

#PART 1 — R programming and data visualization#
#### Intorduction to R-programming
# Any line starting with a hash-tag is just text! This way,
# you can leave notes for yourself. Try to make a new line below
# and write a hashtag (#) followed by a message for yourself.


# Now, let's try to run some code! To run code, move your
# cursor to the line you want to run and press CTRL+Enter (Windows)
# CMD + Enter (Mac). Try it on the line below:

print("Hello World")

# Can you see the output in the Console below? Good! Let's try
# some more commands. Just run each line and see what happens.
print("Welcome to Bioinformatics and Genomics!")

d = data.frame(x = 1:5, y = 11:15)
plot(d)

summary(d$x)
summary(d$y)

# Now, let's start to look at some better data visualizations here in
# Exercises Part I:

#### Exercises part I ##########################################################
# We start by exploring aesthaetics using the mpg data set, which is a build-in training data set in R.
# Refer to the uploaded ggplot cheat sheet (data-visualization.pdf) for parameter specification. 

# First, we load the tidyverse which is an essential set of packages for data analysis.
# Run below line (or any line of code) by having the caret (|-cursor) on the line and pressing 
# CMD+enter (MAC) or CTRL+enter (PC)
library(tidyverse)

# Let's load some data that is built into R. Later
# you will learn to load your own data, but for now
# we are just practicing. Run this line to define the 
# built in 'mpg' data set as a variable called 'd'.
d = mpg

# Try to click the 'd' data set in environment and look at the
# data window that pop's up. Just spend a moment to see, that the
# data looks a lot like a normal excel sheet. Then close the data
# window and return to this script.

# Initiate an empty plot with the mpg data
ggplot(data = mpg)

# Initiate an empty plot with the mpg data but now
# we add a histogram (geom_histogram) 
# of 'highway miles per gallon' (hwy) 
ggplot(data = mpg) + 
  geom_histogram(aes(x = hwy))

# Let's try a dot-plot where we compare hwy with displ (engine displacement, in litres)
# Replace the '?' to plot 'hwy' on the y-axis
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# Replace the ?'s to make point size reflect the number of cylinders (cyl)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = 1))

# Replace the ?'s to make color reflect the number of cylinders (cyl)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = cyl))

# Try to execute the aes function on its own to what it returns
aes(x = displ, y = hwy)

# Replace the ? to make a dotted line in the below
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy), linetype = "dotted")

# Change the geom below to make a histogram
ggplot(data = mpg) + 
  geom_histogram(mapping = aes(x = hwy))

# Repeat the histogram, but extend the binwith or reduce the number of bins. 
# Look at the cheat sheet or manual page for help. 
ggplot(data = mpg) + 
  geom_histogram(mapping = aes(x = hwy), binwidth = 5)

# Plot displ versus cty with red squares (using geom_points)
ggplot(data=mpg, aes(cty, displ)) +
  geom_point()+
  geom_smooth()

# Add one layer to the above plot, by adding a blue geom_smooth line.

