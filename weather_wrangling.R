setwd("C:/Users/path/to/csv")

#### The libraries ####
library(tidyverse)
library(visdat)
library(data.table)
library(lubridate)

#### Load in the data frame ####
df1 <- read.csv("weather_aus.csv")

head(df1)
list1 <- unique(df1$Location)
str(df1)

#### Make the dataset more useful ####
# Create a new column called 'State' and add the state to each Location
df1["State"] <- NA

df1$State <- ifelse(grepl("Ballarat|Bendigo|Sale|MelbourneAirport|Melbourne|Mildura|Nhil|Portland|Watsonia|Dartmoor", df1$Location, ignore.case = TRUE), "VIC",
                    ifelse(grepl("Hobart|Launceston", df1$Location, ignore.case = TRUE), "TAS", 
                           ifelse(grepl("Adelaide|MountGambier|Nuriootpa|Woomera|Albany|Witchcliffe", df1$Location, ignore.case = TRUE), "SA",
                                  ifelse(grepl("PearceRAAF|PerthAirport|Perth|SalmonGums|Walpole", df1$Location, ignore.case = TRUE), "WA",
                                         ifelse(grepl("AliceSprings|Darwin|Katherine|Uluru", df1$Location, ignore.case = TRUE), "NT",
                                                ifelse(grepl("Brisbane|Cairns|GoldCoast|Townsville", df1$Location, ignore.case = TRUE), "QLD",
                                                       ifelse(grepl("Albury|BadgerysCreek|Cobar|CoffsHarbour|Moree|Newcastle|NorahHead|NorfolkIsland|Penrith|Richmond|Sydney|SydneyAirport|WaggaWagga|Williamtown|Wollongong|Canberra|Tuggeranong|MountGinini", df1$Location, ignore.case = TRUE), "NSW", "Other")))))))


unique(df1$State) # check that there are no instances of 'other' in the State column

# split 'Date' into 'Year', 'Month' and 'Day'
df1 <- separate(df1, "Date", c("Year", "Month", "Day"), sep = "-")


# add month name column
df1$Month <- gsub("(^|[^0-9])0+", "\\1", df1$Month, perl = TRUE) # remove 0s from month numbers

mymonths <- c("Jan","Feb","Mar",
              "Apr","May","Jun",
              "Jul","Aug","Sep",
              "Oct","Nov","Dec")

df1$Month <- as.integer(df1$Month)
df1$MonthName <- mymonths[df1$Month]


# reorder columns so 'Location' and 'State' are next to each other as are 'Month' and 'MonthName'
df1 <- df1[c(1,2,28,3,4,29,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27)]

# write.csv
write.csv(df1, "weather_vic_subset_2.csv", row.names = FALSE)
