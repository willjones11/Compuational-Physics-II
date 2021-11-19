%{
Computational Physics II
William Jones 
Modeling 2D Brownian Walks of Particles in a Box
%}
np = 1000; %number of particles
N =3000; %number of steps
step = [ -1 1];%different steps it can take
%setting the sizes of the arrays
ywalk = zeros(N,1);
xwalk = zeros(N,1);
xwalks = NaN(N, np);
ywalks = NaN(N, np);
for i = 1:np
    y = 0;
    x = 0;
    for j = 2:N
        if j == N
            disp('No HIT')
        end 
        cond = 0;
        yr = randi(2);%random number 1 or 2
        y = step(yr);%picking the number to use 
        xr = randi(2);%same as above
        x = step(xr);
        ywalk(j) =ywalk(j-1) + y;%adding the number choosen to the previous step and storing value
        xwalk(j) = xwalk(j-1) + x;
        %combining the particles paths to this array
        xwalks(j, i) = xwalk(j);
        ywalks(j, i) = ywalk(j);
        %limit conditions if hits wall
        if ywalk(j) == 49
            
            break;
        elseif ywalk(j) == -49
            
            break;
        end 
        if xwalk(j) == 49
            
            break;
        elseif xwalk(j) == -49
           
            break;
        end
        
        if i > 1 %not the first particle
                for k = 1:i-1 %for all the particles up til before current
                    %condense says if particles are next to each other
                    xp1 = ( xwalks(length(xwalks(:, k)) - sum(isnan(xwalks(:, k))), k)+ 1);
                    xs1 = (xwalks(length(xwalks(:, k)) - sum(isnan(xwalks(:, k))), k) - 1 );
                    yp1 = (ywalks(length(ywalks(:, k)) - sum(isnan(ywalks(:, k))), k) + 1);
                    ys1 = (ywalks(length(ywalks(:, k)) - sum(isnan(ywalks(:, k))), k) - 1 );
                    if (xwalk(j) == xp1) || (xwalk(j) == xs1)
                        if (ywalk(j) == yp1) || (ywalk(j) == ys1)
                            cond = 1;%sets condition to let the next one know we need to end this step
                            disp('HIT')%lets me know if there was a hit
                            break
                        end 
                    end 
                end
                %if particle was next to another then kicks out of step
                if cond == 1
                    break
                end
        end
    end 
 disp(i)%lets me know what particle the run is on
 %for the pdf later 
 if i == 1
    xwalkpdf = xwalk;
    ywalkpdf = ywalk;
 end 
end 
cmap = hsv(1); % color set for the plot
figure(1)
%plotting each individual plot 
for k=1:np
max = length(ywalks(:, k)) - sum(isnan(ywalks(:, k)));
plot(xwalks(:,k),ywalks(:,k),'Marker', '.','MarkerEdgeColor', 'k',  'MarkerSize', 12, 'MarkerIndices', [1 max]);
%p = plot(xwalks(:,k),ywalks(:,k), 'Color',cmap(k,:));
hold all;
end
%graph limits
xlim([-50 50]);
ylim([-50 50]);
%creating labels 
xlabel('x');
ylabel('y');
title('Assignment 5.2');
grid on;
hold off
%creating the pdf 
[x1, y1] = meshgrid(xwalkpdf, ywalkpdf);
X = [x1(:) y1(:)];
y = mvnpdf(X, [0], [49 1; 1 49]);%bivariate pdf
y = reshape(y, length(ywalkpdf), length(xwalkpdf));
figure(2)
surf(xwalkpdf, ywalkpdf, y);%surface plotting 
caxis('auto');
xlabel('x');
ylabel('y');
zlabel('%');
