#! /usr/bin/Rscript

library(volesti)
library(R.matlab)

# install volesti in R from https://github.com/TolisChal/volume_approximation/tree/socg_journal

source(paste0(getwd(),'/get_sgn.R'), echo=TRUE)
source(paste0(getwd(),'/gdm.R'), echo=TRUE)

sgns = readMat('Signatures.mat')
sgns = sgns$Signatures

s1 = get_sgn(sgns,1)
s2 = get_sgn(sgns,2)
F1 = s1$F
F2 = s2$F
W1 = s1$W
W2 = s2$W

f = gdm(F1, F2)

m = dim(F1)[1]
n = dim(F2)[1]

A1 = matrix(0, m, m * n)
A2 = matrix(0, n, m * n)

for (i in 1:m) {
  for (j in 1:n) {
    k = j + (i - 1) * n
    A1[i,k] = 1
    A2[j,k] = 1
  }
}

A = rbind(A1, A2)
b = rbind(W1, W2)

Aeq = matrix(1, m + n, m * n)
beq = matrix(1, m + n, 1) * min(sum(W1), sum(W2))

l = c(matrix(0, m * n))

D = matrix(rep(0,6968*6968), ncol = 6968, nrow = 6968)
tt = 0
for (i in 1:6966) {
  s1 = get_sgn(sgns,i)
  s2 = get_sgn(sgns,i+1)
  B = rbind(s1$W, s2$W)
  for (j in (i+2):6968) {
    
    s2 = get_sgn(sgns,j)
  
    B=cbind(B, rbind(s1$W, s2$W))
    #D[i,j] = solve_lp22(A,b,Aeq,beq,l,f)
  }
  tim=system.time({ dis = emd_Bmat(B, A, m, f, i) })
  tt = tt + as.numeric(tim)[3]
  D[i,(i+1):6968] = dis
  if (tt>300) {
    writeMat(paste0(getwd(),"/D_",1,"_",6968,".mat"),D=D)
    tt = 0
  }
}

s1 = get_sgn(sgns,6967)
s2 = get_sgn(sgns,6968)
B = rbind(s1$W, s2$W)
D[6967,6968] = emd_Bmat(B, A, m, f, i)
writeMat(paste0(getwd(),"/D_",1,"_",6968,".mat"),D=D)


