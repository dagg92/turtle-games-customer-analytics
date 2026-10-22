## LSE Data Analytics Online Career Accelerator 
# DA301:  Advanced Analytics for Organisational Impact

###############################################################################

# Assignment 5 scenario
## Turtle Games’s sales department has historically preferred to use R when performing 
## sales analyses due to existing workflow systems. As you’re able to perform data analysis 
## in R, you will perform exploratory data analysis and present your findings by utilising 
## basic statistics and plots. You'll explore and prepare the data set to analyse sales per 
## product. The sales department is hoping to use the findings of this exploratory analysis 
## to inform changes and improvements in the team. (Note that you will use basic summary 
## statistics in Module 5 and will continue to go into more detail with descriptive 
## statistics in Module 6.)

################################################################################

## Assignment 5 objective
## Load and wrangle the data. Use summary statistics and groupings if required to sense-check
## and gain insights into the data. Make sure to use different visualisations such as scatterplots, 
## histograms, and boxplots to learn more about the data set. Explore the data and comment on the 
## insights gained from your exploratory data analysis. For example, outliers, missing values, 
## and distribution of data. Also make sure to comment on initial patterns and distributions or 
## behaviour that may be of interest to the business.

################################################################################

# Module 5 assignment: Load, clean and wrangle data using R

## It is strongly advised that you use the cleaned version of the data set that you created and 
##  saved in the Python section of the course. Should you choose to redo the data cleaning in R, 
##  make sure to apply the same transformations as you will have to potentially compare the results.
##  (Note: Manual steps included dropping and renaming the columns as per the instructions in module 1.
##  Drop ‘language’ and ‘platform’ and rename ‘remuneration’ and ‘spending_score’) 

## 1. Open your RStudio and start setting up your R environment. 
## 2. Open a new R script and import the turtle_review.csv data file, which you can download from 
##      Assignment: Predicting future outcomes. (Note: You can use the clean version of the data 
##      you saved as csv in module 1, or, can manually drop and rename the columns as per the instructions 
##      in module 1. Drop ‘language’ and ‘platform’ and rename ‘remuneration’ and ‘spending_score’) 
## 3. Import all the required libraries for the analysis and view the data. 
## 4. Load and explore the data.
##    - View the head the data.
##    - Create a summary of the new data frame.
## 5. Perform exploratory data analysis by creating tables and visualisations to better understand 
##      groupings and different perspectives into customer behaviour and specifically how loyalty 
##      points are accumulated. Example questions could include:
##    - Can you comment on distributions, patterns or outliers based on the visual exploration of the data?
##    - Are there any insights based on the basic observations that may require further investigation?
##    - Are there any groupings that may be useful in gaining deeper insights into customer behaviour?
##    - Are there any specific patterns that you want to investigate
## 6. Create
##    - Create scatterplots, histograms, and boxplots to visually explore the loyalty_points data.
##    - Select appropriate visualisations to communicate relevant findings and insights to the business.
## 7. Note your observations and recommendations to the technical and business users.

###############################################################################

# Your code here.

# Import the tidyverse package
library(tidyverse)
library(skimr)

## Load and explore the data
# Import the data set
turtle <- read.csv(file.choose(), header=T)

# Check the data
head(turtle, 3)

# Covert the DataFrame to a tibble
as_tibble(turtle)

# Use the glimpse function
glimpse(turtle)

# Summary statistics
skim(turtle)

# View the DataFrame
View(turtle)

## Perform exploratory data analysis
# Count the number of customers in each gender category
table(turtle$gender)

# Count the number of customers in each education group
table(turtle$education)

# Create a histogram to explore distribution of customer loyalty points
ggplot(turtle, aes(x = loyalty_points)) +
  geom_histogram(bins = 30,
                 colour = "black",
                 fill = "steelblue") +
  labs(title = "Distribution of Loyalty Points",
       x = "Loyalty Points",
       y = "Frequency")

# The distribution is positively skewed. Further insights to be explored in a report

# Create a scatterplot to investigate if customer age is related to loyalty points
ggplot(turtle, aes(x = age,
                   y = loyalty_points)) +
  geom_point() +
  labs(title = "Age vs Loyalty Points",
       x = "Age",
       y = "Loyalty Points")


# Create a scatterplot to investigate if customer remuneration is related to loyalty points
ggplot(turtle, aes(x = remuneration,
                   y = loyalty_points)) +
  geom_point() +
  labs(title = "Remuneration vs Loyalty Points",
       x = "Remuneration",
       y = "Loyalty Points")

# Moderately strong positive relationship. To be investigated further

# Create a scatterplot to investigate if customer spending is related to loyalty points
ggplot(turtle, aes(x = spending_score,
                   y = loyalty_points)) +
  geom_point() +
  labs(title = "Spending Score vs Loyalty Points",
       x = "Spending Score",
       y = "Loyalty Points")

# Clear positive relationship. To be further explored

# Create a boxplot to compare loyalty points between female and male customers
ggplot(turtle, aes(x = gender,
                   y = loyalty_points)) +
  geom_boxplot(fill = "lightblue") +
  labs(title = "Loyalty Points by Gender",
       x = "Gender",
       y = "Loyalty Points")

# Create a boxplot to compare loyalty points across different education levels
ggplot(turtle, aes(x = education,
                   y = loyalty_points)) +
  geom_boxplot(fill = "lightgreen") +
  labs(title = "Loyalty Points by Education",
       x = "Education",
       y = "Loyalty Points")

# Relationship between education and loyalty points to be explored further

# Display summary statistics for loyalty points
summary(turtle$loyalty_points)

# Summary statistics for loyalty points grouped by education level
turtle %>%
  group_by(education) %>%
  summarise(Mean = mean(loyalty_points),
            Median = median(loyalty_points),
            SD = sd(loyalty_points),
            Min = min(loyalty_points),
            Max = max(loyalty_points),
            Count = n(),
            .groups = "drop")

# Calculate correlation between numerical variables
# Correlation values range from -1 to 1
cor(turtle[, c("age",
               "remuneration",
               "spending_score",
               "loyalty_points")])

# Review the mean, median and quartiles.
# Compare these with the histogram to understand
# the overall distribution of loyalty points.

###############################################################################
###############################################################################

# Assignment 6 scenario

## In Module 5, you were requested to redo components of the analysis using Turtle Games’s preferred 
## language, R, in order to make it easier for them to implement your analysis internally. As a final 
## task the team asked you to perform a statistical analysis and create a multiple linear regression 
## model using R to predict loyalty points using the available features in a multiple linear model. 
## They did not prescribe which features to use and you can therefore use insights from previous modules 
## as well as your statistical analysis to make recommendations regarding suitability of this model type,
## the specifics of the model you created and alternative solutions. As a final task they also requested 
## your observations and recommendations regarding the current loyalty programme and how this could be 
## improved. 

################################################################################

## Assignment 6 objective
## You need to investigate customer behaviour and the effectiveness of the current loyalty program based 
## on the work completed in modules 1-5 as well as the statistical analysis and modelling efforts of module 6.
##  - Can we predict loyalty points given the existing features using a relatively simple MLR model?
##  - Do you have confidence in the model results (Goodness of fit evaluation)
##  - Where should the business focus their marketing efforts?
##  - How could the loyalty program be improved?
##  - How could the analysis be improved?

################################################################################

## Assignment 6 assignment: Making recommendations to the business.

## 1. Continue with your R script in RStudio from Assignment Activity 5: Cleaning, manipulating, and 
##     visualising the data.
## 2. Load and explore the data, and continue to use the data frame you prepared in Module 5.
## 3. Perform a statistical analysis and comment on the descriptive statistics in the context of the 
##     review of how customers accumulate loyalty points.
##  - Comment on distributions and patterns observed in the data.
##  - Determine and justify the features to be used in a multiple linear regression model and potential
##.    concerns and corrective actions.
## 4. Create a Multiple linear regression model using your selected (numeric) features.
##  - Evaluate the goodness of fit and interpret the model summary statistics.
##  - Create a visual demonstration of the model
##  - Comment on the usefulness of the model, potential improvements and alternate suggestions that could 
##     be considered.
##  - Demonstrate how the model could be used to predict given specific scenarios. (You can create your own 
##     scenarios).
## 5. Perform exploratory data analysis by using statistical analysis methods and comment on the descriptive 
##     statistics in the context of the review of how customers accumulate loyalty points.
## 6. Document your observations, interpretations, and suggestions based on each of the models created in 
##     your notebook. (This will serve as input to your summary and final submission at the end of the course.)

################################################################################

# Your code here.


# Import libraries
library(tidyverse)
library(moments)
library(psych)

# Data loaded in Module 5

# Explore the data
dim(turtle)
str(turtle)

# Calculate mean, median, standard deviation, variance and range of loyalty points
mean(turtle$loyalty_points)
median(turtle$loyalty_points)
sd(turtle$loyalty_points)
var(turtle$loyalty_points)
range(turtle$loyalty_points)

## Mean is higher than median suggesting loyalty points are positively skewed.
## Standard deviation and range tells us that loyalty points vary greatly between customers.
## Range shows difference of 6822 points between lowest and highest value.
## Further insights to be explored.

# Assess normality of loyalty points
# Histogram
hist(turtle$loyalty_points,
     main = "Distribution of Loyalty Points",
     xlab = "Loyalty Points",
     col = "lightblue")


# QQ Plot
qqnorm(turtle$loyalty_points)
qqline(turtle$loyalty_points,
       col = "red")

# Shapiro-Wilk test
shapiro.test(turtle$loyalty_points)

# Skewness
skewness(turtle$loyalty_points)

# Kurtosis
kurtosis(turtle$loyalty_points)

## Most customers accumulate between 500 and 1500 points.
## A small group of customers have a high number of points.
## QQ plot shows deviation from the reference line (especially in the upper tail).
## The Shapiro-Wilk test confirms that points are not normally distributed.

# Correlation analysis

# Select only numeric variables
turtle_numeric <- select(turtle, where(is.numeric))

# Correlation matrix
cor(turtle_numeric)

## Spending score and remuneration show the strongest positive relationship with loyalty points.
## Correlations between predictors are low so multicollinearity shouldn't be a problem.

# Multiple linear regression model 1

# Build the initial regression model
model1 <- lm(loyalty_points ~ age +
               remuneration +
               spending_score +
               product,
             data = turtle)

# Display the model summary
summary(model1)

## The model explains approx. 84% of the variation in loyalty points.
## Age, remuneration and spending score are all significant predictors.

# Multiple linear regression model 2
# Product removed as it wasn't significant

model2 <- lm(loyalty_points ~ age +
               remuneration +
               spending_score,
             data = turtle)

# Display model summary
summary(model2)

# Compare the two regression models
anova(model1, model2)

## Model2 is simpler while maintaining same predictive accuracy

# Predictions
new_customers <- data.frame(Customer = c("A", "B", "C"),
                            age = c(25, 40, 60),
                            remuneration = c(35, 70, 100),
                            spending_score = c(30, 60, 90))

# Predict loyalty points
new_customers$predicted_loyalty_points <- predict(model2, newdata = new_customers)

# Display predictions
new_customers


# Model diagnostics
par(mfrow = c(2, 2))
plot(model2)

# Return plotting window to normal
par(mfrow = c(1, 1))

## Residual plots indicate some non-linear and non-constant variance
## Small number of observations have higher leverage but no extreme influential points

## Future analysis could include additional customer variables or explore
## more advanced models to further improve prediction accuracy.

###############################################################################
###############################################################################




