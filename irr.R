library(dplyr)
library(openxlsx)
library(FinCal)


file_path="/home/satish/Downloads/"

file_name="CHIT_Profile.xlsx"

file_data <-read.xlsx(paste(file_path,file_name,sep=''),sheet = "Sheet1",check.names = F)



#function declare

dcf <- function(x, r, t0=FALSE){
 
  if(length(r)==1){
    r <- rep(r, length(x))
    if(t0==TRUE){r[1]<-0}
  }
  x/cumprod(1+r)
}

npv <- function(x, r, t0=FALSE){
  
  sum(dcf(x, r, t0))
}

pbp <- function(x, ...){
 
  i <- match(1, sign(cumsum(x)))
  i-2+(-cumsum(x)[i-1]/x[i])
}

dpbp <- function(x, r, t0=FALSE){
 
  pbp(dcf(x, r, t0))
}

irr <- function(x, t0=FALSE, ...){
 
  tryCatch(uniroot(f=function(i){sum(dcf(x, i, t0))}, 
                   interval=c(0,1))$root,
           error=function(e) return(NA)
  )
}

# main script starts

file_data_irr<-file_data %>%
  mutate(forth_lift_cashflow=ifelse(Month<4,5000,7000))%>%
  mutate(fortyh_lift_cashflow=ifelse(Month<40,5000,7000))%>%
  mutate(payback_without_lift=(Month-1)*(Installment))%>%
  mutate(investment=Yield-payback_without_lift)%>%
 summarise(
   case1=irr(c(-investment[4],forth_lift_cashflow[4:40])),
    case2=irr2(c(-investment[40],forth_lift_cashflow[40]))) 
     
  
 

