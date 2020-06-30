HDChangePoint
================

<!-- README.md is generated from README.Rmd. Please edit that file -->
Overview
--------

The R package `HDChangePoint` implements two estimation methods using the parametric nonlinear mixed effects model (NLME) and the multi-stage nonparametric approaches, which are described in the following manuscript:

\*\*U.Lee, R.J.Carroll, K.Marder, Y.wang and T.P.Garcia. (2020) "Estimating Disease Onset from Change Points of Markers Measured with Error", Biostatistics, kxz068, <https://doi.org/10.1093/biostatistics/kxz068**>

Those two methods estimate individual longitudinal trajectories in an "S"-shape and their respective inflection points.

Installation
------------

To install `HDChangePoint` from GitHub,

``` r
devtools::install_github("unkyunglee/HDChangePoint")
```

Usage
-----

``` r

# Example for the Multi-Stage Nonparametric estimation
library(HDChangePoint)
# Specify parameters for data generation
n=80;
model="logist";
p=2;
bb0=0.5;
bb=0.1;
x.sd=0.3;
v1=5;
v2=7;
dist="normal";
eps.sd=0.05;
u.sd=0.05;

set.seed(22)
# Generate a dataset under the logistic model
outdat<-mydata(n=n, model=model, p=p, bb0=bb0, bb=bb, x.sd=x.sd, 
               v1=v1, v2=v2, dist=dist, eps.sd=eps.sd, u.sd=u.sd)


# Specify other parameters for the multi-stage nonparametric procedure
num.interp=45;
newl=45;
k1=20;
k2=20;
time.length=20;
mean.diff=1;
tolerance=0.009
iter=0;

# Multi-stage nonparametric estimation
results<-sim.nonpara(n=n, model="logist", dist="normal", k1=k1, k2=k2, num.interp=num.interp, 
                     newl=newl, eps.sd=eps.sd, mean.diff=1, tolerance=tolerance,
                     itermax=50, iter=iter, time.length=time.length, dat=outdat)

# Example for the parametric NLME estimation 
library(HDChangePoint)

## Specify parameters to generate true data
n=80;
model="arctan";
p=2;
bb0=2;
bb=0.1;
x.sd=0.3;
v1=5;
v2=7;
dist="normal";
eps.sd=0.05;
u.sd=0.05;

## generate data with a seed number
set.seed(22)
outdat<-mydata(n=n, model=model, p=p, bb0=bb0, bb=bb, x.sd=x.sd,
v1=v1, v2=v2, dist=dist, eps.sd=eps.sd, u.sd=u.sd)

## When NLME specifies the correct model
## Specify parameters for the parametric NLME procedure
num.boot=1000;
true.gam1=2.45/pi;
true.gam3=pi/1.1;
time.length=45;
eps.sd=0.05;
dist="normal";
para1=6.5;
para2=6.3;
para3=0;
para4=2.8;
para5=1.5;

## Do parametric NLME estimation
results<-main.arctan.nlme(n=n, model=model, dat=outdat, num.boot=num.boot, time.length=time.length,
true.gam1=true.gam1, true.gam3=true.gam3, para1=para1, para2=para2, para3=para3,
para4=para4, para5=para5, eps.sd=eps.sd, dist=dist)


# Example for the parametric NLME estimation 
library(HDChangePoint)

## Specify parameters to generate true data
n=80;
model="arctan";
p=2;
bb0=2;
bb=0.1;
x.sd=0.3;
v1=5;
v2=7;
dist="normal";
eps.sd=0.05;
u.sd=0.05;

## generate data with a seed number
set.seed(22)
outdat<-mydata(n=n, model=model, p=p, bb0=bb0, bb=bb, x.sd=x.sd,
v1=v1, v2=v2, dist=dist, eps.sd=eps.sd, u.sd=u.sd)

## When NLME specifies incorrect model
## Specify parameters for the parametric NLME procedure
num.boot=1000;
true.gam1=2.45/pi;
true.gam3=pi/1.1;
time.length=45;
eps.sd=0.05;
dist="normal";
para1=6.5;
para2=5.3;
para3=0;
para4=1;

## Do parametric NLME estimation
results<- main.logistic.missp.nlme(n=n, model=model, dat=outdat, num.boot=num.boot,
time.length=time.length, true.gam1=true.gam1, true.gam3=true.gam3, para1=para1,para2=para2,
para3=para3, para4=para4, eps.sd=eps.sd, dist=dist)
```

Example 2.
----------

We give an example to show reproducibility for data analysis study in our manuscript. We consider the `PSEUDO_PREDICT_HD` data available from R package `HDChangePoint`.

``` r
library(HDChangePoint)
data(PSEUDO_PREDICT_HD)
```

The data consist of 80 subjects' information with 8 variables. Each subject made different number of visits *m* = 5, 6 or 7 at clinics. In the `PSEUDO_PREDICT_HD` data, we consider two subject specific covariates: CAG repeats and gender, which may be associated with inflection points.

``` r
head(PSEUDO_PREDICT_HD)
#>   SUBJID event TOTAL_MOTOR_SCORE TRUE_INFL_POINT       AGE      CAG gender
#> 1      1     1        0.09839752        2.750496  8.298965 38.92753      0
#> 2      1     2        0.19024203        2.750496 13.147519 38.92753      0
#> 3      1     3        0.54985245        2.750496 16.249701 38.92753      0
#> 4      1     4        0.55897855        2.750496 16.879371 38.92753      0
#> 5      1     5        0.65459256        2.750496 17.004619 38.92753      0
#> 6      1     6        0.88050864        2.750496 20.820894 38.92753      0
#>     logAGE
#> 1 2.116131
#> 2 2.576233
#> 3 2.788074
#> 4 2.826092
#> 5 2.833485
#> 6 3.035957
?PSEUDO_PREDICT_HD # this gives you more information on the dataset
```

We fit our methods to the `PSEUDO_PREDICT_HD` data. First, we specify the parameters and run the function `hd.study()`.

``` r

# Specify the parameters
simu.dat<-PSEUDO_PREDICT_HD
n=80;
m=42;
num.interp=42;
newl=42;
mean.diff=1;
tolerance=0.01;
itermax=20;
iter=0;

# produce two tables to reproduce similar results as in Table 4 and Figure 1 of our manuscript
simu.analysis.results<-hd.study(simu.dat=simu.dat, m=m, num.interp=num.interp, 
                                n=n, newl=newl, mean.diff=mean.diff, 
                                tolerance=tolerance, itermax=itermax, iter=iter,     
                                boot.ci=TRUE)
```

We obtain the following results for the multi-stage nonparametric estimates and the parametric NLME estimates, similar to Table 4 in our manuscript. Figure will be automatically saved in your working directory, which is similar to Figure 1 in our manuscript.

``` r
# produce results
simu.analysis.results$nonpara_summary_table4 # multi-stage nonparametric estimates
#>             Estimate Std. Error t value Pr(>|t|)
#> beta0          2.904      0.033  88.651    0.000
#> beta_CAG       0.260      0.028   9.201    0.000
#> beta_gender   -0.003      0.062  -0.053    0.958
#> sigma_u        0.246         NA      NA       NA
#> sigma_eps      0.182         NA      NA       NA
simu.analysis.results$para_summary_table4    # parametric NLME estimates
#>             Value Std.Error  DF t-value p-value
#> theta1      5.919     0.159 382  37.136   0.000
#> theta2      0.977     0.014 382  68.144   0.000
#> beta0       2.996     0.007 382 454.626   0.000
#> beta_CAG    0.245     0.004 382  64.804   0.000
#> beta_gender 0.001     0.008 382   0.137   0.891
#> sigma_u     0.000        NA  NA      NA      NA
#> sigma_eps   0.057        NA  NA      NA      NA
```
