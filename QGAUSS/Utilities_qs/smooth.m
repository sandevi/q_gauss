##Copyright (C) 2012 Sandhya
## 
## This program smooths the data over nsmooth pts.
## Output: ret: smoothed data 


## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 2012-01-20

function [ ret ] = smooth(a, nsmooth)

   l = length(a);
   clear ret ;
##

	  
   
      ret = filter(ones(nsmooth,1)/nsmooth,1,a) ;

