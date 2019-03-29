##
## This program computes the analytical form of tsallis distribution norm

 
## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 11-02-2014

function [z] = tsallis_norm(q, bet)
  
        clear z; 

# Compute cq = sqrt(pi) * gamma((3-q)/(2*(q-1)))/((sqrt(q-1))*gamma(1/(q-1)));

   q1 = 1./(q-1)  ;
   g1 = gamma(q1-0.5)  ;
   g2 = gamma(q1)  ;
   qsq = sqrt(q1)  ;
   
## The cq defined here (Lisa Borland) is square of cq in my notes

   cq = (sqrt(pi) * g1 *qsq / g2)^2  ;
	
	 
##  compute normalization 
     
     clear z;

     z = sqrt((cq / bet))  ;  
	 

      
endfunction
