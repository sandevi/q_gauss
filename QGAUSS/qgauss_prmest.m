##Created by Sandhya Devi
## 3-19-2019
##
## This function estimates the parameters of q-gaussian distribution, q, beta
## and mu using MLE method
## 
function [cmom cparm]  = qgauss_prmest(x, col, r1, r2, d_wks, n_wks,  ql, qh, btl, bth, mul, niter,  opt_kptheta)


    clear kapt;  clear thetat; clear mut; clear qent; clear shnent ;
    clear betat; clear qt;

	 
      clear lrx; clear lrst; clear mom1;
		 
	 [lrx mom1] = percent_return(x,1,col,r1,r2, 0, 0, 0, 0)    ;

##  cut of  the highest .1 percentile of data (outlier?)

	 clear thresh; 
	 thresh = prctile(abs(lrx),99.9,1) ;
         lrst = lrx(abs(lrx) <= thresh)  ; 
		 
## cut of the lowest 5 percentile of the data for kappa estimation(noise) 
## and lowest 25 percentile for q estimation

	 clear thresh_th; clear thresh_kp;

	 thresh_th = prctile(abs(lrst), 20,1)  ;
         thresh_kp = prctile(abs(lrst), 5,1)  ;
	 
## compute the lower and upper limits o theta and kappa

         thh = (qh - 1)  ;
	 kpl = thh*bth  ;
	   

	 
	 [thetat kapt mut ] = estkpthmu_mle(lrst, mom1(1), mom1(2), thh, kpl, mul, niter)  ;


         if( thetat == 0 )
           printf(" estimated theta value is zero\n")  ;
           printf(" large q value!!!!\n")  ;
	   return
	 elseif( kapt == 0)
           printf(" estimated kappa value is zero\n")  ;
           printf(" large q and/or beta value!!!!\n")  ;
	   return
         endif

## Compute fisher measured and expected error

         [erqm erbm  ermum erqe erbe ermue] = est_mlerrqbmu(lrx, mut, thetat, kapt, mom1(2))  ;

	 
         qt =  (1 / thetat) + 1 ;
	 betat = kapt* thetat ;

	 
## store the output parameters in a cell array 	
   
	clear cmom; clear cparm; 


	cmom{1,1} = mom1;
	wks = 1;
	cparm{1,1} = [ wks thetat kapt mut qt betat  erqm erbm ermum erqe erbe ermue] ;
         	
##   compute moments and beta values for differrent time delays

        iw0 = 2 ; 
        if(d_wks > 1)
	  iw0 = 1;
        endif

	for iw = iw0 : n_wks;
	 
	 wks = iw*d_wks ; 
	 
	  clear xw; clear lrx;  clear mom ;

	 [xw mom] = percent_return(x,wks,col,r1,r2, 0 , 0, 0, 0)    ;

	lrx =  xw     ;

##  cut of  the highest .1 percentile of data (outlier?)

	 clear thresh; clear lrst;

	 thresh = prctile(abs(lrx),99.9,1) ;
         lrst = lrx(abs(lrx) <= thresh)  ;

## cut of the lowest 5 percentile of the data for kappa estimation(noise) 
## and lowest 20 percentile for q estimation

          clear thresh_th; clear thresh_kp;

	 thresh_th = prctile(abs(lrst), 20,1)  ;
         thresh_kp = prctile(abs(lrst), 20,1)  	 ;

	 cmom(iw+1,1) = mom;
     
	  clear kapt; clear qent; clear shent;  

##  Optionally estimte either boththeta and kappa or just kappa given q

     kptmn = bth / (thetat*wks); 
     mutmin = mul*wks ; 
     momt = mom(1) ;
     sig1 = mom1(2)  ;

      thresh_kpt = thresh_kp   ;
      thresh_tht = thresh_th   ;

     

      clear mut ; 
      
      if(opt_kptheta == 0)
          
	 [kapt mut flg] = kappamuestonly(lrst, momt, sig1, thetat, kptmn, mutmin, niter)  ;



## Compute Fisher erros for beta only

## scale kapt

          kapt_scl = kapt/((mom1(2))^2) ;
         [erbm erbe ermum ermue] = est_mlerrbmuonly(lrx, mut, thetat, kapt_scl )  ;
	 erbm = erbm*((mom1(2))^2)  ; 
	 erbe = erbe*(((mom1(2))^2))  ;


      else


	 [thetat kapt mut ] = estkpthmu_mle(lrst, momt, sig1, thetat, kptmn, mutmin, niter) ;  

## Compute fisher measured and expected error


    [erqm erbm  ermum erqe erbe ermue] = est_mlerrqbmu(lrx, mut, thetat, kapt, mom1(2))  ;

      endif

         if( thetat == 0 )
           printf(" estimated theta value is zero for iw = %f \n",iw)  ;
           printf(" large q value!!!!\n")  ;
	   return
	 elseif( kapt == 0)
           printf(" estimated kappa value is zero for iw = %f \n",iw)  ;
           printf(" large q and/or beta value!!!!\n")  ;
	   return
         endif

         qt =  1 / thetat + 1 ;

	 betat = kapt*thetat ;

	 
	 cparm{iw+1,1} = [wks thetat kapt mut qt betat  erqm erbm ermum erqe erbe ermue]  ;
	 
	endfor
	

	  
 endfunction
