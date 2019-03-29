##Copyright (C) 2012 Sandhya
## 
## This function computes the fisher measured and expected error in mle
## q and beta estimates
##
##  Input:
##  x = log returns. 
##  th and kp are the estimated theta and kappa values
##
## Output:
##  erqm, erbm, erqe and erbe are the measured and estimated fisher errors
## in q and beta respectively. 
##  
## 
## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 9-19-2015

function [ erqm erbm erqe erbe ] =est_mlerr(x, th, kp)  ;

 
    clear erqm; clear erbm; clear erqe; clear erbe
   
    n = length(x)  ;
    
##  Compute measured error

    [erqm erbm ] = fisher_measurerrqb(x, th,kp)  ;

##  Compute expected  error


    [erqe erbe ] = fisher_errorqb(n,th,kp)  ;


 endfunction  
