##Copyright (C) 2012 Sandhya
## 
## This program computes qlog of a variable   


## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 6/01-2014

 
function cfq = qcdf(x,q, b)

clear y ; clear y0  ; clear cfq ;
  
  y0 = (1+(q-1)*b*(x^2))  ;
  y = 1./y0  ;

  alph = (3-q)/(q-1)  ;
  ibt  = betainc(y,alph/2,.5)  ;
 
  if(x <= 0)
     	  
    cfq = ibt/2;
  else
    cfq = (1-ibt/2)  ;
  endif

	  
endfunction    
