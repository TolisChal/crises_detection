get_sgn <- function(Signatures, i) {
  
  a = Signatures[i]
  a = a[[1]]
  a=a[[1]]
  
  f = a[[1]]
  w = a[[2]]
  
  return(list("F"=f[[1]], "W"=w[[1]]))
  
}