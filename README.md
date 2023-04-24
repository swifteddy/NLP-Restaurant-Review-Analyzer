# NLP Reviews

## Introduction
This project aims to predict the sentiment (positive/negative) of customer reviews for a restaurant. We will use the Random Forest Classification algorithm in R to classify the reviews.

## Dataset
The dataset used for this project is a TSV file (Restaurant_Reviews.tsv) containing 1000 reviews of a restaurant. Each review is marked as positive (1) or negative (0).

## Data preprocessing
The first step is to preprocess the text data by cleaning it and transforming it into a format that can be used by the machine learning algorithm. We use the tm and SnowballC packages in R to perform the following steps:

Convert the text to lowercase
* Remove numbers, punctuation, stop words, and white space
* Apply the Porter stemming algorithm to reduce each word to its root form
* Create a document-term matrix (DTM) to represent the data as a set of features.

## Model training and evaluation
We split the data into a training set and a test set (80:20 ratio) using the caTools package. We then use the randomForest package to train a random forest classification model on the training set. We make predictions on the test set and evaluate the model's performance using a confusion matrix.

## Results
The model achieved an accuracy of approximately 73% on the test set. The confusion matrix shows that the model correctly predicted 80 negative reviews and 66 positive reviews, but incorrectly predicted 20 negative reviews and 34 positive reviews.

## Conclusion
In this project, we demonstrated how to use the Random Forest Classification algorithm to predict the sentiment of customer reviews for a restaurant. While the model achieved a decent accuracy, there is still room for improvement. Possible ways to improve the model include using more advanced preprocessing techniques or exploring other machine learning algorithms.




