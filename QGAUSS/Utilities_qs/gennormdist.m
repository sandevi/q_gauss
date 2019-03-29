##Copyright (C) 2012 Sandhya
## 
## This program generates a set of random samples which have gaussian distribution
## with mean avg and standard dev. std 

##  n = no. of samples to be generated.
##  a-b is the desired range of the values of samples
##  nb is the no. of bins for the histogram   
##  opth is the option to normalise histogram
##  opt=0> no normalisation, opt = 1 > normalise  
##  optn is the option to change the limits of the distribution values
## to the desired range a-b
##  opt=0> no limits change, opt = 1 > change  


## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 2012-11-01

function [ hs xs] = gennormdist( n, avg, std,dx)

#  subtract the mean and std dev from x

   clear hs;
   clear xs ;
   
     
   
   clear gs;    
   gs = normrnd(avg,std,n,1);

   nhg = (max(gs) - min(gs))/dx + 1 ;

   [hs xs] = hist(gs,nhg)  ;

   
 clear gs;
