# predicting-attrition
In this project "predicting Attrition" a Logistic Regression model has been developed which predicts the attrition probability of each representative. This analysis also produces the list of attributes/ variables that inflence each represntative to stay with or leave the company. 
A Logistic Regression model was developed to predict the probability of reps attrition.
The model reported a value of ‘0’ or ‘1’ associated with ‘leave’ or ‘stay’ respectively for each rep.
The model also reported predictors that drive a probability value.
The accuracy of the model was high (---) representing a good fit.

PREPROCESSING:
Creation of response variable "Attrition" and predicting its missing values.
Ordering data year wise
Removing low-variance predictors: This removes attributes with a near zero variance i.e. the variables that had close to the same value of variance. 
Removing highly correlated variables :A correlation matrix was created from the given attributes and highly correlated attributes were identified and removed. 
Centering and Scaling: This made the data uniform and unit-independent which helped in further processing.
Yeo-Johnson Transformation : This method shifted the distribution of the attribute to reduce the skewness and made them more normally distributed. 

To accomplish the project scope, the following investigation was conducted:
Investigate factors leading to attrition at individual representative level. 
Model factors driving  attrition at individual representative level.

METHODOLOGY:
Create a response variable “Attrition” by using the company’s historical data from 2015 to 2016. 
Model the available predictor variables to obtain the probability of attrition for a  representative.

Predicted probabilities for a rep staying will be further split into two clusters for analysis. 
Representative's with probabilities greater than 0.5 will be taken as representative's staying with the organization. 
Representatives with probabilities greater than 0.5 will be taken as representatives leaving 	the organization.

LOGISTIC REGRESSION:
Logistic regression predicts the outcome of a dependent variable through a set of predictors. 
It is applicable where dependent variable is categorical and dichotomous and independent variables are categorical, continuous or mixed. 
The dependent variable in logistic regression takes the value of 1 (one) with probability of success of an event, or the value of 0 (zero) with the probability of failure of an event. Logistic Regression models the probability of ‘staying’ as 1 and probability of ’leaving’ as 0.
Logistic regression can be performed in two ways
Stepwise Regression- Independent variables are added at each step and their importance is checked.
Backward Stepwise Regression- least important/insignificant variables are dropped one by one.


REASONS FOR CHOOSING THE MODEL:
Response variable is a binary dependent variable.
Dependent variable are both bivariate and multivariate variables 

The relationship between both dependent and independent variables are both linear and non linear
The results are probabilities of a representative staying.

ATTRITION RESULTS:
Out of 3884 representatives as of 2016, 3804 representative's with probabilities higher than 3806 were grouped into category stay and the representative's with probabilities less than 0.5 are grouped as leave. 

Within each group the representatives are categorized based on their net revenue. The representatives with total revenue greater than 5000 and representatives with revenue less than 5000.


ATTRITION RESULTS:
AIC (Akaike Information Criteria) – AIC is equivalent to metric of adjusted R² in Logistic Regression. Minimum value of AIC represents the model fit.
                                                AIC=739.06
ROC CURVE:  Receiver Operating Characteristic summarizes the model’s performance. It evaluates the trade offs between sensitivity and  specificity. Higher the area under the curve high is the accuracy of the prediction.


Results for representatives Attrition were measures against three important metrics of HD vest respectively AUM, Commission, Net flows in tableau and the link is provided below


https://public.tableau.com/views/predictions_1/Sheet1?:embed=y&:display_count=yes 

 









