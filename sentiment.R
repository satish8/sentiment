install.packages('devtools')
require('devtools')
install_github('mananshah99/sentR')
require('sentR')
#And a simple classification example:
  
  # Create small vectors for happy and sad words (useful in aggregate(...) function)
  positive <- c('happy', 'well-off', 'good', 'happiness')
negative <- c('sad', 'bad', 'miserable', 'terrible')

# Words to test sentiment
test <- c('I am a very happy person.', 'I am a very sad person', 
          'I’ve always understood happiness to be appreciation. There is no greater happiness than appreciation for what one has- both physically and in the way of relationships and ideologies. The unhappy seek that which they do not have and can not fully appreciate the things around them. I don’t expect much from life. I don’t need a high paying job, a big house or fancy cars. I simply wish to be able to live my life appreciating everything around me. 
')

# 1. Simple Summation
out <- classify.aggregate(test, positive, negative)
out

# 2. Naive Bayes
out <- classify.naivebayes(test)
out