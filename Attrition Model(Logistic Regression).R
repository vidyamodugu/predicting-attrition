rm(list=ls())

#mydata = read.csv("RepbyMonthVersion7Sample.csv")

##creating year variable
library(lubridate)
HD_DATA$date <- as.character(as.Date(as.character(HD_DATA$Month.End.Date), '%m/%d/%Y'))
HD_DATA$date <- ymd(HD_DATA$date)
HD_DATA$year <- year(HD_DATA$date)

###extracting rows from a dataframe for 2016.
attach(HD_DATA)
HDy <- HD_DATA[ which(year==2016),]
detach(HD_DATA)
#colnames(HD_DATA)

##Creating a new variable attrition
library(dplyr)
HD_Attrition<-mutate(HDy,Attrition = ifelse(U5.Date%in%c('',NA),1,0))
HD_Attrition$Attrition

#Creating a new column for total revenue
HD_Attrition$totalflows<-apply(HDy[,94:96],1,sum,na.rm=F)
sum(is.na
    (HD_Attrition$totalflows))

#Removing rows with NA values
attach(HD_Attrition)
HDnoNA <- subset(HD_Attrition,totalflows!=" ")
detach(HD_Attrition)
Viewpercentmissing

#Removing factors from the data
HD_short<-HD_Attrition[,c(-2:-16,-21,-23,-24,-39,-40,-41,-42,-47,-52,-101,-116,-61)]


#order it yearly
library(doBy)
HD_DATA.yearly<-summaryBy(.~ Masked.Rep.Id
                          +year,HD_short,FUN = mean )

names(HD_DATA.yearly)

names(HD_DATA.yearly)

#remove near-zero variance predictors
library(caret)
badColumns <- nearZeroVar(HD_DATA.yearly[,-90])
badNames <- names(HD_DATA.yearly[,-90])[badColumns]
if(length(badColumns)>0) {HD_DATA.yearly <- HD_DATA.yearly[,!(names(HD_DATA.yearly) %in% badNames)] }


# Imputing missing values with MEAN
for(i in 1:ncol(HD_DATA.yearly)){
  HD_DATA.yearly[is.na
                 (HD_DATA.yearly[,i]), i] <- mean(HD_DATA.yearly[,i], na.rm = TRUE)
}




#finding and removing correlated predictors
library(corrplot)
library(caret)
correlations <- cor(HD_DATA.yearly,use="pairwise.complete.obs")

highCorr <- findCorrelation(correlations, cutoff = .75,verbose = FALSE)
length(highCorr)
#removing correlated predictor from the data
HD<-as.data.frame(HD_DATA.yearly[,-41])


# Centering and Scaling
preProcValues <- preProcess(HD[,-78], method=c('center', 'scale', 'BoxCox'), na.omit=T)
preProcValues
HD_transformed<-predict(preProcValues,HD)
HD_transformed<-HD
HD$Attrition<-factor(HD$Attrition.mean, levels=c(0,1), labels=c('leave', 'stay'))
HD<-HD[,-78]

#logistic regression
library(MASS)
Attrition_model<-step(glm(Attrition~.,data=HD,family=binomial("logit")))
summary(Attrition_model)
HD_predict <- predict.glm(Attrition_model,newdata=HD,type = 'response')

#Writing results to a datframe
Attritionpredictions<-cbind.data.frame(HD_predict,HD$Certified.Financial.Planner.mean, 
                                       HD$X3MonthUniqueClientIdCount.mean,HD$X3MonthUniqueSSNCount.mean, 
                                       HD$X3MonthUniqueAccountNumberCount.mean,HD$Months.To.First.Trade.Count.mean, 
                                       HD$Connect.Attendance.mean,HD$MonthBeginBalanceAmount.mean , 
                                       HD$MonthEndBalanceAmount.mean,HD$InflowAmount.mean,HD$FirmExchangeOutAmount.mean, 
                                       HD$RepInAmount.mean ,HD$X3MonthBeginBalanceAmount.mean,HD$X3MonthEndBalanceAmount.mean, 
                                       HD$X3MonthAvgInflowAmount.mean,HD$X3MonthAvgNetflowAmount.mean , 
                                       HD$X3MonthAvgFirmExchangeInAmount.mean,HD$X3MonthAvgFirmExchangeOutAmount.mean, 
                                       HD$X3MonthAvgAdvisoryConversionInAmount.mean,HD$X3MonthAvgAdvisoryConversionOutAmount.mean, 
                                       HD$X3MonthAvgRepInAmount.mean,HD$X3MonthAvgRepOutAmount.mean, 
                                       HD$X3MonthAvgReInvestAmount.mean,HD$X3MonthAvgAdvisoryAmount.mean,
                                       HD$X3MonthAvgFeesAmount.mean,HD$X3MonthAvgUnClassifiedAmount.mean , 
                                       HD$X3MonthAvgMarketChangeAmount.mean,HD$Securities.Amount.mean , 
                                       HD$Advisory.Amount.mean,HD$Insurance.Amount.mean,HD$Securities.Payout.to.Rep.Amount.mean, 
                                       HD$Insurance.Payout.to.RepAmount.mean,HD$X3MonthMovingAverageSecuritiesRevenueAmount.mean, 
                                       HD$X3MonthMovingAverageAdvisoryPayoutAmount.mean,HD$X3MonthMovingAverageInsuranceRevenueAmount.mean, 
                                       HD$X12MonthRollingGrossAmount.mean,HD$X12MonthRollingGrossFrom1yearAgoAmount.mean,
                                       HD$X12MonthRollingGrossFrom1yearAgoPercentDifference.mean , 
                                       HD$X12MonthRollingGrossFrom2yearAgoPercentDifference.mean , 
                                       HD$X12MonthRollingGrossFrom3yearAgoPercentDifference.mean)


# writing results to excel
write.csv(Attritionpredictions,"Attritionpredictions.csv")
library(ROCR)
ROCRpred <- prediction(HD_predict, HD$Attrition)
ROCRperf <- performance(ROCRpred, 'tpr','fpr')
plot(ROCRperf, colorize = TRUE, text.adj = c(-0.2,1.7))

#Percentage for AUC
auc <- performance(ROCRpred, measure = "auc")


#confusion matrix
table(HD$Attrition, HD_predict>0.5)


#plot for variables missing
library(Amelia)
library(mlbench)
# load dataset
data=HD_DATA.yearly
# create a missing map
missmap(HD_DATA.yearly, col=c("black", "grey"), legend=FALSE)

