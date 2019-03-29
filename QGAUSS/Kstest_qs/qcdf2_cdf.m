##Copyright (C) 2012 Sandhya
## 
## This program computes qlog of a variable   


## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 6/01-2014

 
function cfq = qcdf2_cdf(x,q, b)

clear y ; clear y0  ; clear cfq ;
  
  y0 = (1+(q-1)*b*(x .^2))  ;
  y = 1./y0  ;

  alph = (3-q)/(q-1)  ;
  
  for i = 1: length(x)
  
   ibt(i)  = betainc(y(i),alph/2,.5)  ;
   
  if(x(i) <= 0)
     	  
    cfq(i) = ibt(i)/2;
  else
    cfq(i) = (1-ibt(i)/2)  ;
  endif
  
  endfor

	  
endfunction    
