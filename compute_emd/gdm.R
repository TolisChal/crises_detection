gdm <- function(F1, F2){
  
  m = dim(F1)[1]
  n = dim(F2)[1]
  
  M = matrix(0, m, n)
  
  for (i in 1:m) {
    for (j in 1:n) {
      M[i, j] = sqrt(sum(c(F1[i,] - F2[j,])^2))
    }
  }

  return(c(t(M)))
    
}
  