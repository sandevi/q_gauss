## Copyright (C) 2017 sandh
## 
##
## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} data_align(@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Sandhya Devi <sandh@DESKTOP-J16R45C>
## Created: 2017-04-15
##
## This program aligns two stock data sets
## Input: Two stock data sets
##     The no. of columns in each data set are 9
##   month day year open high low close volume  adj.close
## Output: The two adjusted data sets
##
##
function [dat1_out dat2_out] = data_align( dat1, dat20)


clear dat1_out ; clear dat2_out

## cut the portion of dat2 < the beginning  year of dat1

clear dat2; clear idx;

idx = find(dat20(:,1) >= dat1(1,1)) ;
dat2 = dat20(idx,:) ;

##
## Convert 1st Date to Julian daysalign
##
ind1l =  julian( dat1(1,1), dat1(1,2),dat1(1,3) )  ;
ind2l =  julian( dat2(1,1), dat2(1,2),dat2(1,3) )  ;

l1 = length(dat1) ;
l2 = length(dat2) ;


##
## align the first rows of 2 data 
#

clear dat1l; clear dat2l;
clear dat1h; clear dat2h;


dat1l = dat1  ; 
dat2l = dat2  ;

dat1h = dat1l;
dat2h = dat2l;


##if(ind1l < ind2l)
##	clear dat1l;  clear indl;
	
##	indl = ind1l;
##	k=1 ;
##	while indl < ind2l
##	   indl =  julian( dat1(k,1), dat1(k,2),dat1(k,3) )  ; 
##	    k++ ;
##	endwhile	
	
##	dat1l = dat1(k-1:l1,:)  ;	

if(ind1l > ind2l)
      clear dat2l;  clear indl;
	
	  indl = ind2l;
	k=1 ;
	while indl < ind1l
	   indl =  julian( dat2(k,1), dat2(k,2),dat2(k,3) )  ; 
	    k++ ;
	endwhile
	
	dat2l = dat2(k-1:l2,:)  ;

endif

  len = min(length(dat1l), length(dat2l)) ;
  
  dat1_out = dat1l(1:len,:) ;
  dat2_out = dat2l(1:len,:) ;

	   
endfunction
