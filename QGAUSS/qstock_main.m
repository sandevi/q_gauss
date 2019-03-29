## Copyright (C) 2017 sandhya Devi
##


## This pgm  estimates the parameters of a q-gaussian distribution, q, beta
## and mu using MLE method
## References
## 1.  Financial Market Dynamics: Superdiffusive or not? Sandhya Devi
## Journal Of Statistical Mechanics Theory and Experiment 2017(8)
## DOI: 10.1088/1742-5468/aa8199
## 2.  Financial Portfolios based on Tsallis Relative Entropy as the 
##   arXiv:1901.04945 
##
## Input:
##
## file_name: Name of the file containing stock data(preferably daily data)
## in .csv format
## ex: file_name = '/full path/name.csv'
## The data should have a header followed by data
##
## ex:
## date  open  High  Low  Close  Adj_close  Volume
## 1/4/1995 459.209991	459.269989	457.200012	459.109985	459.109985	262450000
## The date is treated as having 3 columns. The data columns are 4 -9
## Any of the data columns 4-8 can be used for the analysis. Default(preferred)
## is 8  since it is adjusted for dividend and splits.
## Also the data should not have 'null' characters in it.
##
## col: column of the data to be used
##
## [mm1, dd1, yr1] and [mm2, dd2, yr2] are the dates for data range to choose
## for parameter estimation and analysis. Make sure that there are at least
## 1000 samples between the initial and final dates. More the better for the
## estimation of parameters. 
##
## d_days: interval in time delays (in days) to compute parameter(default = 1)
## n_days: total no. of time delays in days, (default = 10).
## ex: if d_days = 2, n_days = 60, the parameters are computed for
## 2, 4, 6-----120 day time delays
##
## ql, qh , btl, bth, mul are the nitial values for q, beta and mu to start
## optimization 
##
## niter: no. of iterations for parameter estimate algorithm (mle)
##
## opt_kptheta: option to estimate beta, mu only for all delays (=0), or
## estimate q, beta and mu for all delays(=1). Default = 0 For this option q is
## estimated only for 1 day return and kept constant for all other delays. This
## is thereccomended option.
##
##
## Output:
## cmom: cell array containing first four moments of the returns for all delays
## It is an n x 4 matrix, n = no. of delays 
## cmom(columns) = [ mean std. devn, skew, kurtosis]
##
## qparm: cell array containing the Tsallis parameters.
## for all delays. n x m matrix, n = no. of delays, 
##  m = delay value + no. of parameters.
## qparm (columns) = [delay  q beta mu ]
##
## fisher_err: cell array theoretical and measured fisher errors in the
##  Tsallis parameter estimates
## fisher_err = estimatespcyfierqm erbm ermum erqe erbe ermue]
##
## ks:  cell array containing results of  Kolmogorov-Smirnov test (KS test) 
## ks = [Dcritical Dmodel (-ve returns) Dcritical Dmodel (+ve returns)
##
##
## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 3-19-2019
##
##
##

function [ cmom qparm fisher_err ks] = qstock_main(file_name,  col=8, mm1, dd1, yr1, mm2, dd2, yr2, d_days=1, n_days=10,  ql=1.2, qh=1.66, btl=.5, bth=1.5, mul = -.0005, niter=8,  opt_kptheta=0)

##
##
    clear cmom; clear cparm;  
    flgx = 0 ;

##  Read  stock data

    clear a; clear fid;
    fid = fopen(file_name,"rt")  ;

##  Open file for output


    a = textscan(fid, '%d/%d/%d, %f %f %f %f %f %f', 'Delimiter',',', 'CollectOutput',1, 'HeaderLines',1);

    fclose(fid);

    clear mt; clear md;  

     mt = a{1} ;
     md = a{2}  ;
     
    
    ref_dat = zeros(length(mt),9) ;
    ref_dat(:,1:3) = mt;
    ref_dat(:,4:9) = md ; 

    clear refd;
##  Remove NaNs and zero returns from the data 
	 sd = 2.2077e-310  ;
	 [refd] = data_process_qs(ref_dat, col, sd)  ;

## check if the data starts before or at the initial date given.
 
        ind_start =  [ mm1  dd1 yr1]  ;

	check_dat = julian(refd(1,3),refd(1,1),refd(1,2));
        check_start = julian(yr1,mm1,dd1)  ;

        if(check_dat > check_start)
	  printf(" Error! The date at which the data starts is later than the mm1 dd1 yr1 given \n")
          flgx = -1  ;
	  return
        endif

	ind_end = [ mm2 dd2 yr2]  ;

## Find the sample numbers corresponding to beginning and end date provided. 

	clear r1; clear r2;

	[r1 r2 flgx] = data_startend_samplenum(refd, ind_start, ind_end)  ;

	if(flgx < 0 )
          printf(" Check if the start and\or end date is in the data \n");
	  return
        endif

##     Estimate q-gauss parameters

 [cmom cparm]  = qgauss_prmest(refd, col,  r1, r2, d_days, n_days,  ql, qh, btl, bth, mul , niter,  opt_kptheta) ;

       clear aprm; clear prm1; clear errprm;

## Put the parameter values and error diagnostics in seperate cells       

       aprm = cell2mat(cparm)  ;
       prm1(:,1) = aprm(:,1) ;
       prm1(:,2) = aprm(:,5) ;
       prm1(:,3) = aprm(:,6) ;
       prm1(:,4) = aprm(:,4) ;

       sz = size(aprm); lprm = sz(1)  ;

       clear qparm;
       qparm = mat2cell(prm1, lprm, 4)  ;
##
       clear errprm;
       errprm(:,1) = aprm(:,7) ;
       errprm(:,2) = aprm(:,10) ;
       errprm(:,3) = aprm(:,8)  ;
       errprm(:,4) = aprm(:,11)  ;
       errprm(:,5) = aprm(:,9)  ;
       errprm(:,6) = aprm(:,12) ;

       clear fisher_err;
       fisher_err = mat2cell(errprm, lprm, 6);
##
##  Kolmogorov-Smirnov test (KS test) 
##
    clear mom; mom = cell2mat(cmom) ;
    [ks] = ks2mumain(refd, col, mom, prm1, r1, r2, .1) ; 
        
endfunction
