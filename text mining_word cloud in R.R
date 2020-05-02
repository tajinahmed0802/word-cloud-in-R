# Install
install.packages("tm")  # for text mining
install.packages("SnowballC") # for text stemming
install.packages("wordcloud") # word-cloud generator 
install.packages("RColorBrewer") # color palettes
# Load
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
install.packages("wordcloud2")
library(wordcloud2)

#text <- readLines(file.choose())
file_path<-"http://www.gutenberg.org/cache/epub/2500/pg2500.txt"
text <- readLines(file_path)
#text<- read.delim2(file.choose())

# Load the data as a corpus
docs <- Corpus(VectorSource(text))
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")
# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
docs<-tm_map(docs,removePunctuation)

# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords())
# Remove your own stop word
# specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, c("alice", " <e3><U+00A2>???<e5><U+0093>","don<e3><U+00A2>???Tt", "it<e3><U+00A2>???<e2><U+009D>","many","good","also", "may","yes", "lsquoand", "shall", "must","himnbsp","menbsp", "irsquoll", "gutenbergtm" ,"irsquom","donrsquot","plsquoi","will","one","said","know","'")) 
# Remove punctuations
#docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)
# Text stemming
#docs <- tm_map(docs, stemDocument)
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
words <- sort(rowSums(m),decreasing=TRUE)
df <- data.frame(word = names(words),freq=words)
head(df)
head(df, 50)

#install.packages("wesanderson")
#library(wesanderson)
#names(wes_palettes)
set.seed(101)
wordcloud(words = df$word, freq = df$freq, min.freq = 30,
          max.words=100, rot.per=0.35, scale=c(3,0.5),
          colors = rainbow(100),)
#more beautiful visualization
wordcloud2(data=df, size=0.5, color='random-dark',shape="circle")









