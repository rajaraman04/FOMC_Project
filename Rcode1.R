library(dplyr)
library(SentimentAnalysis)
library(lubridate)
library(ggplot2)
library(tidyr)
library(stringr)
library(rlang)
library(tidyverse)
library(tidytext)
#library(xlsx)
library(RCurl)
library(XML)
library(kableExtra)
library(tm)
library(ngram)
library(wordcloud)
library(ggridges)
library(ggplot2)
library(gridExtra)
library(rcompanion)
library(ggcorrplot)
library(caret)
library(e1071)
library(R.utils)
library(DT)
library(lattice)
library(kernlab)
library(mlbench)
library(caretEnsemble)
library(nnet)
library(LiblineaR)
library(knitr)

links<-c("https://www.federalreserve.gov/newsevents/pressreleases/monetary20220126a.htm",
                  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20220615a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20060510a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20070810a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20191011a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20100509a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20080311a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20220504a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20220316a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20230201a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20221214a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20221102a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20220921a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20220727a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20230726a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20230614a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20230503a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20230322a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20210428a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20210317a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20210127a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20211215a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20211103a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20210922a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20210728a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20210616a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20200429a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20200323a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20200315a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20200303a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20200129a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20200729a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20200610a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20201216a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20201105a.htm",
    "https://www.federalreserve.gov/newsevents/pressreleases/monetary20200916a.htm",
          "https://www.federalreserve.gov/newsevents/pressreleases/monetary20190731a.htm",
          "https://www.federalreserve.gov/newsevents/pressreleases/monetary20190918a.htm",
          "https://www.federalreserve.gov/newsevents/pressreleases/monetary20191030a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20191211a.htm",
          "https://www.federalreserve.gov/newsevents/pressreleases/monetary20190619a.htm",
          "https://www.federalreserve.gov/newsevents/pressreleases/monetary20190501a.htm",
          "https://www.federalreserve.gov/newsevents/pressreleases/monetary20190130a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20190320a.htm",
          "https://www.federalreserve.gov/newsevents/pressreleases/monetary20180131a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20180321a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20180502a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20180613a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20180801a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20180926a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20181108a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20181219a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20170201a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20170315a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20170503a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20170614a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20170726a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20170920a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20171101a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20171213a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20160127a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20160316a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20160427a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20160615a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20160727a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20160921a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20161102a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20161214a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20150128a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20150318a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20150429a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20150617a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20150729a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20150917a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20151028a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20151216a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20140129a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20140319a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20140430a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20140618a.htm", 
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20140730a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20140917a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20141029a.htm",  
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20141217a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20130130a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20130320a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20130501a.htm", 
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20130619a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20130731a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20130918a.htm",  
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20131030a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20131218a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20120125a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20120313a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20120425a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20120620a.htm", 
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20120801a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20120913a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20121024a.htm",  
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20121212a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20110126a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20110315a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20110427a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20110622a.htm", 
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20110809a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20110921a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20111102a.htm",  
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20111213a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20100127a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20100316a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20100428a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20100623a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20100810a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20100921a.htm",  
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20101103a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20101214a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20090128a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20090318a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20090429a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20090624a.htm", 
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20090812a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20090923a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20091104a.htm",  
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20091216a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20080122b.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20080130a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20080318a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20080430a.htm", 
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20080625a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20080805a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20080916a.htm",  
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20081008a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20081029a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20081216b.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20070131a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20070321a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20070509a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20070618a.htm", 
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20070807a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20070817b.htm",  
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20070918a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20071031a.htm",
         "https://www.federalreserve.gov/newsevents/pressreleases/monetary20071211a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20060629a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20060808a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20060920a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20061025a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20061212a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20060131a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20060328a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20230920a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20231101a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20231213a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20240131a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20240320a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20240501a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20240612a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20240731a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20240918a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20241107a.htm",
  "https://www.federalreserve.gov/newsevents/pressreleases/monetary20241218a.htm"
)
length(links)

# Extract year of publication from the statement's release date, and create a data frame with date, year and URL. 
statement.dates<-NULL
year<-NULL
for(i in seq(from=1, to=length(links))) {
  statement.dates[i]<-(str_extract(links[i],"[[:digit:]]+"))
  year[i]<-substr(statement.dates[i],1,4)
}
reports<-data.frame(year,statement.dates, links)
# Convert factors to characters
reports %<>% mutate_if(is.factor, as.character)%>% arrange(statement.dates)

# Loop through the statement links and scrape the content from the Federal Reserve website.
# Discard irrelevant portions of the extracted content i.e. preliminary paragraphs and last paragraph.
statement.content<-NULL
statement.length<-NULL
for(i in seq(from=1, to=length(reports$links))) {
  stm.url<-getURL(reports$links[i])
  stm.tree<-htmlTreeParse(stm.url,useInternal=TRUE )
  stm.tree.parse<-unlist(xpathApply(stm.tree, path="//p", fun=xmlValue))
  n<-(which(!is.na(str_locate(stm.tree.parse, "release")))+1)[1]
  l<-length(stm.tree.parse)-1
  # Condense separate paragraphs into one element per statement date
  reports$statement.content[i]<-paste(stm.tree.parse[n:l], collapse = "")
  # Remove line breaks
  reports$statement.content[i]<-gsub("\r?\n|\r"," ",reports$statement.content[i])
  #reports$statement.content[i]<-gsub("\\.+\\;+\\,+","",reports$statement.content[i])
  # Count number of characters per statement
  reports$statement.length[i]<-nchar(reports$statement.content[i])
  #reports$statement.length[i]<-wordcount(reports$statement.content[i], sep = " ", count.function = sum)
}

head(reports)

saveRDS(reports, file = "fomc_data.rds")

FOMClen=reports[,c(2,3,5)]
#***********************FoMC data*******************
write.csv(reports,"2.reports-in.csv")

# Correct the date for one statement, because the URL is not in sync with the actual date inside the statement content
reports$statement.dates[match(c("20070618"),reports$statement.dates)]<-"20070628"

d4<-readRDS(file = "fomc_data.rds")
dim(d4)

str(d4)

#-------------------------------------------------------
#2.1. Analyse FOMC statement word lengths and word frequency
# Compute total statement length per year by aggregating across individual statements

yearly.length<-reports%>% group_by(year) %>% summarize(words.per.year=sum(statement.length))
yearly.length

# Graph the total statement length per year
#***********Figure 1.Yearwise word frequency**************
ggplot(yearly.length, aes(x=yearly.length$year,y=yearly.length$words.per.year))+geom_bar(stat="identity",fill="darkblue", colour="black") + coord_flip()+xlab("Year")+ylab("Statement Length")


#Verify word count for a sample word in a sample statement. similarly change date & get
sample<-reports%>%filter(reports$statement.dates=="20220126")
#sample[,4]

str_count(sample, pattern="inflation")


#2.2 Adding custom words and names to the list of stop words
# Add custom words to the stop words list to exclude proper nouns/names and words such as "committee" which would provide no meangingful insight into the statement's sentiment analysis
#print(stop_words)
words<-c("committee", "ben", "geithner", "bernanke", "timothy", "hoenig", "thomas", "donald", "kevin", "mishkin", "kroszner", "kohn", "charles", "frederic")
lexicon<-c("Custom")
my.stop_words<-data.frame(words, lexicon)
colnames(my.stop_words)<-c("word","lexicon")
new.stop_words <- rbind(my.stop_words, stop_words)
new.stop_words$word<-as.character(new.stop_words$word)
new.stop_words$lexicon<-as.character(new.stop_words$lexicon)
head(new.stop_words)

#2.3 Cleanse data - remove irrelevant characters and calculate the frequency of the main words per statement date
# Strip out punctuations, white space and custom stop words, and calculate the word frequency by statement date
report.words<-reports %>%mutate(date = statement.dates, year = year, text= statement.content) %>% unnest(text) %>% unnest_tokens(word, text) %>%mutate(word = stripWhitespace(gsub("[^A-Za-z ]"," ",word))) %>% filter(word != "") %>% filter(word != " ") %>%anti_join(new.stop_words)%>% count(date, year, word, sort = TRUE)%>% mutate(frequency = n) %>% select(date, year, word, frequency)

#2.4 Verify if the count is correct for a given combination of sample word and statement
# Verify the count for the word "inflation" during the statements published in 2007 
report.words%>%filter(year=='2019', word=='inflation')

# Rank most frequent words by year
f_text<-report.words%>% group_by(year,word) %>% summarize(total=sum(frequency))%>%arrange(year,desc(total),word)%>% mutate(rank=row_number())%>%ungroup() %>% arrange(rank,year)
# Select the top 10 ranked words per year
topWords <- f_text %>% filter(rank<11)%>%arrange(year,rank)
print(topWords)

write.csv(topWords,"2.words_Freq.csv")



#2.5 Graph the most frequent words per year
# Graph top 10 most frequent words by year
#*************Figure 5************
gg <- ggplot(head(topWords, 90), aes(y=total,x=reorder(word,rank))) + geom_col(fill="#27408b") +
  facet_wrap(~year,scales="free", ncol=3)+ coord_flip()+theme_ridges(font_size=11) + 
  labs(x="",y="",title="Most Frequent Words in FOMC Statements grouped by years (2006 - 2014)")
gg

gg <- ggplot(tail(topWords, 90), aes(y=total,x=reorder(word,rank))) + geom_col(fill="#27408b") +
  facet_wrap(~year,scales="free", ncol=3)+ coord_flip()+theme_ridges(font_size=11) + 
  labs(x="",y="",title="Most Frequent Words in FOMC Statements grouped by years (2015 - 2023)")
gg


#-------------percentage
perc<-report.words%>% group_by(year) %>% summarize(total=sum(frequency))
head(perc)

library(readr)
per_sw=read.csv("C:/Users/SASTRA/Desktop/Fomc/final/2.Words_Percent.csv")
names(per_sw)

fft<-per_sw%>% group_by(year,word) %>% summarize(totalpercent=percentage)%>%arrange(year,desc(totalpercent),word)%>% mutate(rank=row_number())%>%ungroup() %>% arrange(rank,year)
# Select the top 10 ranked words per year
topWordsP <- fft %>% filter(rank<11)%>%arrange(year,rank)
names(topWordsP)

library(ggplot2)
#***************Figure 6***************
gg <- ggplot(head(topWordsP, 90), aes(y = totalpercent, x = reorder(word, rank))) +
  geom_col(fill = "#add8e6") +  # Light blue color
  facet_wrap(~year, scales = "free", ncol = 3) +
  coord_flip() +
  theme(axis.title.x = element_blank(),  # Hide x-axis title
        axis.text.x = element_blank(),   # Hide x-axis labels
        axis.ticks.x = element_blank()) +  # Hide x-axis ticks
  labs(x = "", y = "", title = "Most Frequent Words % in FOMC Statements grouped by years (2006 - 2014)")

# Add percentage labels inside the bars in black font
gg + geom_text(aes(label = paste0(totalpercent, "%")), 
               position = position_stack(vjust = 0.5), size = 3, color = "black")


gg <- ggplot(tail(topWordsP, 90), aes(y = totalpercent, x = reorder(word, rank))) +
  geom_col(fill = "#add8e6") +  # Light blue color
  facet_wrap(~year, scales = "free", ncol = 3) +
  coord_flip() +
  theme(axis.title.x = element_blank(),  # Hide x-axis title
        axis.text.x = element_blank(),   # Hide x-axis labels
        axis.ticks.x = element_blank()) +  # Hide x-axis ticks
  labs(x = "", y = "", title = "Most Frequent Words % in FOMC Statements grouped by years (2015 - 2023)")

# Add percentage labels inside the bars in black font
gg + geom_text(aes(label = paste0(totalpercent, "%")), 
               position = position_stack(vjust = 0.5), size = 3, color = "black")

#---------------------reports EDA completed-----------------
#3. Human Classification
#3.1 Merging FOMC data and Classification Data
library(readr)
cls=read.csv("C:/Users/SASTRA/Desktop/Fomc/final/3.FOMC_Class.csv")
#cls = read_csv(cls , col_types = cols( Date = col_character() ) )
#cls %>% rename( Economic.Growth = "Economic Growth", Employment.Growth = "Employment Growth", Medium.Term.Rate = "Medium Term Rate", Policy.Rate = "Policy Rate") -> cls
col_types = cols( Date = col_character())
str(cls)

library(tidyverse)
library(lubridate)

cls[,"Date"] = as.character(cls[["Date"]])

d4 %>% inner_join( cls , by = c("statement.dates" = "Date")) %>%
  mutate( date_mdy = mdy(Date2)) %>%
  select(Index, 
         year ,
         statement.dates, 
         links, 
         statement.content, 
         statement.length ,
         date_mdy,
         Economic.Growth,
         Employment.Growth,
         Inflation,
         Medium.Term.Rate,
         Policy.Rate ) -> mgData
str(mgData)

library(kableExtra)
mgData %>% select( Index, date_mdy, Economic.Growth, Employment.Growth, Inflation, Medium.Term.Rate, Policy.Rate) %>% kable() %>% kable_styling(bootstrap_options = c("hover", "striped")) %>%
  scroll_box(width = "90%", height = "300px")

#3.2.Frequency Distributions of Each Attribute
#****************Figure 7**********************
library(gridExtra)
gEcon <- ggplot(data=mgData, aes(x=Economic.Growth, fill=Economic.Growth)) + 
  geom_bar() + theme(legend.position = "none")
gEmp  <- ggplot(data=mgData, aes(x=Employment.Growth, fill=Employment.Growth)) + 
  geom_bar() +  theme(legend.position = "none")
gInf  <- ggplot(data=mgData, aes(x=Inflation, fill=Inflation)) + 
  geom_bar() + theme(legend.position = "none")
gRate <- ggplot(data=mgData, aes(x=Medium.Term.Rate, fill=Medium.Term.Rate)) + 
  geom_bar() + theme(legend.position = "none")
gPolicy <- ggplot(data=mgData, aes(x=Policy.Rate, fill=Policy.Rate)) + 
  geom_bar() + theme(legend.position = "none")
grid.arrange(gEcon, gEmp, gInf, gRate, gPolicy, ncol=3, nrow=2 )


library(rcompanion)
#4.2.3 Covariation of Attributes
mgData %>% select(Economic.Growth:Policy.Rate) -> catData  # categorical data
cv = matrix(rep(0,25), nrow=5, ncol=5)  # Allocate a 5x5 matrix of cramerV values initialized to 0.
for(idx in 1:5){
  for(jdx in 1:5){
    cv[idx,jdx] = cramerV(catData[,idx], catData[,jdx])
  }
}

#******************Figure 8
library(ggcorrplot)
rownames( cv ) = colnames(catData)
colnames( cv ) = colnames(catData)
ggcorrplot(cv, lab=TRUE, ggtheme = ggplot2::theme_classic(), colors=c("violet", "white", "lightgreen")) +
  ggtitle("CramerV Matrix", subtitle="Classification Attributes Comparison")


#5. Analysis
#5.1 Text Classification
fomc_data <-mgData
head(select(fomc_data, Index,year,statement.dates,statement.length,date_mdy,Employment.Growth,Economic.Growth,Inflation,Medium.Term.Rate,Policy.Rate))

set.seed(1234567)
fomc_Rand <- fomc_data[sample(nrow(fomc_data)),]

customStopWords <- c("the federal open market committee", "committee")

##############################error
library(dplyr)
library(rlang)
library(stringr)
fomc_dataX <- fomc_Rand %>% mutate(statement.content = tolower(statement.content))
#fomc_dataX$statement.content <- str_replace_all(fomc_dataX$statement.content, customStopWords, "")


library(tm)
# form a corpus?
corpus <- VCorpus(VectorSource(fomc_dataX$statement.content))
# Remove Punctuation
corpus <- tm_map(corpus, content_transformer(removePunctuation))
# Remove numbers
corpus <- tm_map(corpus, removeNumbers)
# Convert to lower case
corpus <- tm_map(corpus, content_transformer(tolower))
# Remove stop words
corpus <- tm_map(corpus, content_transformer(removeWords), stopwords("english"))
##Stemming
corpus <- tm_map(corpus, stemDocument)
# Remove Whitespace
corpus <- tm_map(corpus, stripWhitespace)

# Create Document Term Matrix
dtm <- DocumentTermMatrix(corpus)
# handle sparsity
corpusX <- removeSparseTerms(dtm, 0.60)
# convert to matrix
data_matrix <- as.matrix(corpusX)

dim(data_matrix)

#5.1.1 Medium.Term.Rate
mRate <- data_matrix
# attach the 'medium.term.rate' column
mRate_matrix <- cbind(mRate, fomc_dataX$Medium.Term.Rate)
# rename it to 'tone'
colnames(mRate_matrix)[ncol(mRate_matrix)] <- "tone"
# convert to data frame
mRateData <- as.data.frame(mRate_matrix)
# convert 'tone' to lower case and make it a factor column as well
mRateData$tone <- as.factor(tolower(mRateData$tone))
write.csv(mRateData,'mRateData.csv')

#5.1.2 Economic.Growth
econGrowth <- data_matrix
# attach the 'Economic.Growth' column
econG_matrix <- cbind(econGrowth, tolower(fomc_dataX$Economic.Growth))
# rename it to 'growth'
colnames(econG_matrix)[ncol(econG_matrix)] <- "egrowth"
# convert to data frame
econData <- as.data.frame(econG_matrix)
# convert 'growth' to a factor column as well
econData$egrowth <- as.factor(econData$egrowth)

write.csv(econData,'EcoData.csv')

#5.1.3 Inflation
# Create Document Term Matrix
dtmI <- DocumentTermMatrix(corpus)
# handle sparsity
corpusI <- removeSparseTerms(dtm, 0.60)
# convert to matrix
data_matrixI <- as.matrix(corpusI)
inflation <- data_matrixI
# attach the 'Inflation' column
inflation_matrix <- cbind(inflation, tolower(fomc_dataX$Inflation))
# rename it to 'inflation'
colnames(inflation_matrix)[ncol(inflation_matrix)] <- "inflation"
# convert to data frame
inflationData <- as.data.frame(inflation_matrix)
# convert 'inflation' to a factor column
inflationData$inflation <- as.factor(inflationData$inflation)

write.csv(inflationData,'EInflaData.csv')

#5.1.4 Employment.Growthsyr
empGrowth <- data_matrix
# attach the 'Employment.Growth column
emp_matrix <- cbind(empGrowth, tolower(fomc_dataX$Employment.Growth))
# rename it to 'empGrowth'
colnames(emp_matrix)[ncol(emp_matrix)] <- "empGrowth"
# convert to data frame
empData <- as.data.frame(emp_matrix)
# convert 'empGrowth' to a factor column as well
empData$empGrowth <- as.factor(empData$empGrowth)

write.csv(empData,'EmpData.csv')

#5.1.5 Policy.Rate
plRate <- data_matrix
# attach the 'Policy.Rate' column
pl_matrix <- cbind(plRate, tolower(fomc_dataX$Policy.Rate))
# rename it to 'empGrowth'
colnames(pl_matrix)[ncol(pl_matrix)] <- "policy"
# convert to data frame
plData <- as.data.frame(pl_matrix)
# convert 'policy' to a factor column as well
plData$policy <- as.factor(plData$policy)

write.csv(plData,'PoData.csv')


#----------------Sentiment________

library(readr)
Sentiment=read.csv("C:/Users/SASTRA/Desktop/Fomc/Final/1.FOMC_tone.csv")


str(Sentiment)

Score=c(0)
for(i in seq(from=1, to=150))
    {Score[i]=max(Sentiment[i,4:6])
      }                          
Score=as.numeric(Score)
Ed=as.data.frame(cbind(Sentiment[,2],Score,Sentiment[,7]))
colnames(Ed)[1]="Date"
colnames(Ed)[3]="Tone"
# Distribution of Sentiment Score for period of 2006 to 2023

#***********************Figure 9
Scr=round(Score)
library(ggplot2)
ggplot(Ed,aes(x=Scr))+
  geom_histogram(binwidth =5,color="black",fill="lightblue")+
  labs(x="Setiment Score",y="Frequency",title="Sentiment Score Distribution from 2006 to 2023")+
  theme(panel.background = element_rect(fill = "white"))


# Sentiment Score Trend
# Figure 10************************
ggplot(data = Ed) +
  aes(x = seq(1:150), y = Scr, group = 1) +  # Set group = 1 to connect all points into a single group
  geom_line(size=.98,color = "firebrick") +
  labs(x = "FOMC No.", y = "Sentiment Score", title = "Sentiment Score Trend over the Period of 2006 to 2023") +
  theme(panel.background = element_rect(fill = "white"))


# Figure 11************************
ggplot(Ed,aes(x=seq(1:150),y=Scr,color=Tone))+
  geom_point()+
  labs(x="FOMC No.",y="Sentiment Score",title="Sentiments spread over the period of 2006 to 2023")+
  theme(panel.background = element_rect(fill = "white"))

# Figure 12************************
ggplot(data=Ed, aes(x=Tone, fill=Tone)) + 
  geom_bar() + labs(x="Tone",y="Count of FOMC",title="Frequency of FOMC-Sentiment")
  

         