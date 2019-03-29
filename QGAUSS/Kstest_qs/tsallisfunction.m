##Copyright (C) 2012 Sandhya
## 
## This function is used in leasqr to fit histogram with tsallis function


## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 2015-01-2

function[ tsa ] = tsallisfunction(x, q ,bet)

 
    clear tsa;
   


    ts = qgeneral_dist(x,q,bet,2) ;

    norm = tsallis_norm(q, bet)  ;
    tsa = ts/norm    ; 
	
  
 endfunction  
