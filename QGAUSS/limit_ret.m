##Copyright (C) 2012 Sandhya
## 
## This program thresholds the value of returns to be within the 
## specified values and optinally standardizes them 


## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 2012-01-20

function [ ret mom] = limit_ret(x, thresh_lo, thresh_hi)

     l = length(x);
     clear ret ; clear mom;

	 
##   standardise the data

        
     mom = moment4(x);

##	 disp("mean and standard dev. are"); disp(mom(1)); disp(mom(2)) ;

     clear ret;
     ret = (x-mom(1))/mom(2)  ;

     if(thresh_hi == 0)
	thresh_hi =max((abs(ret))) ;
     endif	
   
     clear y ; clear y0 ; 
     y0= ret(abs(ret) > thresh_lo & abs(ret) <= thresh_hi)  ;
     y = y0*mom(2) + mom(1) ;

     clear ret; clear mom;
     mom = moment4(y)  ;
     ret = (y - mom(1))/mom(2)  ;

  
 endfunction
