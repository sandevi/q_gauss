##Copyright (C) 2012 Sandhya
## 
## This function computes the fisher measured and expected error in mle
## beta estimates, given q
##
##  Input:
##  x = log returns. 
##  th and kp are the estimated theta and kappa values
##
## Output:
##  erbm and erbe are the measured and estimated fisher errors
##  beta respectively. 
##  
## 
## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 9-19-2015

function [ erbm  erbe ] =est_mlerrbonly(x, th, kp)  ;

 
    clear erbm; clear erbe;
   
    n = length(x)  ;

    q = 1./th + 1;
    bet = th*kp  ;

    
##  Compute measured error

    [erbm] = fisher_measurerrbonly(x, q, bet)  ;

##  Compute expected  error


    [ erbe] = fisher_errorbonly(n, q, bet)  ;


 endfunction  
