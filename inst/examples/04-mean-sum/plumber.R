#* @get /mean
normalMean <- function(samples=100){
  data <- rnorm(samples)
#  mean(100,200,300)
  result<-"hiiiii"
  return(result)
}

#* @get /connect
hdbconnection <- function(){
  library("RODBC")
  ch<-odbcConnect("HDB",uid="SBSS_39559419764611020834956769394813002379451511639335091671700080450",pwd="Ff3EPhK.dISDXPcOaQlI8uEzylH8EfLEwB-K83WmW40KzGVlYQAms-jqQjExWRAHNhL3pqEsoLWLxpDv9zg3MswEP5NMEGbWLyCbMVuNuBqBL0T7wbgTb1Ecej0R2TUQ")
  res<-sqlFetch(ch,"SCM_IP_RL_INPUT")
  return("helllllooooo")
}

#* @get /sam
addTwo <- function(){
  as.String("cool") 
}



#* @get /jyoti
addTwo <- function(){
  result<-"I am new TL" 
  return(result)
}
