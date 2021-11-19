%Assignment 7.2
%analytically calculated expectation value 
func =@(x) ((exp(-((x-3).^2)./2) + exp(-((x-6).^2)./2)));
result = integral(func, -Inf, Inf);
fprintf("Solving the function analytically by limits of infinity the result is: %.4f\n", result);
result2 = integral(func, 0, 1);
fprintf("Solving the function analytically by limits of 0 to 1 the result is: %.4f\n", result2);
 %expectation value by Monte Carlo Method
 xval = zeros(1, 100);%creating array for x
 for i = 1:N
     xval(i) = rand; %intial x values
 end 
 %finding the sum 
 fx = zeros(1,N);%creating array for f(x)
 func =@(x) (exp(-((x-3).^2)./2) + exp(-((x-6).^2)./2));
 sum = 0;
 for i = 1:N
     fx(i) = func(xval(i)); %evaluating function at x
     sums = sums + fx(i);
     ; %adding sum
 end 
 sum = sum./N;
error  = abs(result2 - sum);%error evaluation 
fprintf("The Expected Value using the Mean-Square Monte Carlo is %.4f with a error of %.4f\n" , sum, error);