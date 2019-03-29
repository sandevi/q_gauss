##Copyright (C) 2012 Sandhya
## 
## Main pgm for stock market prediction
##  x is the security data
##  
## 
## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 2012-01-20

function [ hs xs hsg xsg] = compare_data_gaus_distrib(x, tau, col,r1, r2, nh,opt)

 
   s = size(x);

## choose the closing value of equity x   
 
   logret = logreturn(x, tau, col,  r1, r2, 0,0,opt,0) ;

   clear hs; clear xs;
   

   [hs xs] = hist(logret,nh)  ;

##
    n = length(logret)  ;    

    mom = moment4(logret) ;

 disp("check mean and standard dev."); disp(mom(1)); disp(mom(2)) ;

  clear xsg; clear hsg;
  
  xmx = max(abs(logret)) ;
  xmin = -xmx; xmax = xmx;
  dx = ((xmax - xmin))/(nh - 1)  ; 
 
  [ hsg xsg] = gennormdist( n, mom(1), mom(2), dx) ;
 
##   smooth hsg
     
 # compute normalised  pdf
    
     if(opt == 1)	
 	  hsn = hs /(sum(hs)*dx)  ;
	  hsgn = hsg/(sum(hsg)*dx)  ;
	  disp(dx); disp(sum(hs)); disp(sum(hsg));
	  clear hs; clear hsg;
	  hs = hsn; hsg = hsgn  ;
	  clear hsn; clear hsgn;
	 endif 
  
  
 endfunction  
