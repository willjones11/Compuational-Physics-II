N = [32 64 128];% lattice sizes
%32x32 Ising Model 
swising(N(1), 1)
%64x64 Ising Model 
swising(N(2), 2)
%128x128 Ising Model 
swising(N(3), 3)
function swising(n, fig) 
tic %starting time
%for loop for the number of monte carlo steps
for i = 1:10
    spins = [-1 1];%numbers for the lattice
    Lat = zeros(n,n);%intializing lattice
    %setting the lattcie up with spins
    for k=1:n
        for j =1:n
            Lat(k,j) = spins(randi(2));
        end 
    end
    
    %%%for finding all aligned spins 
    row = [];
    column = [];
    for r = 1:n
        for c = 1:n
            %if the spin is aligned with the neighbor to the left
            if r > 1 && Lat(r, c) == Lat(r-1, c)
                row = [row r];
                column = [column c];
            end 
            %checking if spin is aligned to neighbor to the right 
            if r+1 <= n %%preventing error
                if Lat(r,c) == Lat(r+1, c)
                   row = [row r];
                   column = [column c];
                end 
            end
            %%checking if spin is aligned to neighbor above
            if c > 1 && Lat(r, c) == Lat(r, c-1)
                row = [row r];
                column = [column c];
            end 
           %%checking if spin is aligned to the neighbor below
           if c+1 <= n
               if Lat(r, c) == Lat(r, c+1)
                   row = [row r];
                   column = [column c];
               end 
           end 
        end 
    end 
    %drawing numbers to establish clusters 
    c1 = num1();
    c2 = num2();
    c3 = num1();
    c4 = num2();
    c5 = num1();
    c6 = num2();
    c7 = num1();
    c8 = num2();
    %makes the first two clusters
    for m=1:floor(length(row)/2)
        if prob() == 1
            if Lat(row(m), column(m)) == -1
                Lat(row(m), column(m)) = c1;
            elseif Lat(row(m), column(m)) == 1
                Lat(row(m), column(m)) = c2;
            end
        end
    end
    %for 3rd and 4th cluster   
         
    for m=ceil((length(row)/2)):length(row)
        if prob() == 1
            if Lat(row(m), column(m)) == -1
                Lat(row(m), column(m)) = c3;
            elseif Lat(row(m), column(m)) == 1
                Lat(row(m), column(m)) = c4;
            end
        end
    end
    %creates the 5th and 6th cluster
    for p = 1:floor(n/2)
        for o = 1:n/2
            if Lat(p, o) == -1
                Lat(p, o) = c5;
            elseif Lat(p, o) == 1
                Lat(p, o) = c6;
            end
        end
    end 
    %creates 7th and 8th cluster
    for p = ceil((n/2)):n
        for o = (n/2 +1):n
            if Lat(p, o) == -1
                Lat(p, o) = c5;
            elseif Lat(p, o) == 1
                Lat(p, o) = c6;
            end
        end
    end 
    %flipping clusters with a half probability
    cf1 = rand;
    cf2 = rand;
    cf3 = rand;
    cf4 = rand;
    cf5 = rand;
    cf6 = rand;
    cf7 = rand; 
    cf8 = rand;
    for z=1:n
        for x=1:n
            %for first cluster
            Lat(z,x) = clflip1(Lat(z,x), cf1, c1);
            %for second cluster
            Lat(z,x) = clflip2(Lat(z,x), cf2, c2);
            %for third cluster
            Lat(z,x) = clflip1(Lat(z,x), cf3, c3);
            %for fourth cluster
            Lat(z,x) = clflip2(Lat(z,x), cf4, c4);
            %for fifth cluster
            Lat(z,x) = clflip1(Lat(z,x), cf5, c5);
            %for sixth cluster
            Lat(z,x) = clflip2(Lat(z,x), cf6, c6);
            %for seventh cluster
            Lat(z,x) = clflip1(Lat(z,x), cf7, c7);
            %for eigth cluster
            Lat(z,x) = clflip2(Lat(z,x), cf8, c8);
            
        end
    end
end

        
figure(fig)
for r= 1:2
    for c=1:2
       if Lat(r,c) == -1
           scatter(r, c, 'red')
       elseif Lat(r,c) == 1
           scatter(r, c, 'blue')
       end
       hold on
    end 
end 
hold off 
xlabel('row')
ylabel('column')
if n == 64
    title('64x64 Ising Model')
elseif n == 32
    title('32x32 Ising Model')
elseif n ==128
    title('128x128 Ising Model')
end 
%getting total funciton  time
fprintf('The time of the %d by %d lattice is %f secs\n', n, n,  toc)
end
%for probaility of flipping
function x = prob()
x = rand;
if x > 0.10
    x = 0;
else
    x = 1;
end 

end
%establising even number to make cluster
function num = num1()
    for i =1:1000
        num = randi(10000);
        if mod(num,2) == 0
            break 
        end
    end 
    
    
end
%establising a odd number to make cluster
function num = num2()
    for i =1:1000
        num = randi(10000);
        if mod(num,2) == 1
            break 
        end
    end 
end
%for cluster flipping num1 clusters
function Lat = clflip1( Lat, cf, c)
     if cf < 0.5
        if Lat == c
            Lat = -1;
        else 
            Lat = 1;
        end
     end 
end
%cluster flipping num2 clusters
function Lat = clflip2( Lat, cf, c)
     if cf < 0.5
        if Lat == c
            Lat = 1;
        else 
            Lat = -1;
        end
     end 
end