##Copyright (C) 2012 Sandhya
## 
## This program generates  realisation of wiener process
## weighted by tsallis distribution^(1-q)/2 at various initial values
## of the log return . Histograms can then be computed for differrent returns 
## and compared with data. 
## Input:
##   x0{} = a set of nt initial values
##   nr = no. of returns (1 day, 2 - day -----nr day returns)
##   q  = tsaliis q parameter
##
## Output:
##  omg(nr,nt) = log returns (nt values for each nr)
##  bet_t  =  beta values (nr) 
##

## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 11-03-2014

function [ omg  bet_t ] = genhist_tsallisnoise(x0, nd, q, dt)
  
    clear omg; clear bet_t ;

 
     nt = length(x0)  ;

##   compute no. time steps, given ndth return and dt

     nr = nd/dt  ;
     disp(nr)  ;

  	 
## Compue tsallis returns for all initial values x0
 
     omg = zeros(nr,nt)  ;
     bet_t = zeros(nr,nt)  ;


     for i = 1:nt
       y0 = x0(i)  ;
   
       clear dg; clear omg0; clear bet_t0  ;

       [dg omg0 bet_t0] = gentsallisnoise(y0,nr,q, dt)  ;

       omg(:,i) = omg0(:)  ;
       bet_t(:,i) = bet_t0(:)  ;

     endfor   



      
endfunction
