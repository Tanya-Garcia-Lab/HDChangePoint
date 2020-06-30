library(HDChangePoint)
## Specify parameters to generate true data
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

## generate data with seed number
set.seed(22)
outdat<-mydata(n=n, model=model, p=p, bb0=bb0, bb=bb, x.sd=x.sd,
               v1=v1, v2=v2, dist=dist, eps.sd=eps.sd, u.sd=u.sd)

## Specify parameters for the parametric NLME procedure
num.boot=1000;
true.theta1=6;
true.theta3=1;
time.length=20;
eps.sd=0.05;
dist="normal";
para1=2.5;
para2=3.5;
para3=0;
para4=3;
para5=1;

## Do parametric NLME estimation
results<-main.arctan.missp.nlme(n=n, model=model, dat=outdat, num.boot=num.boot,
time.length=time.length, true.theta1=true.theta1, true.theta3=true.theta3, para1=para1,
para2=para2, para3=para3, para4=para4, para5=para5, eps.sd=eps.sd, dist=dist)


