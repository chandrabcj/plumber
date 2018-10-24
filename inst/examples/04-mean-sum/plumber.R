#* @get /mean
normalMean <- function(samples=10){
  data <- rnorm(samples)
  mean(10,20,30)
}

#* @get /connect
hdbconnection <- function(){
  library("RODBC")
  ch<-odbcConnect("HDB",uid="SBSS_39559419764611020834956769394813002379451511639335091671700080450",pwd="Ff3EPhK.dISDXPcOaQlI8uEzylH8EfLEwB-K83WmW40KzGVlYQAms-jqQjExWRAHNhL3pqEsoLWLxpDv9zg3MswEP5NMEGbWLyCbMVuNuBqBL0T7wbgTb1Ecej0R2TUQ")
  print(ch)
  res<-sqlFetch(ch,"SCM_IP_RL_INPUT")
  print(res)
}

#* @post /sum
addTwo <- function(a, b){
  as.numeric(a) + as.numeric(b)
}
