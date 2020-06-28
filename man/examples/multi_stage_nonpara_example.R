library(HDChangePoint)
# How to Generate Simulated Data using mydata() #
n=80; model="logist"; p=2; bb0=0.5;bb=0.1; x.sd=0.3; v1=8; v2=10;
dist="normal"; eps.sd=0.05;u.sd=0.05;

## Specify parameters for the multi-stage nonparametric procedure
num.interp=45;newl=45; k1=20; k2=20; tolerance=0.009; iter=0; time.length=20;

set.seed(22)
## Data generation under the logistic model
outdat<-mydata(n=n, model=model, p=p, bb0=bb0, bb=bb, x.sd=x.sd,
dist=dist,v1=v1, v2=v2, eps.sd=eps.sd, u.sd=u.sd) #

## Multi-stage nonparametric estimation
results<-sim.nonpara(n=n, model=model, dist=dist, k1=k1, k2=k2,
num.interp=num.interp, newl=newl, eps.sd=eps.sd, mean.diff=1, tolerance=tolerance,
itermax=50, iter=iter, time.length=time.length, dat=outdat)

