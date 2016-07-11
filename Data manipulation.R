###########################################
###           DATA MANIPULATION         ###
###########################################  

###   CONTENT  ###

##  Loading data
##  Changing column names
##  Changing Data types
##  Verifying  
##  Filtering
##  Sorting
##  Adding variables
##  Rearranging variables
##  Adding observations
##  Combining tables 
##  Aggregating tables
##  Transform


# LOADING FILE
RSC <- read.csv(file.choose(), header = T)
head(RSC)
summary(RSC)

### Summary of "RSC.csv"
# branch:   branch code
# ncust:    number of customers
# age:      age of the borrower
# ed:       educational qualification based on degrees
# employ:   number of years in the job
# address:  number of years in the current address
# income:   income in '000$
# debtinc:  debt to income ratio (or burden) in %
# creddebt: credit card debt in '000$
# othdebt:  other debt in $mn
# default:  dummy for default incidents

# Call a particular cell in a dataframe
RSC[2,1]
RSC[1,2]

class(RSC$age)
search()
attach(RSC)
search()

class(age)

# CHANGING COLUMN NAMES
colnames(RSC)
colnames(RSC)[c(3,5)] <- c("customer.id","edu")
colnames(RSC)

# CHANGING DATA TYPE OF VARIABLES FOR MANIPULATION
levels(RSC[,1])
class(RSC[,1])
RSC[,1] <- as.factor(RSC[,1])
levels(RSC[,1])

summary(RSC)

# FILTERING
RSC.25 <- RSC[RSC$branch=="25", ]
dim(RSC.25)
head(RSC.25)

RSC.25.medianage <- RSC.25[RSC.25$age <= median(RSC.25$age, na.rm=T),]
dim(RSC.25.medianage)

# SORTING
RSC.25.sorted <- RSC.25[order(RSC.25$income),]
head(RSC.25.sorted)

RSC.25.decr <- RSC.25[order(RSC.25$income,decreasing=T),]
head(RSC.25.decr)

# ADDING VARIABLES
head(RSC)
RSC$totaldebt <- RSC$creddebt+RSC$othdebt
head(RSC)

# REARRANGING VARIABLES
#Way1
RSC1 <- RSC[,c("branch","ncust","customer.id", "age",
               "edu", "employ", "address", "income", 
               "debtinc", "creddebt", "othdebt", 
               "totaldebt", "default" )]
head(RSC1)

#Way2
colnames <- colnames(RSC)[1:11]
colnames
RSC2 <- RSC[,c(colnames, "totaldebt", "default" )]
head(RSC2)

# ADDING OBSERVATIONS
RSC.25[100,]
last.row <- c("25",4719, 298345, 52, 5, 4, 20,100, 
              7.9, 1.50,2.15,0)
RSC.25[101,] <- last.row
tail(RSC.25)

# COMBINING TABLES
RSC.49 <- RSC[RSC$branch=="49",]
dim(RSC.49)
dim(RSC.25)
RSC.49[,13] <- NULL

RSC.25.49 <- rbind(RSC.25,RSC.49)
some(RSC.25.49)
dim(RSC.25.49)

RSC.25.49 <- rbind(RSC.25[1:50, ],RSC.49)
some(RSC.25.49)
dim(RSC.25.49)

# CLEAR WORKSPACE
rm(list=ls())


# Creating two tables
RSC <- read.csv(file.choose(), header = T)
dim(RSC)

totaldebt <- RSC$creddebt+RSC$othdebt
RSC1 <- cbind(RSC[1:10,3:4],totaldebt[1:10])
head(RSC1)
dim(RSC1)

# AGGREGATING DATA  ##splits data into subsets &
                    ##and computes statistics for each
aggregate(RSC[,c(8,10,11)], by=list(RSC$branch),
          FUN=sd)

# TRANSFORMING DATA
RSC1 <- transform(RSC, branch=as.factor(branch), 
                  totaldebt = (creddebt+othdebt))
head(RSC1)
class(RSC1$branch)

detach(RSC)
rm(list=ls())
