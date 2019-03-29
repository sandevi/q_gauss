
function [c] = ks2mumain(x, col, mom, qprm, r1, r2, fac0) 


      sz = size(qprm); lmle = sz(1)  ;


      clear pw; clear ksw; clear dw; clear crtdsm ; clear pval;
      clear pwp; clear kswp; clear dwp;  clear crtdsp ;

     
      q = qprm(1, 2);  sig1 = mom(1,2)  ;

       clear c;  clear delay ; clear muq ; clear bet;

       for iw = 1: lmle
	       
	  delay = qprm(iw,1)  ;
	  muq = qprm(iw,4)  ;
          bet = qprm(iw,3)  ;


	  clear lrx0; clear lrx; 
          [lrx0 momw] = percent_return(x, delay, 8, r1, r2, 0,0,1,0)  ;
          lrx = lrx0 * momw(2) / sig1 ;
	    
            nw = length(lrx)  ;	   


	   [xd hd hm xdp hdp hmp] = ks2_histmu(lrx, q, bet, muq, sig1, nw,  fac0);   

         ln = length(xd) ; lqn = ln ;
         cd1 = (ln + lqn) / (ln*lqn)  ;
         crtdsm(iw) = 1.36*sqrt(cd1) ;

	clear pval; clear ks; clear d;
	[pval, ks, d] = ks2test(hd, hm,"<>") ;

         pw(iw) = pval; ksw(iw) = ks; dw(iw) = d;

##  compute ks stistic for +ve side

         lp = length(xdp) ; lqp = lp ;
         cd2 = (lp + lqp) / (lp*lqp)  ;
         crtdsp(iw) = 1.36*sqrt(cd2) ;

	clear pval; clear ks; clear d;
	[pval, ks, d] = ks2test(hdp, hmp,"<>") ;

         pwp(iw) = pval; kswp(iw) = ks; dwp(iw) = d;

	 c{iw,1} = [crtdsm(iw)  dw(iw) crtdsp(iw) dwp(iw)]  ;
      endfor

endfunction
