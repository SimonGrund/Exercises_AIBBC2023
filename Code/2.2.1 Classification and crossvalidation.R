########
# Module 2.2
# Supervised learning II
# Classification and cross-validation
# Simon Grund Sorensen
#######

## Load libraries ####
library(tidyverse)       # for tidyverse
library(tidymodels)      # for tidymodels
library(skimr)           # for variable summaries
tidymodels_prefer() #Set tidymodels as the default whenever multiple packages have functions with the same name

# load data
chd_full = read_rds("Data/chd_full.rds")
skim(?)

#### PART 1 ####
# Now, let's preprocess our data for modelling
# First we split the data, so that we save some data for testing our model.

# Fix the random numbers by setting the seed. This enables the analysis to be reproducible when random numbers are used 
set.seed(222)

# Put 3/4 of the data into the training set 
chd_split <- initial_split(data = ?, prop = 3/4., strata = chdfate)

# A)
# Create data frames for the two sets:
# As elsewhere, replace the "?" with the correct argument.
chd_train <- training(chd_split)
chd_test <- testing(?)

# initiate a recipe:
# This works by making a recipe and then adding a bunch of steps as below
# Try to read and understand what each line does,
# although you shouldnt edit the code
chd_rec <- 
  recipe(chdfate ~ ., data = chd_train)  %>% #Define the formula and the data
  update_role(id, new_role = "ID") %>% #Make it clear that "id" variable is not a predictor
  step_naomit(all_predictors(), all_outcomes()) %>% #Remove all rows with NA in the predictor or outcome variables
  step_dummy(all_nominal_predictors()) %>% #Convert characters and factors into binary columns
  step_zv(all_predictors()) %>% #Remove variable that have the same value across all rows
  step_center(all_numeric_predictors()) %>% #Normalize numeric data to mean of zero
  step_scale(all_numeric_predictors()) #Normalize numeric data to standard deviation of one

# B)
# Have a look at the recipe by running below line:
# Are there any of the operations that you don't understand?``
chd_rec


# Now we train (preprocess) the recipe, by learning parameters from the training data
preprocessed_rec <- prep(chd_rec, training = chd_train) 
preprocessed_rec

#Use the recipe to format (bake) the training data
chd_train_baked <- bake(preprocessed_rec, new_data = chd_train)
glimpse(chd_train_baked)

#Now we can use the same recipe to bake the test data to ensure 
# that it has undergone the same normalisation and formatting as the testing data
chd_test_baked <- bake(preprocessed_rec, new_data = chd_test)
glimpse(chd_test_baked)


##### PART 2: time to start our modeling career! ####
## define a model type (logistic regression) and engine (glm) #### 
lr_mod <- 
  logistic_reg() %>% 
  set_engine("glm")

# combine the recipe and the model into a workflow:
# By adding the un-processed recipe we actually preprocess it again here, as we did in PART 2.
# This is not strictly necessary (we could have simply used the baked training data as input)
# but it is more consistent to keep all steps of the modelling in a single workflow as 
# we do here:
chd_wflow <- 
  workflow() %>% 
  add_model(lr_mod) %>% 
  add_recipe(chd_rec) 
chd_wflow

## fit model using workflow
#Notice we use the un-baked data. The fit will preprocess the recipe and bake the data automatically
chd_fit <- 
  chd_wflow %>% 
  fit(data = chd_train) 
chd_fit 

## extract model fit in a tidy format
chd_fit %>% 
  extract_fit_parsnip() %>% 
  tidy()

# A)
# What are the three most significant variables? 

# B)
# Extract the predicted probabilities on the training data from the fitted model.
Fitted_values_train = augment(chd_fit, chd_train)

# C)
# Make a quick histogram of the posterior probabilities
hist(?)

# D)
# predict on the test data using the fitted workflow. 
# Notice that the predict function will return TRUE/FALSE per default, rather 
# than posterior probabilities (fitted values as above).
# If you want these, you can add type = "prob" to the line belw
predict(chd_fit, new_data = ?)

# E)
# augment predictions to data set using the fitted workflow ####
chd_aug <- 
  augment(chd_fit, chd_test)
glimpse(chd_aug)

# (F)
# If you have the time, make a ggplot with geom_boxplot that shows the posterior probabilities on the test data.

# (G)
# Is our model able to separate chdfate == T from chdfate == F?


#### PART 3 ### Measuring performance
# A commonly used measure of model performance is area-under-the-reciever-operator curve (AUROC or ROC)
# plot a ROC curve on the test set using autoplot
chd_aug %>% 
  roc_curve(truth = chdfate, .pred_TRUE) %>% 
  autoplot()

# Calculate the AUC without plotting
chd_aug %>% 
  roc_auc(truth = chdfate, .pred_TRUE)

# A)
# What would the AUC score be, if the model had no ability to separate chdfate == T / F ?

# B) 
# Do you think the AUC score we get is good?

# C)
# Do you have any thoughts on how it could be improved? 


#### PART 4 ####
## cross-validation folds (data subsets) ####
set.seed(345)
folds <- vfold_cv(chd_train, v = 10)
folds

## fit our model with cross-validation (resampling) ####
set.seed(456)
chd_fit_rs <- 
  chd_wflow %>% 
  fit_resamples(folds)
chd_fit_rs

# Print performance metrics from the resampling-method
collect_metrics(chd_fit_rs)

# Look at the performance from the model evaluated on test-data
chd_aug %>% 
  roc_auc(truth = chdfate, .pred_TRUE)

chd_aug %>% 
  accuracy(truth = chdfate, .pred_class)

# A)
# Does the cross-validation and test-data approach give similar AUC and accuracy?

# B)
# What would it mean, if it didnt?

