##Copyright (C) 2012 Sandhya
## 
## This function computes the cumulative probability function of a 
## Tsallis distribution for a given threshold stock pr.
## Input
##  logret = log return of a security
##  nh = no. for histogram (reccommended value = b100)
##  q, bet are the q and beta parameter values for Tsallis distribution
##  gam = 2 
## Output:
##  hs, xs are the  PDF and the bin values (of the standardised log returns)
##  xt: the xvalues for Tsallis and Gaussian dist. computation
##  tsa:  Tsaliis distribution
##  g: Gaussian distribution
##  
## 
## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 2015-08-14

function [ cumprb xout tsa] = tsaexact_cdf(x, amle, delay, xt)

 
    clear tsa; clear cumprb ;
   

##  Compute  Tsallis q gaussian distribution

##

    q = amle(1,7)  ; bet = amle(delay,8); 


    n = length(xt) ;
	for i = 1:n
	  cumprb(i) =  qcdf(xt(i), q ,bet);
	endfor  
	
  	
    xout = xt ;     
    

 endfunction  
