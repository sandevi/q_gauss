## Copyright (C) 2018 sandh
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## this function aligns the the reference data with the given starting date.
##

## Author: sandh <sandh@DESKTOP-J16R45C>
## Created: 2018-01-06

function [r1 r2 flgx] = data_startend_samplenum(refd, ind_start, ind_end)
##
##
    clear r1; clear r2 ; flgx = 0 ;
    
## find the sample number for start and end date given

    
## Find the starting sample no. corresponding to the start date given 

    clear dif1 ; clear dsum1; clear id1;

    
    dif1 = ind_start .- [ refd(:,1), refd(:,2),refd(:,3) ]  ;
    dsum1 = sum(abs(dif1),2) ;
    id1 = find(dsum1 == 0);

    if(length(id1) == 0)
      flgx = -1 ;
      r1 = 0 ;
      printf('No matchig date in stock data for the starting date provided \n') ;
      return
    endif     
   
    r1 = id1 ;

## Find the starting sample no. corresponding to the end date given 

    clear dif2 ; clear dsum2; clear id2;

    
    dif2 = ind_end .- [ refd(:,1), refd(:,2),refd(:,3) ]  ;
    dsum2 = sum(abs(dif2),2) ;
    id2 = find(dsum2 == 0);

    if(length(id2) == 0)
      flgx = -1 ;
      r2 = 0 ;
      printf('No matchig date in stock data for the end date provided \n') ;
      return
    endif     
   
    r2 = id2 ;


endfunction
