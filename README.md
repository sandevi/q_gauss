# QGAUSS: A Software to Estimate q-Gaussian distribution parameters using Maximum Likelihood Estimation(MLE) method
## Author/Developer:     Sandhya Devi     3/19/2019
### Reference: The algorithm is described in the publication
### Financial Market Dynamics: Superdiffusive or not?,  Sandhya Devi, Journal of Statistical Mechanics (2017) 083207
### http://dx.doi.org/10.1088/1742-5468/aa8199 (abstract can be found at this location).
### The paper can also be found in arXiv.org under the title given above. 
##  Contact: For questions and help in using this software sdevi@entropicdynamics.com


## Scope: 
### The q-Gaussia distribution can be used for a) Stock returns Analysis and b) Entropy estimation for possible use in the construction of Risk Optimal Portfolios


## Disclaimer

### This is a research Software. The software is tested only on stock index data
### This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.  see <http://www.gnu.org/licenses/>.

## Data 

### The data required to run this software is the stock/bond data in .csv format. It should have a header followed by data. 
###  ex:
### date     open   High   Low   Close   Adj_close   Volume
### 1/4/1995   459.209991	459.269989	457.200012	459.109985	459.109985	262450000
### The date is treated as having 3 columns. The data columns are 4 -9 Any of the data columns 4-8 can be used for the analysis. Default(preferred)  is 8  since it is adjusted for dividend and splits. Also the data should not have 'null' characters in it.

###

##	Usage of the Software

###  General Usage:
### [ mom  qparm  fisher_ err  ks] =   qstock_main( file_name,  col,  mm1,  dd1,  yr1,  mm2,  dd2, yr2,  d_days,  n_days,  ql,  qh,  btl,  bth,  mul ,  niter,  opt_kptheta)
### Minimal Usage:
### [ mom  qparm  fisher_ err  ks] =   qstock_main( file_name,  col,  mm1,  dd1,  yr1,  mm2,  dd2, yr2,  d_days,  n_days)


  
