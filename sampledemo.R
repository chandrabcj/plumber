#* @get /sam
sam1 <- function(){
  result<-"hiiiii"
  return(result)
}

#* @get /mean
normalMean <- function(){
  data <- c(10,20,30,40,50)
#  mean(100,200,300)
  result<-mean(data)
  return(result)
}

#* @get /connect
hdbconnection <- function(){
  
  install.packages('RODBC')
  library("RODBC")
  #dbconnection <- odbcDriverConnect("Driver=HDBODBC;
  #              Server=10.253.133.184; Port=30065; Database=mdca61030; 
  #              Uid=SBSS_39559419764611020834956769394813002379451511639335091671700080450; Pwd=Ff3EPhK.dISDXPcOaQlI8uEzylH8EfLEwB-K83WmW40KzGVlYQAms-jqQjExWRAHNhL3pqEsoLWLxpDv9zg3MswEP5NMEGbWLyCbMVuNuBqBL0T7wbgTb1Ecej0R2TUQ")
  
  ch<-odbcConnect("HDB",uid="SBSS_39559419764611020834956769394813002379451511639335091671700080450",pwd="Ff3EPhK.dISDXPcOaQlI8uEzylH8EfLEwB-K83WmW40KzGVlYQAms-jqQjExWRAHNhL3pqEsoLWLxpDv9zg3MswEP5NMEGbWLyCbMVuNuBqBL0T7wbgTb1Ecej0R2TUQ")
#  res<-sqlFetch(ch,"SCM_IP_RL_INPUT")
  return(ch)
}
