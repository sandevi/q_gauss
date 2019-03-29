##Copyright (C) 2012 Sandhya
## 
## This program computes Tsallis and Shannon entropies, given q  
## Input:
## x > data 
## q > Tsallis q parameter
## Output:
## qent > Tsallis Entropy
## shent > Shannon Entropy

## Author: Sandhya <Sandhya@SANDHYA-PC>
## Created: 05 -07-2014
##
##Copyright (C) 2012 Sandhya
## 
## This program computes Tsallis and Shannon entropies, given q  
## Input:
## x > data 
## q > Tsallis q parameter

function [ qent shent ]  = tsallis_entropy(x, fac = .5, q)

     clear qent; clear shent;

     
     [hs0 xs0  nb dx] = mypdf(x,fac,1)  ;

     id = (hs0 > 10e-9) ;     
     xs = xs0(id) ;
     hs = hs0(id) ;

     plogq = hs .* qlog( (1 ./ hs) , q) ;
     plogp = hs .* log(1 ./ hs)  ;


## Compute q-entropy

    qent = dx*sum(plogq) ;

## Compute Shannon Entropy   

    shent = dx*sum(plogp)  ;
	
endfunction
