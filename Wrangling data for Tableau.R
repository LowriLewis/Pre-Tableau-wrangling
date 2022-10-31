###Setting the working directory###
pathToWD <- "C:/Users/Lowri/Downloads/archive (1)"
setwd(pathToWD)

###Reading in csv files###
Orders <- read.csv("OrderByOrder.csv")
Shifts <- read.csv("ShiftByShift.csv")
longLats <- read.csv("longs lats.csv", header=F)


###Loding in packages###
library('dplyr')
library('limma')


###splitting column into data and time columns, then removing Start.DateTime and 2 column###
Orders <- cbind(Orders, strsplit2(Orders$Start.DateTime, split=" "))
drop <- c("Start.DateTime", "2")
Orders <- Orders[,!(names(Orders) %in% drop)]
###Renaming Date column###
Orders <- Orders %>% rename('Date' = '1')

###Working out cumulative hours worked and allocating to a new column in Shifts###
Cumsum <- Shifts$Duration..hrs.
Shifts$CumsumHours <- cumsum(Cumsum)

###Creating a new dataframe with date and cumsumHours###
db2 <- subset(Shifts, select = c("Date", "CumsumHours"))

###Renaming columns of the longLats df###
longLats <- longLats %>% rename('Longitude'='V2', 'Latitude'='V1')

###Getting a list of unique restaurants in alphabetical order to attribute longitude and latitude to them###
Restaurant <- sort(unique(Orders$Resturant))
longLats <- cbind(longLats, restaurants)

###Writing dataframes to csv files ready to import into tableau###
write.csv(Orders, "C:/Users/Lowri/Documents/Orders.csv", row.names = FALSE)
write.csv(Shifts, "C:/Users/Lowri/Documents/Shifts.csv", row.names = FALSE)
write.csv(longLats, "C:/Users/Lowri/Documents/longLats.csv", row.names = FALSE)
write.csv(db2, "C:/Users/Lowri/Documents/db2.csv", row.names = FALSE)