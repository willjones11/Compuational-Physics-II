lambda = 12;
nPeriods = 500;
dt = 0.1;   %time steps
T = nPeriods*dt;
t = 0:dt:T;
rng('default')
k=randi([1,10],1,nPeriods);
f = (lambda.^k).*exp(-lambda)./factorial(k); % Poission Dist. 
Nd = cumsum(f);
N = [ 0 Nd(1:end) ]; % N(0)=0.
stairs(t,N)