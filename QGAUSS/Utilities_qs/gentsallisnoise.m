##
## This program generates a realisation  of wiener process
## weighted by tsallis distribution^(1-q)/2

 
## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 11-02-2014

function [ dg   yt omg  bet_t ] = gentsallisnoise(x0, nr, q, dt, mu, sig)
  
        clear t; 
        clear omg; clear pqomg ;
		
		disp(mu); disp(sig)  ;

# Compute cq = sqrt(pi) * gamma((3-q)/(2*(q-1)))/((sqrt(q-1))*gamma(1/(q-1)));
## Note; q is independent of time

   q1 = 1./(q-1)  ;
   q2 = 2-q  ;
   q3 = 3-q  ;
   g1 = gamma(q1-0.5)  ;
   g2 = gamma(q1)  ;
   qsq = sqrt(q1)  ;
   
## The cq defined here (Lisa Borland) is square of cq in my notes

   cq = (sqrt(pi) * g1 *qsq / g2)^2  ;
	
   cq_bet = (cq)^((1-q)/q3)  ;
   	
   disp(cq_bet);
 
     t = reshape([1:nr]*dt,nr,1) ;
  	 
## Compute time dependent bet	

     cq23 = cq_bet * ((q2*q3)^(-2/q3))  ;
	
     clear bet_t  ;
     bet_t = cq23 * t.^(-2/q3)   ;
     
	 
##  compute normalization (time dependent)
     
     clear zt;
     zt = sqrt((cq ./bet_t))  ;  
	 

 ##  draw a wiener noise starting with the input seed sd

     clear dg0; clear dg;
	 
##	 sd = 4.1179e+067  ;
##	 randn("state",sd)  ;
	 
	 dg0 = randn(nr,1);
	 clear mom;
	 mom = moment4(dg0)  ;
	 dg = reshape( (dg0 - mom(1))/mom(2),nr,1)  ;
##	 dg = reshape( (dg0) ,nr,1)  ;
	 
     
	 omg = zeros(nr,1);
	 pqomg = zeros(nr,1) ;
	 
    
  
   
## Boundary condn omg(1) = x0

   omg(1) = x0  ;   
    	 
## Compute p^(1-q)/2 at t = 1

   pqomg(1) = tsallisnoise(omg(1),q,bet_t(1),zt(1))  ;
	 
	 
	 
## Compute cumsum of tsallis noise

     for i = 2:nr 
	     
       omg(i) = omg(i-1) + ((dt))*(dg(i-1))*pqomg(i-1)  ;

	   
##  Compute p^(1-q)/2 at t = i   
	   
	   	   
       pqomg(i) = tsallisnoise(omg(i),q,bet_t(i),zt(i))  ;
	   
	   
     endfor

## Compute un_standardised log returns


        
      clear yt  ;
      disp(mu); disp(sig)  ;
      
      yt = mu*t + sig* omg ;

      
endfunction
