
%Assignment 4.1        
t=1; %total time
n=10000; %number of data points
dt=t/n;%time step size
dz=sqrt(dt)*randn(1, n);%increments
dx=0.4*dt+1.8*dz;%cumalitive sum
x=cumsum(dx);
figure(1)
plot([0:dt:t],[0,x]); %x againest t
%changing x from 1x10000 to 10000x1
xx = [0,x].'; %transpose
%Kernel Distribution
pd = fitdist(xx, 'Kernel', 'Bandwidth', 2);
y = -4:dt:4;
yKernel = pdf(pd, x);
figure(2)
plot(x, yKernel); %plots kernel 
fprintf("The mean is %f\n", mean(xx)); %prints mean
%chebyshev inequality 
fprintf("P(X >= 0.1): %f\n", probability(0.1, t, n)); %returns probability of values greater than x
fprintf("< E > / x: %f\n", mean(xx)/0.1) %prints the mean / x
%obtains the probability of values being greater than the start
function prob = probability(start, stop, n)
    step = (stop - start)/(n-1); %size of the step
    rec = linspace(start, stop, n);
    values = exp(lognpdf(rec));%pdf value of each x
    prob = sum(values * step);%integral of pdf
    
end
