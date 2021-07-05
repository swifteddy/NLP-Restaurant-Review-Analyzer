# NLP Reviews

# importing the data set
# 1 is positive review, 0 is negative review
dataset_original = read.delim('Restaurant_Reviews.tsv',quote = '', stringsAsFactors = FALSE)
dataset = read.delim('Restaurant_Reviews.tsv',quote = '', stringsAsFactors = FALSE)
# install the NLP package for R
#install.packages('tm') 
#install.packages('SnowballC') 

# Cleaning the text
library(tm)
library(SnowballC)
corpus = VCorpus(VectorSource(dataset$Review))

# lower cases all the reviews so we don't have two versions of the same words
corpus = tm_map(corpus, content_transformer(tolower))
# removes numbers, punctuation, stop words and white space from the reviews
# because they don't provide any useful info for our model, also using Porters
# Stemming algorithm we remove the root of all the words in our text
corpus = tm_map(corpus, removeNumbers)
corpus = tm_map(corpus, removePunctuation)
corpus = tm_map(corpus, removeWords, stopwords())
corpus = tm_map(corpus, stemDocument)
corpus = tm_map(corpus, stripWhitespace)

# Creating bag of words model
dtm = DocumentTermMatrix(corpus)
#keep 99% of most frequent words in our sparce matrix of features
dtm = removeSparseTerms(dtm, 0.999)
dataset =  as.data.frame(as.matrix(dtm))
dataset$Liked = dataset_original$Liked

# Random Forest Classification

# Encoding the target feature as factor
dataset$Liked = factor(dataset$Liked, levels = c(0, 1))

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Liked, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
# none needed because we dont have one independent variable dominating another

# Fitting Random Forest Classification to the Training set
# install.packages('randomForest')
library(randomForest)
set.seed(123)
classifier = randomForest(x = training_set[-692],
                          y = training_set$Liked,
                          ntree = 10)

# Predicting the Test set results
y_pred = predict(classifier, newdata = test_set[-692])

# Making the Confusion Matrix
cm = table(test_set[, 692], y_pred)

# 80 correct predictions of negative reviews
# 66 correct predictions of positive reviews
# 20 incorrect predictions of negative reviews
# 34 incorrect predictions of positive reviews
