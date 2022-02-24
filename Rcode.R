install.packages("pdftools")
library("pdftools")

setwd("D:/data_analytics/Portfolio project/Data mining-Court opinions")

files <- list.files(pattern = "pdf$")

opinions <- lapply(files, pdf_text)

lapply(opinions, length)

install.packages("tm")
library("tm")
getSources()

corp <- Corpus(URISource(files), 
               readerControl = list(reader = readPDF))

opinions.tdm <- TermDocumentMatrix(corp,
                                   control = list(removePunctuation = TRUE,
                                                  stopwords = TRUE,
                                                  tolower = TRUE,
                                                  stemming = TRUE,
                                                  removeNumbers = TRUE,
                                                  bounds = list(global = c(3, Inf))))

inspect(opinions.tdm[1:10,])

#To properly remove punctuation

corp <- tm_map(corp, removePunctuation, ucp = TRUE)

opinions.tdm <- TermDocumentMatrix(corp,
                                   control = list(stopwords = TRUE,
                                                  tolower = TRUE,
                                                  stemming = TRUE,
                                                  removeNumbers = TRUE,
                                                  bounds = list(global = c(3, Inf))))

inspect(opinions.tdm[1:10,])

findFreqTerms(opinions.tdm, lowfreq = 100, highfreq = Inf)

#turn it to matrix

ft <- findFreqTerms(opinions.tdm, lowfreq = 100, highfreq = Inf)

as.matrix(opinions.tdm[ft,]) 

ft.tdm <- as.matrix(opinions.tdm[ft,])

sort(apply(ft.tdm, 1, sum), decreasing = TRUE)
