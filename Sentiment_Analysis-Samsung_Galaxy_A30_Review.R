#importing all necessary libraries for the analysis
library("tm")
library("SnowballC")
library("RColorBrewer")
library("syuzhet")
library("ggplot2")

#Reading the file from system and loading it as a Corpus
text <- readLines(file.choose())
TextDoc <- Corpus(VectorSource(text))

#Removing "/", "@", "\\" and "|"
toSpace <- content_transformer(function(x,pattern) gsub(pattern,"",x))
TextDoc <- tm_map(TextDoc,toSpace,"/")
TextDoc <- tm_map(TextDoc,toSpace,"@")
TextDoc <- tm_map(TextDoc,toSpace,"\\|")

#Converting text to lower case
TextDoc <- tm_map(TextDoc,content_transformer(tolower))
#Removing numbers, stopwords,punctuation and white spaces.
TextDoc <- tm_map(TextDoc,removeNumbers)
TextDoc <- tm_map(TextDoc, removeWords, stopwords("english"))
TextDoc <- tm_map(TextDoc, removePunctuation)
TextDoc <- tm_map(TextDoc, stripWhitespace)
#Stemming the text
TextDoc <- tm_map(TextDoc, stemDocument)

#Term Document Matrix
Text_dtm <- TermDocumentMatrix(TextDoc)
dtm_m <- as.matrix(Text_dtm)
#Sorting based on Frequency
dtm_v <- sort(rowSums(dtm_m),decreasing=TRUE)
#Creating a dataframe with words and frequencies
dtm_d <- data.frame(word = names(dtm_v),freq=dtm_v)
dtm_k <- data.frame(dtm_v)
#Displaying 10 most frequent words and their frequencies
head(dtm_k,10)

#Plotting 10 most frequent words
barplot(dtm_d[1:10,]$freq, las = 3, names.arg = dtm_d[1:10,]$word,col ="lightblue", main ="Top 10 most frequent words",ylab = "Word frequencies")

#Finding Association of 5 most frequent words
findAssocs(Text_dtm, terms = c("good","phone","camera","samsung","mobil"), corlimit = 0.25)

#Getting Sentiment score using Syuzhet Method
syuzhet_vector <- get_sentiment(text, method="syuzhet")
head(syuzhet_vector)
summary(syuzhet_vector)

#Getting Sentiment score using Bing Method
bing_vector <- get_sentiment(text, method="bing")
head(bing_vector)
summary(bing_vector)

#Getting Sentiment score using Afinn Method
afinn_vector <- get_sentiment(text, method="afinn")
head(afinn_vector)
summary(afinn_vector)

#Comparing values using sign method
rbind(sign(head(syuzhet_vector)),sign(head(bing_vector)),sign(head(afinn_vector)))

#Getting Sentiment values to a dataframe using get_nrc_sentiment method
d<-get_nrc_sentiment(text)
head (d,10)

#Transposing, cleansing and processing of the dataframe 
td<-data.frame(t(d))
td_new <- data.frame(rowSums(td[2:100]))
names(td_new)[1] <- "count"
td_new <- cbind("sentiment" = rownames(td_new), td_new)
rownames(td_new) <- NULL
td_new2<-td_new[1:8,]

#Plotting count of words for each reaction
quickplot(sentiment, data=td_new2, weight=count, geom="bar", fill=sentiment, ylab="count")+ggtitle("Survey sentiments")