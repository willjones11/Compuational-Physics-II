
np = 150; %number of particles

N = 500; %number of steps
step = [ -1 1];%different steps it can take
%setting the sizes of the arrays
ywalk = zeros(1,N);
xwalk = zeros(1,N);
xwalks = zeros(N, np);
ywalks = zeros(N, np);
for i = 1:np
    y = 0;
    x = 0;
    for j = 2:N
        yr = randi(2);%random number 1 or 2
        y = step(yr);%picking the number to use 
        xr = randi(2);%same as above
        x = step(xr);
        ywalk(j) =ywalk(j-1) + y;%adding the number choosen to the previous step and storing value
        xwalk(j) = xwalk(j-1) + x;
        %limit conditions 
        if ywalk(j) == 50
            ywalk(j) = ywalk(j) - 1;
        elseif ywalk(j) == -50
            ywalk(j) = ywalk(j) + 1;
        end 
        if xwalk(j) == 50
            xwalk(j) = xwalk(j) - 1;
        elseif xwalk(j) == -50
            xwalk(j) = xwalk(j) + 1;
        end
        %combining the particles paths to this array
        xwalks(j, i) = xwalk(j);
        ywalks(j, i) = ywalk(j);
    end 
    
 end 
cmap = hsv(np); % color set for the plot
figure(1)
%plotting each individual plot 
for k=1:np

plot(xwalks(:,k),ywalks(:,k),'Marker', '.','MarkerEdgeColor', 'k',  'MarkerSize', 12, 'MarkerIndices', [1 N], 'Color',cmap(k,:));
%p = plot(xwalks(:,k),ywalks(:,k), 'Color',cmap(k,:));
hold on;
end
%graph limits
xlim([-50 50]);
ylim([-50 50]);
%creating labels 
xlabel('i');
ylabel('j');
title('Assignment 5.1');
grid on;
hold off
%Creating pdf
forpdf = [10 20 50 100 200 500];
for i = 1:6
    %turning them all to 1 dimensional array
       xwalkpdf = reshape(xwalks(forpdf(i), :), [], 1);
       ywalkpdf = reshape(ywalks(forpdf(i), :), [], 1);
    %setting the array for distance 
    prob = zeros(length(xwalkpdf), 1);
    %finding the distance from center
    for k = 1:length(xwalkpdf)
        prob(k) = sqrt((xwalkpdf(k)^2) + (ywalkpdf(k)^2)); 
    end
        %creating and plotting the pdf
        rng('default')
        [f, points] = ksdensity(prob);
        figure(i+1)
        plot(points, f);
        xlabel('distance')
        ylabel('%');
        %creating the array title4
        if i == 1
           title('PDF after 10 steps');
        elseif i == 2
           title('PDF after 20 steps');
        elseif i == 3
            title('PDF after 50 steps');
        elseif i == 4
            title('PDF after 100 steps');
        elseif i == 5
            title('PDF after 200 steps');
        elseif i == 6
            title('PDF after 500 steps');
        end 
end

%animation of the code
figure(8)
%plotting each individual plot 
for k=1:np

comet(xwalks(:,k),ywalks(:,k));
hold on
%graph limits
xlim([-50 50]);
ylim([-50 50]);
%creating labels 
xlabel('x');
ylabel('y');
title('Assignment 5.1');
grid on;
hold off
end

