# Cleaning Data
rm(list=ls())

# Loading Libraries
library(data.table)
library(dplyr)

# Loading training and testing data
train <- fread("Data/train.csv")
test <- fread("Data/test.csv")

# Loading Other datasets
internship <- fread("Data/Internship.csv")
student <- fread("Data/Student.csv")

# ================================================================================================ #
# Merging training and testing Datasets
# ================================================================================================ #
# Creating flag
response <- train$Is_Shortlisted
train$Is_Shortlisted <- NULL

train$TF <- 1
test$TF <- 0

mydata <- rbind(train, test)
mydata$Is_Shortlisted <- c(response, rep(NA, 107428))

rm(response, train, test)

# ================================================================================================ #
# Merging Internship data with the actual data
# ================================================================================================ #
L1 <- match(mydata$Internship_ID, internship$Internship_ID)
mydata$L1 <- L1
mydata$internship_Profile <- internship$Internship_Profile[L1]
mydata$Skills_required <- internship$Skills_required[L1]
mydata$Internship_Type <- internship$Internship_Type[L1]
mydata$Internship_Location <- internship$Internship_Location[L1]
mydata$No_of_openings <- internship$No_of_openings[L1]
mydata$Stipend_Type <- internship$Stipend_Type[L1]
mydata$`Internship_Duration(Months)` <- internship$`Internship_Duration(Months)`[L1]

# ================================================================================================ #
# Merging Student data with the actual data
# ================================================================================================ #
L2 <- match(mydata$Student_ID, student$Student_ID)
mydata$L2 <- L2
mydata$Institute_Category <- student$Institute_Category[L2]
mydata$Institute_location <- student$Institute_location[L2]
mydata$hometown <- student$hometown[L2]
mydata$Degree <- student$Degree[L2]
mydata$Stream <- student$Stream[L2]
mydata$Current_year <- student$Current_year[L2]
mydata$Year_of_graduation <- student$Year_of_graduation[L2]
mydata$Performance_PG_in_10 <- 10*(student$Performance_PG[L2]/student$PG_scale[L2])
mydata$Performance_UG_in_10 <- 10*(student$Performance_UG[L2]/student$UG_Scale[L2])
mydata$Experience_Type <- student$Experience_Type[L2]
mydata$Profile <- student$Profile[L2]
mydata$Location <- student$Location[L2]
mydata$`Start Date` <- student$`Start Date`[L2]
mydata$`End Date` <- student$`End Date`[L2]

# Removing Other variables
rm(L1, L2, internship, student)

# ================================================================================================ #
# saving final data
# ================================================================================================ #
save(mydata, file="Data/mydata")

