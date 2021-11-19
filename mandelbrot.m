%{
Computational Physics II
William Jones
Final Project Used the Monte Carlo Method to find the Area of the Mandlebrot Set
%}
%monte carlo 
trueArea = 1.507;%True Approximate Area of the Mandelbrot
points = 100000; %number of data points
areas = zeros(9, 1);%setting array for changing iteration limit mc
iterc = zeros(9, 1);%setting array for iteration limit
%getting different iteration limits
for i = 1:9
    nIter = 15 *i;%iteration limit
    %iterc(i) = nIter;%storing limit
    %areas(i) = mc(points, nIter);%calculating the Area from MC
end
%plot for Mandelbrot
mandelbrott(points, 100);
%plotting MC for changing iteration limit
figure(9)
%plot(iterc, areas);
title('MC Area from Limit Change')
xlabel('Iteration Max')
ylabel('Area')
areapc = zeros(9, 1);%setting array for point change monte carlo area
pointpc = zeros(9, 1);%setting array for points
for i =1:9
    %pchange = 4^i;%points 
    %pointpc(i) = pchange;%storing value of poinnts into array
    %areapc(i) = mc(pchange, 100);%storing MC area result into array
end
%plotting the MC from Point Change
figure(10)
%plot(pointpc, areapc)
title('MC from Changing Data Points')
xlabel('# points')
ylabel('Area')
%errorN = abs((areas - trueArea)./trueArea)*100;%percent error calc for MC limit change
%errorP = abs((areapc - trueArea)./trueArea)*100;%percent error calc for MC point change
%plot for error of limit change
figure(11)
%plot(iterc, errorN)
title('Error of Iteration Limit Change Monte Carlo')
xlabel('Iteration Limit')
ylabel('% error')
%plot for error of point change
figure(12)
%plot(pointpc, errorP)
title('Error of Point Change Monte Carlo')
xlabel('# of Points')
ylabel('% error');

%function for mandelbrot plotting 
function mandelbrott(points, N)
    step = 4/(points./2);%step size
    r = zeros(points/2,1);% set array for real points
    im = zeros(points/2, 1);%set array for imaginary points
    manr = NaN(points, 1);%set array for real points in Set
    mani = NaN(points,1);%set array for imaginary points in Set
    indexm = 1;%index value for in Set                         
    outr = NaN(points, 1);%set array for real points outside set
    outi = NaN(points, 1);%set array for imaginary points outside set
    indexo = 1;%index value for out set
    %getting points for graph in [-2, 2]
    for i = 1:(points/2)
       im(i) = -2 + i*step;%imaginary
       r(i) = -2 + i*step;%real 
    end 
    %Mandelbrot iterative formula
    for j = 1:(points/2)%real movement 
        for k = 1:(points/2)%imag movement 
            z = 0;%starting z
            i = 1;% iterative starting value
            c = complex(r(j), im(k));%complex number 
            %iterative method
            while (abs(z) < 2 && i < N)%as long as z is in [-2, 2] and under iteration limit
            z = z^2 + c;%formula
            i = i + 1;%increment
            end
            %if hitting iteration limit assume infinity and is in set
            if i == N
                manr(indexm) = real(c);%store real number
                mani(indexm) = imag(c);%store imag number
                indexm = indexm + 1;%increment 
            end 
            %No Limit met so point is outside set
            if i ~= N
                outr(indexo) = real(c);%store real number
                outi(indexo) = imag(c);%store imag number 
                indexo = indexo + 1;%increment 
            end 
            
        end
        disp(j)
    end 
    figure(1)
    scatter(manr, mani,[], 'blue', 'filled')%plotting the points in set
    hold on
    scatter(outr, outi,[], 'black', 'filled')%plotting points outide set
    hold off
    title('Mandelbrot')
    xlabel('Real')
    ylabel('Imaginary')
end
%Monte Carlo Hit Or Miss Method 
function area = mc(points, N)
    mandelbrotmc = NaN(points,N);%array set up for monte carlo mandelbrot
    r = -2 + (2+2) * rand(points, 1);%random real points
    im = -2 + (2+2) *rand(points, 1);%random imaginary points
    a = NaN(points, 1);%real array set up
    b = NaN(points, 1);%imaginary array set up
    count = 1;%count iter
    max = 0;
    %iterative Mandelbrot calculation
    for i = 1:points
        c = complex( r(i), im(i));%setting complex number
        mandelbrotmc(i,1) = 0;%storing value 
        k = 1;%iteration set
        mandelbrotmc(i, k) = 0;%storing intial z
        while( abs(mandelbrotmc(i, k)) < 2 && k < N)%run unitl outside bounds [-2,2] or Limit
            mandelbrotmc(i, k+1) = mandelbrotmc(i, k).^2 + c;%mandlebrot equation
            k = k + 1;%increment
            %Limit Hit( in Set)
            if k == N
                a(count) = real(mandelbrotmc(i, k));%store real value
                b(count) = imag(mandelbrotmc(i, k));%store imaginary value
                max = max + 1;%increment count
            end
            count = count +1;%tally of inset
        end 
        
    end 
    area = 16 * (max./points);%area calculation 
    %%%%%%%%%%FOR PLOTTING CHANGES%%%%%%%%%%%%%
    %for Limit change being 45
    if N == 45
        figure(2)
        for i = 1:points
            if ~isnan(a(i)) %making sure value contained 
                plot(a(i), b(i), '.')
            end
            title('Monte Carlo Mandelbrot 45 iteration limit')
            xlabel('real')
            ylabel('imaginary')
            hold on
            
        end 
        hold off
    end
    %for limit being 90
    if N == 90
        figure(3)
        for i = 1:points
            if ~isnan(a(i))  %making sure value contained 
                plot(a(i), b(i), '.')
            end
            hold on
             title('Monte Carlo Mandelbrot 90 iteration limit')
            xlabel('real')
            ylabel('imaginary')
            
        end 
        hold off
    end
    %for limit being 135
    if N == 135
        figure(4)
        for i = 1:points
            if ~isnan(a(i))  %making sure value contained 
                plot(a(i), b(i), '.')
            end
            title('Monte Carlo Mandelbrot 135 iteration limit')
            xlabel('real')
            ylabel('imaginary')
            hold on
            
        end 
        hold off 
    end
    %for point change of 64
    if points == 4^3
        figure(5)
        for i = 1:points
            if ~isnan(a(i))  %making sure value contained 
                plot(a(i), b(i), '.')
            end
            title('Monte Carlo Mandelbrot for Change in Points: 64')
            xlabel('real')
            ylabel('imaginary')
            hold on
           
        end
        hold off
    end 
    %for points change of 4096
    if points == 4^6
        figure(6)
        for i = 1:points
            if ~isnan(a(i))  %making sure value contained 
                plot(a(i), b(i), '.')
            end
            title('Monte Carlo Mandelbrot for Change in Points: 4096')
            xlabel('real')
            ylabel('imaginary')
            hold on
            
        end
        hold off
    end
    %for point change of 262144
     if points == 4^9
        figure(7)
        for i = 1:points
            if ~isnan(a(i))  %making sure value contained 
                plot(a(i), b(i), '.')
            end
            title('Monte Carlo Mandelbrot for Change in Points: 262144 ')
            xlabel('real')
            ylabel('imaginary')
            hold on
            
        end
        hold off
    end 
end
