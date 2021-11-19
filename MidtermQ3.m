
%Mean by Monte Carlo Method
N = 1000;
 %finding the sum 
 fx = zeros(10,N);%creating array for f(x)
 func =@(x) ((cos(x).^2).*exp(-(x-3).^4)+(sin(x).^2).*exp(-(x-6).^2));

 y = zeros(10, N);
 for j = 1:10

    y(j,:) = lognrnd( 2, sqrt(2), 1000, 1);
    
    y(j, :) = sort(y(j,:));
    sum = 0;
    for i = 1:N
         fx(j, i) = func(y(i)); %evaluating function at x
         sum = sum + fx(j,i); %adding sum
    end
 end
 figure (1)
 for j = 1:10
     plot(0:1:N-1, fx(j,:));
 hold on
 end
 hold off
 sum = sum*((y(N)-y(1))./N);
 fprintf("The mean by Monte Carlo is %.30f\n", sum);
%simpsons 1/3 rule 
sr = zeros(1,N);
h =@(x) ((y(1,1000) - y(1,1))./(x-1));
sums = 0;
for i = 1:N
    if i == 1 || i == N
        sums = sums + func(y(i));
        sr(i) = sums*h(i)./3;
        continue
    elseif (i ~= 1) && mod(i,2) == 0
         sums = sums + 4*func(y(i));
         sr(i) = sums*h(i)./3;
         continue 
    elseif(i~= 1) && mod(i,2) == 1
        sums = sums + 2*func(y(i));
        sr(i) = sums*h(i)./3;
        continue 
    end  
end

plot(0:1:N-1, sr);
sums = sums.*(h(N)./3);
fprintf("The Sum of the Simpsons 1/3 Rule is %.30f\n", sums);

error  = abs(sum-sums)./sums *100;
disp(error)