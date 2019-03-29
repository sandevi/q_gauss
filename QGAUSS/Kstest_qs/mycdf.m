##Copyright (C) 2012 Sandhya
## 
## This program computes the un-normalised CDF of a given data
## For input parameter opt = 0, bin widths are calculated from
##  Freedman - Diaconis formula  dx =2*IQR*n^-1/3;
##  No. of bins nb = range(xst)/dx + 1; 
##  For opt > 0, no. of bins arcalculated as opt * length(xst) / 10  ;
 

## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 2012-01-20

function [ cdfs xt nb dx] = mycdf(xst,opt,opt_norm)

#  subtract the mean and std dev from x

   clear hs;
   clear xs ;
   
  
  if(opt == 0) 
   l = length(xst)  ;
   dx = 2.0*iqr(xst)/(l)^(.333)  ;
##   dx = 4.96*iqr(xst)/(l)^(.25)  ;
   nb = floor((range(xst))/dx) + 1  ;
   
  elseif(opt > 0)
     nb = floor(opt*(length(xst))/(10.))  ;
     dx = (range(xst))/(nb-1)  ;
  endif  

#  Compute pdf

   clear xs0; clear hs0;
   [hs0 xs0] = hist(xst, nb);
    hs = hs0;
	xs = xs0;
   

   if(opt_norm > 0)
     norm = dx*sum(hs0)  ;
     hs = hs0/norm   ;
   endif
   
## compute cdf at xt

    xt = linspace(min(xst), max(xst), nb) ;

    clear cdfs  ;
	cdfs = discrete_cdf(xt, xs, hs)  ;
   
   
endfunction