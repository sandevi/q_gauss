function [ qf betf  ]  = weightedls(x, thresh, frac, q0, bet0, nv, opthist, optbeta )


   global thg  ;

   clear qf; clear betf;  


   qf = 0; betf = 0;

##   Setup defaults             

    
##
## Compute histograms
##
   if(opthist == 0)

## Compute variable binsize histograms

     clear pdf; clear xpd; clear dxv; clear xpdfv  ;

     [pdf xpd dxv xpdfv] = variable_binwidth_hist(abs(x),nv,1);

     clear wts;
     wts = dxv/sum(dxv)  ;
   else
     
## Compute constant bin size histogram

     clear pdf; clear xpd;

     [pdf xpd nb dx] = mypdf(abs(x),frac,1)  ;
     clear wts;

     wts0 = (abs(xpd)) ;
     wts = (wts0 .^.3) / (sum(wts0 .^ .3))  ;
   endif     
      	   
   
   th0 = 1. / (q0 -1)  ;  kp0 = bet0/th0  ;
   
   
##   printf(" Initial guess for q, bet, theta, kappa = %f  %f %f %f\n",q0,bet0,th0,kp0) ;
     
   
   clear xs; clear hs;
   
   idc = (xpd >= thresh) ;

   xs = xpd(idc) ; hs =  log(pdf(idc))  ;


   if(length(xs) < 10)
     disp(" No. of points for lsqr fit is < 10")  ;
     disp(" Reccommend decreasing threshold!") ;
     return
   endif

   if(optbeta == 0)

## Least sq est from log probabilities

     pin(1) = th0; pin(2) = kp0;

     [f, p, cvg, iter] = leasqr(xs,hs,pin,"logtsallis",.0001,20,wts);


     qf = 1. / p(1) + 1. ;
     betf = p(1) * p(2)  ; 

   else
 
      thg = th0;

      pin(1) = kp0 ;
      
      [fk, pk, cvg, iter] = leasqr(xs, hs, pin,"logtsallis_kappa",.0001,20,wts)  ;
      
       betf = th0*pk(1)  ;
       qf = q0; 

   endif


endfunction  
