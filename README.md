## Overview
The R package `HDChangePoint` implements two estimation methods using the parametric nonlinear mixed effects model (NLME) and the multi-stage nonparametric approaches, which are described in the following manuscript: 
  
  **U.Lee, R.J.Carroll, K.Marder, Y.wang and T.P.Garcia. (2020) "Estimating Disease Onset from Change Points of Markers Measured with Error", Biostatistics, kxz068, https://doi.org/10.1093/biostatistics/kxz068**
  
  Those two methods estimate individual longitudinal trajectories in an "S"-shape and their respective inflection points.


## Installation 

To install `HDChangePoint` from GitHub,
```{r, eval=FALSE}
devtools::install_github("unkyunglee/HDChangePoint")
```

## Usage
```{r usage, eval=F, message=FALSE}
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
results<-sim.nonpara(n=n, model="logist", dist="normal", k1=k1, k2=k2, num.interp=num.interp, newl=newl, eps.sd=eps.sd, mean.diff=1, tolerance=tolerance,
itermax=50, iter=iter, time.length=time.length, dat=outdat)

## Usage for paraNLME procedure
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

## Example 1. 

We give an example to show reproducibility for data analysis study in our manuscript. We consider the `PSEUDO_PREDICT_HD` data available from R package `HDChangePoint`. 

```{r pseudo_data, results='hide'}
library(HDChangePoint)
data(PSEUDO_PREDICT_HD)
```

The data consist of 80 subjects' information with 8 variables. Each subject made different number of visits $m=5,6$ or $7$ at clinics. In the `PSEUDO_PREDICT_HD` data, we consider two subject specific covariates: CAG repeats and gender, which may be associated with inflection points.

```{r data_info, message=FALSE}
head(PSEUDO_PREDICT_HD)
?PSEUDO_PREDICT_HD # this gives you more information on the dataset
```

We fit our methods to the `PSEUDO_PREDICT_HD` data. First, we specify the parameters and run the function `hd.study()`.
  
```{r pseudo_analysis, message=FALSE, results='hide'}
# Specify the parameters
simu.dat<-PSEUDO_PREDICT_HD;
subid="SUBJID";
event="event";
tms="TOTAL_MOTOR_SCORE";
cag="CAG";
age="AGE";
gender="gender";
trans.age="logAGE";
n=80;
m=40;
num.interp=40;
newl=40;
mean.diff=1;
tolerance=0.01;
itermax=20;
iter=0;

# produce two tables to reproduce similar results as in Table 4 and Figure 1 of our manuscript
simu.analysis.results<-hd.study(simu.data=simu.dat, subid="SUBJID", event="event", tms="TOTAL_MOTOR_SCORE", cag="CAG", age="AGE", gender="gender", trans.age="logAGE", m=m, num.interp=num.interp, 
n=n, newl=newl, mean.diff=mean.diff, tolerance=tolerance, itermax=itermax, iter=iter,     
boot.ci=TRUE)
```

We obtain the following results for the multi-stage nonparametric estimates and the parametric NLME estimates, similar to Table 4 in our manuscript. Figure will be automatically saved in your working directory, which is similar to Figure 1 in our manuscript.

```{r analysis_results}
# produce results
simu.analysis.results$nonpara_summary_table4 # multi-stage nonparametric estimates
simu.analysis.results$para_summary_table4    # parametric NLME estimates
```
