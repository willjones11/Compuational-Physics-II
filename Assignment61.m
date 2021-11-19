%{
Computational Physics II
William Jones 
Modeling the stochastic differential equation of a random walk of a particle dpt = (L(pt)dt + (2pt - pt^2)dWt
where Wt is the Wiener Process, pt is the quantum trajectory as a function of time, and L(pt) = (3tsin(t))pt
%}
%Wiener Process        
t=5; %total time
n=100; %number of data points
dt=t/n;%time step size
dz=sqrt(dt)*randn(1, n);%increments
dx=0.2*dt+1.7*dz;%wiener 


Y = zeros(n+1, 1);%setting the array
time= zeros(n+1, 1);%setting time array
for i = 2:n+1
    time(i) = time(i-1) + dt;%creating time array
end%Wiener Process        
t=5; %total time
n=100; %number of data points
dt=t/n;%time step size
dz=sqrt(dt)*randn(1, n);%increments
dx=0.2*dt+1.7*dz;%wiener 

Y(1) = 2;%intial value
for i= 2:n
   Y(i+1) = Y(i) + (3+sin(time(i))*(dt)+(2*Y(i)-Y(i)^2))*(sqrt(dt))*dx(i);%discrete form of the equation using eulers method
end
plot(time, Y);%plotting the formula
xlabel('t(s)');
ylabel('Y');
title('Assignment 6.1');
