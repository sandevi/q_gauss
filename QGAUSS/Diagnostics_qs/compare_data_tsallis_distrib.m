##Copyright (C) 2012 Sandhya
## 
## This function compares the log return PDF with the corresponding
##  Tsallis and Gaussian distributions
##  Input:
##  x = stock values- a matrix of n x 9
##  delay = return delay
##  col = column of x to be considered
##  r1, r2 are the minimum and maximum values of the row of x to be considered
##  frac_nh is the parameter that determines the no. of bins for the histogram
##  q, bet are the q and beta parameter values for Tsallis distribution
##  gam = 2 
## Output:
##  hs, xs are the  PDF and the bin values (of the standardised log returns)
##  xt: the xvalues for Tsallis and Gaussian dist. computation
##  tsa:  Tsaliis distribution
##  g: Gaussian distribution
##  
## 
## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 2012-01-20

function [ hs xs xt tsa g] = compare_data_tsallis_distrib(x,delay,col,r1,r2,frac_nh, q, bet, mu, gam=2,opt=0)

 
    clear xs; clear hs; clear tsa;clear xt; clear g;
   

    clear lr1; clear mom1; clear lrst  ;
		 
	[lr1 mom1] = percent_return(x,1,col,r1,r2, 0, 0, 0, 0)    ;
    
         mug = mom1(1) ; sig = mom1(2) ;	
      
	logret = lr1 ;


    if( delay > 1)

	 clear lr; clear mom; clear lrmu ; clear lrg ;

	 [lr mom] = percent_return(x,delay,col,r1,r2, 0, 0, 0, opt)    ;
	 logret = lr   ;

	 mug = mom(1); sig = mom(2) ;

    endif	 

##  Remove outlyers (threshold the data)

         clear thresh; clear lrst; 
	 thresh = prctile(abs(logret),99.9,1) ;
         lrst = logret(abs(logret) <= thresh)  ;
	 clear logret;
	 logret = lrst;
	 clear lrst;

    n = length(logret)  ;    

    [hs xs nh dxh] = mypdf(logret, frac_nh, 1, 0)  ;



##  Compute normal and Tsallis q gaussian distribution

        xt = linspace(min(logret), max(logret), 100) ;

        m2 = sig  ; 
	clear g; clear ym ; clear y ;
	ym = (xs - mug) ;
	y = -(ym/m2).^2  ;
	g = exp(0.5*y) ;
	g = g/(sum(g))  ;


    clear xsmu ; 
    xsmu = (xs - mu)/mom1(2)  ; 
    tsa = qgeneral_dist(xsmu,q,bet,gam) ;
    norm1 = tsallis_norm(q,bet)      ;


    norm = (sum(tsa))  ;
    tsa = tsa/norm    ; 
##    printf(" norm , norm1 %f %f\n", norm, norm1)  ;
 endfunction  
