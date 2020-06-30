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

## generate data with seed number
set.seed(22)
outdat<-mydata(n=n, model=model, p=p, bb0=bb0, bb=bb, x.sd=x.sd,
v1=v1, v2=v2, dist=dist, eps.sd=eps.sd, u.sd=u.sd)

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
