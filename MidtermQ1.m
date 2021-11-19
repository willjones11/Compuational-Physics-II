
[average1, x1, y1, time] = randwalker1;%calling for part A
iterations1 = 1:length(average1);%number of iterations 
%plotting average distance vs. time 
figure(1)
plot3(average1, time, iterations1);
grid on;
xlabel('distance')
ylabel('time')
zlabel('iterations')
title('Part A')
%3d plot of the traveling particle
figure(3)
plot3(x1, y1, time);
xlabel('x')
ylabel('y')
zlabel('time')
title('Part A Particle Path')
grid on; 

[average2, x2, y2, time1] = randwalkerC;%for part C
iterations2 = 1:length(average2);% num of iterations
%plotting average vs time
figure(4)
plot3(average2, time1, iterations2);
xlabel('distance')
ylabel('time')
zlabel('iterations')
title('Part C')
grid on;
%plotting particles path
figure(5)
plot3(x2, y2, time1);
xlabel('x')
ylabel('y')
zlabel('time')
title('Part C Particle Path')
grid on;
%creating the pdf
[a, t] = meshgrid(average1, time);
X = [a(:) t(:)];
y = mvnpdf(X, [0], cov(average1, time));%bivariate pdf

y = reshape(y, length(time), length(average1));
%plotting pdf
figure(2)
surf(average1, time, y);%surface plotting 
caxis('auto');
xlabel('distance');
ylabel('time');
zlabel('%');

[average3, xwalk3, ywalk3, time3] = randwalkerD;%for part D
figure(6)
%plotting average with time
plot(average3, time3)
xlabel('distance')
ylabel('time')

title('Part D')
%plotting particles path
figure(7)
plot(xwalk3, ywalk3);
xlabel('x')
ylabel('y')
title('Part D Particle Path')
time3 = time3(~isnan(time3));
%the pdf of the random walker
figure(8)
[f, points] = ksdensity(time3);
plot(points, f)
xlabel('time')
ylabel('%')
title('PDF for Part D')




%function of the Single Random Walker
function [average, xwalk, ywalk, waittime] = randwalker1
    N = 200; %set number of iterations
    %creating the array
    xwalk = NaN(1, N);
    ywalk = NaN(1, N);
    average = NaN(1, N);
    waittime = NaN(1,N);
    %setting the intial position and time
    waittime(1) = 0;
    xwalk(1) = 0;
    ywalk(1) = 0;
    average(1) = 0;
    i = 1;
    while( waittime(i) < 200)
        i = i + 1;
        ynum = randi(100);% random number selection 
        
        ystep = stepsize(100, ynum);%y step size
        xnum = randi(100);%random number
        xstep = stepsize(100, xnum);%x step size
        timenum = randi(100);% random number
        time  = waitingTime(100, timenum);%waiting time
        
        waittime(i) = waittime(i-1) + time;%waiting time summation 
        xwalk(i) = xwalk(i-1) + xstep;%step x summation
        ywalk(i) = ywalk(i-1) + ystep;%step y summation
        average(i) = sqrt( xwalk(i)^2 + ywalk(i)^2);%geting the average
    end 
    %resizing all the arrays once 200 time increments is reached
    waittime = waittime(~isnan(waittime));
    average = average(~isnan(average));
    xwalk = xwalk(~isnan(xwalk));
    ywalk = ywalk(~isnan(ywalk));
   
end 
%Weighted Linear Conrugential Generator
%Wating Times 
function step = waitingTime(n, spot)
    %park-miller numbers
    a = 7^5;
    c = 0;
    m = (2^31)-1;
    r= zeros(1, n);%random number array
    r(1) = 1;
    for i = 2:n
       seed = r(i-1)^3 / 18.42 + 1; %Linear Congruential Generator
       r(i) = mod(a*seed+c,m);
    end
    r = r./m;
    %expanding the base of numbers to 5
    r = ceil(r*5);
    for i = 1:n
        if 1<=r(i) && 3<= r(i)
            r(i) = 1;
        elseif 4<=r(i) && 5<=r(i)
            r(i) = 2;
        end 
    end 
    step = r(spot);
end 
%Linear Congruntial Generator
%for Step sizes
function step =  stepsize(n, spot)
    %park-miller numbers
    a = 7^5;
    c = 0;
    m = (2^31)-1;
    r= zeros(1, n);%random number array
    r(1) = 1;
    for i = 2:n
       seed = r(i-1)^3 / 18.42 + 1; %Linear Congruential Generator
       r(i) = mod(a*seed+c,m);
    end
    r = r./m;
   
    %expanding the base of numbers to 5
    r = ceil(r*8);
    
    for i = 1:n
        if 1<=r(i) && 2>= r(i)
            r(i) = -2;
        elseif 3<=r(i) && 4>=r(i)
            r(i) = -1;
        elseif 5<=r(i) && 6>=r(i)
            r(i) = 1;
        else
            r(i) = 2;
        end 
    end 
    step = r(spot);
 
end

%function of the Single Random Walker for Part C
function [average, xwalk, ywalk, waittime] = randwalkerC
    N = 200; %set number of iterations
    %creating the array
    xwalk = NaN(1, N);
    ywalk = NaN(1, N);
    average = NaN(1, N);
    waittime = NaN(1,N);
    ysteps = NaN(1, N-1);
    xsteps = NaN(1, N-1);
    %setting the intial position and time
    waittime(1) = 0;
    xwalk(1) = 0;
    ywalk(1) = 0;
    average(1) = 0;
    i = 1;
    while(waittime(i) < 200)
        i = i + 1;
        ynum = randi(100);% random number selection 
        ystep = stepsize(100, ynum);%y step size
        xnum = randi(100);%random number
        xstep = stepsize(100, xnum);%x step size
        timenum = randi(100);% random number
        time  = waitingTime(100, timenum);%waiting time
        %checking if waiting time is 1
        %if so then persistance
     
        if i > 2
            if time == 1
            ynum = randi(100);% random number selection 
            ystep = stepsizeC(100, ynum, ysteps(i-2));%y step size
            xnum = randi(100);%random number
            xstep = stepsizeC(100, xnum, xsteps(i-2));%x step size
            end 
        end
        ysteps(i-1) = ystep;
        xsteps(i-1) = xstep;
        waittime(i) = waittime(i-1) + time;%waiting time summation 
        xwalk(i) = xwalk(i-1) + xstep;%step x summation
        ywalk(i) = ywalk(i-1) + ystep;%step y summation
        average(i) = sqrt( xwalk(i)^2 + ywalk(i)^2);%geting the average
        
    end 
    %resizing all the arrays once 200 time increments is reached
    waittime = waittime(~isnan(waittime));
    average = average(~isnan(average));
    xwalk = xwalk(~isnan(xwalk));
    ywalk = ywalk(~isnan(ywalk));
end 

%Linear Congruntial Generator
%for Step sizes in Part C if Wait Time is 1
function step =  stepsizeC(n, spot, last)
    %array of step sizes
    num = [1, 2 , -1, -2];
    newnum = zeros(1, 4);%new array space
    newnum(1) = last;%first spot is desired number
    for i = 2:4
        %filling rest of array with the other numbers
        if num(i) ~= last && num(i) ~= newnum(i)
            newnum(i) = num(i);
        end
        %has chance to not include 1 but gives zero in the last spot so we
        %add in 1
        if newnum(i) == 0
            newnum(i) = 1;
        end 
    end
    %park-miller numbers
    a = 7^5;
    c = 0;
    m = (2^31)-1;
    r= zeros(1, n);%random number array
    r(1) = 1;
    for i = 2:n
       seed = r(i-1)^3 / 18.42 + 1; %Linear Congruential Generator
       r(i) = mod(a*seed+c,m);
    end
    r = r./m;
   
    %expanding the base of numbers to 7
    r = ceil(r*7);
    
    for i = 1:n
        %persitance 
        if 1<=r(i) && 4>= r(i)
            r(i) = newnum(1);
        elseif 4<=r(i) && 5>=r(i)
            r(i) = newnum(2);
        elseif 5<=r(i) && 6>=r(i)
            r(i) = newnum(3);
        elseif 6<=r(i) && 7>=r(i)
            r(i) = newnum(4);
        end 
    end 
    step = r(spot);
 
end

%Part D with random particle split 
function [ average, xwalk, ywalk, waittime] = randwalkerD
    N = 200; %set number of iterations
    Max = 50; %max number of particles allowed
    np = 1; %intial number of particles
    %creating the array
    xwalk = NaN(Max,N);
    ywalk = NaN(Max, N);
    average = NaN(Max, N);
    waittime = NaN(Max,N);
    %setting the intial position and time
    xwalk(:, 1) = 0;
    ywalk(:, 1) = 0;
    average(:, 1) = 0;
    waittime(:, 1) = 0;
    j = 1;
    while( j <= np)
        i = 1;
        split = 0;
        
        while ( waittime(i) < 200)
            i = i + 1;
            ynum = randi(100);% random number selection 
            ystep = stepsize(100, ynum);%y step size
            xnum = randi(100);%random number
            xstep = stepsize(100, xnum);%x step size
            timenum = randi(100);% random number
            time  = waitingTime(100, timenum);%waiting time
            
            waittime(j, i) = waittime(j, i-1) + time;%waiting time summation 
            xwalk(j, i) = xwalk(j, i-1) + xstep;%step x summation
            ywalk(j, i) = ywalk(j, i-1) + ystep;%step y summation
            average(j, i) = sqrt( xwalk(j, i)^2 + ywalk(j, i)^2);%geting the average
            %Particle Splitting
            x = rand;
            if x < 0.12
                %adds to split number
                split = split + 1;
                num = np + 1;
                %sets all the values of the new starting particle to be the
                %same as the last
                xwalk(np, 1) = xwalk(j, i);
                ywalk(np, 1) = ywalk(j, i);
                average(np, 1) = average(j, i);
                %waittime(np, 1) = waittime(j, i);
            end
            %splitting condition
            if split == 10
                break
            end 
        end
        
        np = num;
        %setting the rest of the array if not then the pdf will not plot
        %due to NaN values
        %for k = i:200
           %xwalk(j, k) = xwalk(j, i);
           %ywalk(j, k) = ywalk(j, i);
           %average(j,k) = average(j, i);
           %waittime(j, k) = waittime(j, i);
        %end
        j= j+1;
        %Maximum Number  of Particles allowed
        if j == Max
            break 
        end 
    end
    
end 
