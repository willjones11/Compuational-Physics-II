%{
Compuational Physics II
William Jones
Developing Linear Congruential random number generator for fair and weighted die. Also comparing these random number generator to the matlab package.

%Assignment 2.1
%Park-Miller Parameters
pa = 7^5;
pc = 0;
pm = (2^31)-1;
%getting the sum of the rolls
sums = lcg(1000, pa, pc, pm, 2) + weightedlcg(1000, pa, pc, pm, 4);
%printing the variance
fprintf("The variance is %f\n", variance(sums));
%printing the mean
fprintf("The mean is %f\n", means(sums));
%printing the skewness 
fprintf("The skewness is %f\n", skewness(sums));
%printing the kurtosis
fprintf("The kutosis is %f\n", kurtosis(sums));
%printing the number of 6-6 combinations
fprintf("The number of 6-6 combinations are %d\n\n", sixsix(sums));
%creating the pdf
figure(1)
[p, x] = hist(sums);
plot(x, p/sum(p));
ylabel("probabilty %");
title("PDF");
%for covariance


%Assignment 2.2
%Fair Dice numbers
fr2 = zeros(1, 1000);
for i = 1:1000
   fr2(i) = randi(6);
end
%Weighted Dice
wr2 = zeros(1, 1000);
v = 1:6;
for i = 1:1000
    W = [0.15, 0.15, 0.15, 0.15, 0.15, 0.25]; 
    wr2(i) = randsample(v, 1,true, W);
end
sums2 = fr2 + wr2;
var2 = variance(sums2);
mean2 = means(sums2);
fprintf("The mean for the package is %f\n", mean2);
fprintf("The variance for the package is %f\n", var2);
fprintf("The skewness for the package is %f\n", skewness(sums2));
fprintf("The kutosis for the package is %f\n", kurtosis(sums2));
%creating the pdf for the packages
figure(2)
[p2, x2] = hist(sums2);
plot(x2, p2/sum(p2));
ylabel("probability");
title("PACKAGE PDF");
%covariance
fprintf("The covariance is %f\n", covariance(sums, sums2));
%moments
fprintf("Comparing the 2nd order moments of both the package has a moment of %f and the hand calculated one is %f\n", moments(sums2), moments(sums));
%printing the number of 6-6 combos
fprintf("The number of 6-6 combinations for the package are %d\n", sixsix(sums2)); 





%Linear Congruential Generator for Fair Dice
function r = lcg(n, a, c, m, s)
    %creating array     
    r = zeros(1, n);
    %performing the lcg formula
    %intial seed
    r(1) = s;
    for i = 2:n
        %getting the new seed value
        seed = r(i-1)^3 / 18.42 + 1;
        r(i) = mod(a*seed+c, m);
        
    end 
   %turning each number to a percentage 
   r= r./m; 
   %creating the 6 possible outcomes then rounding up giving whole numbers
   %and only those 1 to 6
   r = ceil(r*6);
end
%Linear Congruential Generator for Weighted Dice
function wr = weightedlcg(n, a, c ,m, s)
    %creating the array       
    wr = zeros(1, n);
    %initial seed
    wr(1) = s;
    %performing the formula
    for i = 2:n
        %getting new seed value
        seed = wr(i-1)^3 / 18.42 + 1;
        wr(i) = mod(a*seed + c, m);
    end 
    %creating every number to a percentage
    wr = wr./m;
    %expanding the number range to 20 and rounding up giving only numbers 1
    %to 20
    wr = ceil(wr*20);
    %bin system to create the dice to create the weights
    for i = 1:n
        %15 percent chance to get 1 so numbers 1 to 3
        if 1<=wr(i) && wr(i)<=3
            wr(i) = 1;
        %15 percent chance to get 2 so 4 to 6    
        elseif 4<=wr(i) && wr(i)<=6
            wr(i) = 2;
        %15 percent chance to get 3 so 7 to 9    
        elseif 7<=wr(i) && wr(i)<=9
            wr(i) = 3;
        %15 percent chance to get 4 so 10 to 12    
        elseif 10<=wr(i) && wr(i)<=12
            wr(i) = 4;
        %15 percent chance to get 5 so 13 to 15    
        elseif 13<=wr(i) && wr(i)<=15
            wr(i) = 5;
        %25 percent chance to get 6 so 16 to 20    
        else 
            wr(i) = 6;
        end
    end 
   
end            
%Variance Function
function var = variance(sums)
    %setting the variable
    sumsq = 0;
    %getting the sum squared
    for i = 1:1000
        sumsq = sumsq + sums(i)^2;
    end 
    %variance
    var = (sumsq - 1000*means(sums)^2)./999;
end 
%Mean function
function mean = means(x)
    %getting expected value for the fair dice
    mean = 0;
    for i = 2:12
        mean = mean + i *probs(x, i);
    end 
    
end 
%Covariance Formula
function co = covariance(x , y)
sum = 0 ;
%getting the mean
meanx = means(x);
meany = means(y);
%formula
for i = 1:1000
    sum = sum + (x(i) - meanx) *(y(i) - meany);
end 
    %dividing by n-1
    co = sum./999;
end 
%Six by Six combinations
function  tw = sixsix(x)
    count = 0;
    %for each sum checks to see if it equals 12 and adds 1 to the count
    for i = 1:1000
        if x(i) == 12
          count = count + 1;
        end
    end 
    tw = count;
end
%moments formula for 2nd order
function mom = moments(x)
 mom = variance(x);
end
%getting the probabilities for each combination
function prob = probs(x, num)
    count = 0;
    %counts the number of times the number appears in the data set
    for i = 1:1000
        if x(i) == num
          %adds one to the count if number appears  
          count = count + 1;
        end
    end 
    %getting the probability 
    prob = count/ 1000;
end 
