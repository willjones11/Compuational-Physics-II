%{
Computaional Physics II
William Jones
Solving Ornstein-Ulenbeck of the stochastic differential equation
dXt = (theta1 - theta2Xt)dt + (theta3 - theta4Xt)dWt
given (θ1,θ2,θ3,θ4) = (5,3,7,1) and Xtis initially 70. and Wt is the Wiener Process
Also must meet conditions
A-solve the code using a numerical scheme
B- Find how long it takes to become a stationary process 
C-in the stationary part average Xt and find other data.
%}

%for Wiener Process       
t=5; %total time
n=100; %number of data points
dt=t/n;%time step size


time= zeros(n+1, 1);%setting time array
mulY = zeros(n+1, 10); %setting 10 different arrays
average = zeros(n+1, 1);%setting array for the mean
sd = zeros(n+1, 1); %setting array for standard deviation
for i = 2:n+1
    time(i) = time(i-1) + dt;%creating time array
end%Wiener Process      

theta = [5, 3, 7, 1]; %given theta values

%standard deviation is sqrt(2)
%mean is 2
for j = 1:10
    dz=sqrt(dt)*randn(1, n);%increments
    W=sqrt(2)*dt+2*dz;%wiener process
    mulY(1, j) = 70;%intial value
    for i= 1:n
        mulY(i+1, j) = mulY(i, j) + (theta(1)-theta(2)*mulY(i, j))*(dt)+(theta(3)-theta(4)*mulY(i, j))*(sqrt(dt))*W(i);%discrete form of the equation using eulers method
        
    end
end
%getting the mean and standard deviation 
for i = 1:n
    sum = 0; 
    for j = 1:10
        sum = sum + mulY(i, j);
       
    end
    average(i) = sum./10;
    sd(i) = sqrt(abs(average(i) - 2 to )^2);
end
figure(1)
for i = 1:10
    plot(time, mulY(:,i));%plotting the fo to  rmula
    hold on
end
hold off
xlabel('t(s)');
ylabel('Y');
title('Midterm Q2 Part A');
figure(2)
plot(time, average);
xlabel('time')
ylabel('mean')
title('Time vs. Mean')
figure(3)
plot(time, sd);
xlabel('time')
ylabel('standard deviation')
title('Time vs. Standard Deviation')

%For stationary process
begin = 0;
count = 0;
for i = 1:n+1
    if average(i) <= 2+sqrt(2) && average(i) >= 2-sqrt(2) && abs(sd(i)) <= sqrt(2)
        if count == 0
            begin = i;
            break;
        end 
        count = count+ 1;
        continue
    end 
    
end
fprintf(" It takes %.3f seconds for the the process to become stationary\n",  time(begin));
figure(4)
plot(time, average);
xlim([time(begin) (t-dt)])
xlabel('time')
ylabel('mean')
title('Stationary Process Mean')
figure(5)
plot(time, sd);
xlim([time(begin) (t-dt)])
xlabel('time')
ylabel('standard deviation')
title('Stationary Process Standard Deviaiton')
%for stationary process
%setting arrays
sptime = zeros(n - begin, 1);
spsd = zeros(n - begin, 1);
spaverage = zeros(n-begin, 1);
%creating stationary array
for i = 1:(n-begin)
    sptime(i) = time(begin + i);
    spsd(i) = sd(begin + i);
    spaverage(i) = average(begin + i);
end 
%finding the average for the Stationary process 
spsum = 0;
for i = 1:(n-begin)
    spsum = spsum + spaverage(i);
end
spmean = spsum./(n-begin);
%finding the standard deviaition for the stationary process
standd = 0;
for i = 1:(n-begin)
    standd = standd + (spaverage(i)-spmean).^2;
end
standd = standd./(n-begin);
standd = sqrt(standd);


fprintf("The Stationary Process Average for Xt is %.3f\n", spmean); %printing the sp mean 
fprintf("The Stationary Process Kurtosis is %.3f\n", kurtosis(spaverage));%printing the kurtosis
fprintf("The Stationary Process Skewness is %.3f\n", skewness(spaverage));%printing the skewness
fprintf("The Standard Deviation of the Stationary Process is %.3f\n", standd);%printing the standard deviation of the stationary process
    
