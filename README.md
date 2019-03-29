# QGAUSS: A Software to Estimate q-Gaussian distribution parameters using Maximum Likelihood Estimation(MLE) method
## Author/Developer:     Sandhya Devi     3/19/2019
### Reference: The algorithm is described in the publication
### Financial Market Dynamics: Superdiffusive or not?,  Sandhya Devi, Journal of Statistical Mechanics (2017) 083207
### http://dx.doi.org/10.1088/1742-5468/aa8199 (abstract can be found at this location).
### The paper can also be found in arXiv.org under the title given above. 
##  Contact: For questions and help in using this software sdevi@entropicdynamics.com

## The software is developed in OCTAVE (which is compatible with MATLAB). The executable can be downloaded from https://www.gnu.org/software/octave


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


## Mandatory Input Parameters 
### file_name: Name of the file containing stock data (preferably daily data) in .csv format
### ex: file_name = '/full path/name.csv'

### col:  column of the data to be used (default = 8)

### [mm1, dd1, yr1] and [mm2, dd2, yr2] are the dates for data range to choose  for parameter estimation and analysis. 
### Make sure that there are at least 1000 samples between the initial and final dates. More the better for the  estimation of parameters. 

### d_days: interval in time delays (in days) to compute parameter(default = 1)

### n_days: total no. of time delays in days, (default = 10).
### ex: if d_days = 2, n_days = 60, the parameters are computed for  2, 4, 6-----120 day time delays

## Rest of the input parameters ( Best is to use defaults)

#### ql, qh , btl, bth, mul are the initial values for q, beta and mu to start optimization (default: 1.2, 1.66, .5, 1.5, -.0005 respectively) 
#### niter: no. of iterations for parameter estimate algorithm ( default =8) 
#### opt_kptheta: option to estimate beta, mu only for all delays(0)   or estimate q, beta and mu for all delays(=1). Default = 0 For this option q is  estimated only for 1 day return and kept constant for all other delays. This is the reccomended option.

## Output: 

### cmom: cell array containing first four moments of the returns for all delays. It is an n x 4 matrix, n = no. of delays 
### [columns) = [ mean std. devn, skew, kurtosis]

### qparm: cell array containing the Tsallis parameters  for all delays. n x m matrix, n = no. of delays,  m = delay value + no. of parameters.
### qparm (columns) = [delay  q beta mu ]

### fisher_err: cell array of theoretical and measured fisher errors in the Tsallis parameter estimates
### fisher_err(columns) = [erqm errbm ermum erqe erbe ermue]

### ks:  cell array containing results of  Kolmogorov-Smirnov test (KS test) 
### ks(columns) = [Dcritical    Dmodel (-ve returns)   Dcritical   Dmodel (+ve returns)

### Kolmogorov-Smirnov test  is used to determine the  goodness of fit of the model with the data. 


  
