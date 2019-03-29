##Copyright (C) 2012 Sandhya
## 
## This program computes the forward log returns of an equity 'a'
##  tau is the delay; 
## col is the column (date, open, high, low, close, volume)
##  r1,r2 are the 1st and last rows to be considered for computation
## nsmooth: is the no. of smoothing pts. for the histogram
## nb is the no. of bins for the histogram
## ##opt:  option to standardise the returns
## Output: ret: the logreturns at time i for the delay tau: 
## ret(i) = log(a(i+tau) - log(a(i))


## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 2012-01-20

function [ ret ] = smoothdif(a, tau, col,r1,r2, nsm, opt)

     l = length(a);
     clear ret ;clear retl;clear x ;
	 
     x = log(a(r1:r2,col)) ;    
     ret = x  ;
	 
##
## 
	 
     k = 0  ;

     for i = 1 : tau: length(ret) - tau
      k = k + 1;	     
      retl(k) = ret(i+tau) -  ret(i) ; 
     endfor

     clear ret;
     ret = retl  ;	 

     clear retl ;
