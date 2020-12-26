# Samsung-Galaxy-A30-Review---Sentiment-Analysis-using-Beautiful-Soup-in-Python
In this project, the Reviews of Samsung Galaxy A30 from Flipkart are scrapped using Beautiful Soup in Python and using that data, Sentiment Analysis performed in R Programming.

This project have 2 main steps involved; Obtaining the data and Analysing the data. Web Scraping using Beautiful Soup in Python is used to get the data and R programming is used for the analysis of the data.

1.Web Scraping using Beautiful Soup
The realtime data from Flipkart is used for this Analysis. This data is obtained through web scraping. Csv file containing the reviews are obtained as the output of the scraping.

2.Sentiment Analysis in R
The csv file obtained from scraping is used for the analysis. The libraries used for this analysis are tm, SnowballC,syuzhet,etc. Unnecessary symbols, stopwords and whitespaces are removed from the data and stemming is applied. The most frequent words in the review are obtained from the analysis and they are plotted. syuzhet_vector, bing_vector and afinn_vector are used for sentiment analysis. The sentiment value counts are plotted using a quickplot.
