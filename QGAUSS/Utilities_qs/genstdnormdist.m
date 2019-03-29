##Copyright (C) 2012 Sandhya
## 
## This program generates a set of random samples which have gaussian distribution
## with mean 0 and std dev 1; 

##  The samples are in the range a - b (input) 
##  opt is the option to normalise the histogram
##  1 = normalise, 0 = no norm
##  n = no. of samples to be generated.
##  a-b is the range of the values of samples
##  nb is the no. of bins for the histogram   
 

## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 2012-11-01

function [ hsg ng] = genstdnormdist( nr, a, b, nb, opt)

#  subtract the mean and std dev from x

   clear hs;
   clear xs ;
   
     
   mn = a;
   mx = b ;
   

   clear gs;    
   gs = stdnormal_rnd (nr,1) ;
   
   clear gsab;
   for i = 1:nr;
       gsab(i) = (mx-mn)*gs(i) + mn;
   end;
   
 if (opt == 1)
   [hsg ng] = hist(gsab,nb,opt);
 else
    [hsg ng] = hist(gsab,nb) ;
 endif  
   
