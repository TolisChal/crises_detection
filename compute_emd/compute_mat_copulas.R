#! /usr/bin/Rscript

library(volesti)
library(tawny)
library(R.matlab)

# install volesti in R from https://github.com/TolisChal/volume_approximation/tree/socg_journal

mat = read.csv("path/to/DJ600_Returns_top100.csv")
dates=mat$X
MatReturns = as.matrix(mat[,-c(1)])


MatReturns = matrix(as.numeric(MatReturns [,]),nrow = dim(MatReturns )[1],
                    ncol = dim(MatReturns )[2], byrow = FALSE)

step = 860
r1=3205
r2=r1+step
while(TRUE) {
  
  cops = copulas(MatReturns = MatReturns[r1:r2,])
  writeMat(paste0(getwd(),"/copulas_",r1,":",r2-59,".mat"),cops=cops)

  if (r2==dim(MatReturns )[1]){
    break
  }
  
  r1=r2-58
  r2=min(r1+step-1, dim(MatReturns )[1])
  
}
