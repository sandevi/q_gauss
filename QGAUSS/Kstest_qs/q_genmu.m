##Copyright (C) 2012 Sandhya
## 
## This program computes qlog of a variable   


## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 6/01-2014

 
function [qrnd mom ] = q_genmu(n, q, b, muq, sig)
 

## Generate n random numbers from a uniform distribution [0 - 1]

   clear y1 ;  clear y2; clear qrnd; clear mom ;


   
##   rand("state",v1) ;
   y1 = rand(n,1)  ;


##   rand("state",v2) ;
   y2 = rand(n,1)  ;
   
   clear g1  ; clear g2; clear g;
   
   
   
## Generate q-gaus dist. random numbers   
   
  alph = (3-q)/(q-1)  ;
  sgz2 = (1.) / (b*(3-q)) ;
  sgz = sqrt(sgz2)  ;
  
  qp = (1+q) / (3-q)  ;
  g1 = sqrt(-2*qlog(y1,qp))  ;
  g2 = cos(2*pi*y2)  ;
  g = g1 .* g2  ;
  
    clear qrn1; 	
	qrn1 =  sgz .* g  ;

##  Standardise the data with same standardisation as the input real data
	

	clear mom; clear qrn2;

	mom = moment4(qrn1)  ;
##	qrn2 = (qrn1 - mom(1))/mom(2)  ;
	qrn2 = (qrn1 - muq) ./ (sig*sgz)  ;

	qrnd =   qrn2  ;

endfunction    
