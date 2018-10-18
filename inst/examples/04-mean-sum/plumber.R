#* @get /mean
normalMean <- function(samples=10){
  data <- rnorm(samples)
  mean(10,20,30)
}

#* @post /sum
addTwo <- function(a, b){
  as.numeric(a) + as.numeric(b)
}
