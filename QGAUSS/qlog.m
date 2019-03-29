##Copyright (C) 2012 Sandhya
## 
## This program computes qlog of a variable   


## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 6/01-2014

 
function y = qlog(x,q)

clear y ;
  
if q == 1
    y = log(x);
else
   y =  (1 - x .^(1-q)) / (q-1)   ;
end

endfunction    
